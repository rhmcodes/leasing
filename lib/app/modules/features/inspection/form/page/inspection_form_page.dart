import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../../core/constants/app_enum.dart';
import '../../../../../core/helpers/autosave_helper.dart';
import '../../../../../core/helpers/camera_helper.dart';
import '../../../../../core/helpers/connectivity_helper.dart';
import '../../../../../core/helpers/fake_gps_helper.dart';
import '../../../../../core/helpers/image_compress_helper.dart';
import '../../../../../core/helpers/location_helper.dart';
import '../../../../../core/helpers/photo_watermark_helper.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/validators/inspection_validator.dart';
import '../../../../../data/datasources/local/autosave_local_datasource.dart';
import '../../../../../data/datasources/local/inspection_local_datasource.dart';
import '../../../../../data/datasources/local/sync_local_datasource.dart';
import '../../../../../data/models/inspection/inspection_draft_model.dart';
import '../../../../../data/models/inspection/inspection_location_model.dart';
import '../../../../../data/models/inspection/inspection_metadata_model.dart';
import '../../../../../data/models/inspection/inspection_model.dart';
import '../../../../../data/models/inspection/inspection_photo_model.dart';
import '../../../../../data/models/inspection/inspection_signature_model.dart';
import '../../../../../data/models/inspection/sync_queue_model.dart';
import '../../../../../shared/widgets/app_back_button.dart';
import '../../../../../shared/widgets/app_brand_header.dart';
import '../../../../../shared/widgets/app_dropdown_field.dart';
import '../../../../../shared/widgets/app_surface.dart';
import '../../../../../shared/widgets/app_text_field.dart';
import '../widget/inspection_photo_section.dart';
import '../widget/inspection_signature_section.dart';

class InspectionFormPage extends StatefulWidget {
  const InspectionFormPage({
    super.key,
    this.showBackButton = true,
  });

  final bool showBackButton;

  @override
  State<InspectionFormPage> createState() => _InspectionFormPageState();
}

class _InspectionFormPageState extends State<InspectionFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AutosaveHelper _autosaveHelper = AutosaveHelper();

  final AutosaveLocalDatasource _autosaveLocalDatasource =
      const AutosaveLocalDatasource();
  final InspectionLocalDatasource _inspectionLocalDatasource =
      const InspectionLocalDatasource();
  final SyncLocalDatasource _syncLocalDatasource = const SyncLocalDatasource();

  final TextEditingController _plateController = TextEditingController();
  final TextEditingController _kilometerController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _unableReasonController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String? _exteriorCondition;
  String? _engineCondition;
  bool _canBeMoved = true;
  bool _debtorPhotoConfirmed = false;
  bool _isSigningSignature = false;
  bool _loadingLocation = false;
  bool _submitting = false;

  InspectionLocationModel? _location;
  final Map<InspectionPhotoType, InspectionPhotoModel> _photos =
      <InspectionPhotoType, InspectionPhotoModel>{};
  String? _signatureData;

  @override
  void initState() {
    super.initState();
    _loadAutosaveSnapshot();
  }

  @override
  void dispose() {
    _autosaveHelper.dispose();
    _plateController.dispose();
    _kilometerController.dispose();
    _addressController.dispose();
    _unableReasonController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _loadAutosaveSnapshot() async {
    final Map<String, dynamic>? snapshot =
        await _autosaveLocalDatasource.getSnapshot();

    if (!mounted || snapshot == null) return;

    setState(() {
      _plateController.text = snapshot['plateNumber'] as String? ?? '';
      _kilometerController.text = snapshot['currentKilometer'] as String? ?? '';
      _addressController.text = snapshot['addressNote'] as String? ?? '';
      _unableReasonController.text = snapshot['unableMoveReason'] as String? ?? '';
      _noteController.text = snapshot['additionalNote'] as String? ?? '';
      _exteriorCondition = snapshot['exteriorCondition'] as String?;
      _engineCondition = snapshot['engineCondition'] as String?;
      _canBeMoved = snapshot['canBeMoved'] as bool? ?? true;
      _debtorPhotoConfirmed = snapshot['debtorPhotoConfirmed'] as bool? ?? false;
    });
  }

  Map<String, dynamic> _buildSnapshot() {
    return <String, dynamic>{
      'plateNumber': InspectionValidator.normalizePlate(_plateController.text),
      'exteriorCondition': _exteriorCondition,
      'engineCondition': _engineCondition,
      'currentKilometer': _kilometerController.text.trim(),
      'addressNote': _addressController.text.trim(),
      'canBeMoved': _canBeMoved,
      'unableMoveReason': _unableReasonController.text.trim(),
      'additionalNote': _noteController.text.trim(),
      'debtorPhotoConfirmed': _debtorPhotoConfirmed,
      'photoCount': _photos.length,
      'hasSignature': _signatureData != null && _signatureData!.isNotEmpty,
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }

  void _scheduleAutosave() {
    _autosaveHelper.schedule(() async {
      await _autosaveLocalDatasource.saveSnapshot(_buildSnapshot());
      if (!mounted) return;
      debugPrint('Autosave inspection form snapshot saved');
    });
  }

  Future<void> _getLocation() async {
    setState(() => _loadingLocation = true);

    try {
      final Position position = await LocationHelper.getCurrentPosition();
      final List<String> warnings = FakeGpsHelper.inspect(position);

      setState(() {
        _location = InspectionLocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
          addressNote: _addressController.text.trim(),
          accuracy: position.accuracy,
          isMocked: position.isMocked,
          fakeGpsWarnings: warnings,
        );
      });
      _scheduleAutosave();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    } finally {
      if (mounted) setState(() => _loadingLocation = false);
    }
  }

  Future<void> _capturePhoto(InspectionPhotoType type) async {
    try {
      final image = await CameraHelper.captureFromCamera(
        imageQuality: 85,
        maxWidth: 1600,
        maxHeight: 1600,
      );

      if (image == null) return;

      final File compressed = await ImageCompressHelper.compress(File(image.path));
      final Position position = await LocationHelper.getCurrentPosition();
      final List<String> warnings = FakeGpsHelper.inspect(position);

      final InspectionMetadataModel metadata = InspectionMetadataModel(
        latitude: position.latitude,
        longitude: position.longitude,
        timestamp: DateTime.now(),
        surveyorName: 'Surveyor NSS',
        accuracy: position.accuracy,
        address: _addressController.text.trim(),
        fakeGpsWarnings: warnings,
      );

      final String watermarkText = PhotoWatermarkHelper.buildWatermarkText(
        latitude: metadata.latitude,
        longitude: metadata.longitude,
        timestamp: metadata.timestamp,
        surveyorName: metadata.surveyorName,
      );

      setState(() {
        _photos[type] = InspectionPhotoModel(
          type: type.name,
          localPath: compressed.path,
          metadata: metadata,
          watermarkText: watermarkText,
        );
      });

      _scheduleAutosave();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
  }

  bool _validatePhotos() {
    return InspectionPhotoType.values.every(
      (InspectionPhotoType type) => _photos.containsKey(type),
    );
  }

  InspectionModel _buildInspectionModel() {
    final DateTime now = DateTime.now();
    final InspectionLocationModel location = _location!;

    return InspectionModel(
      id: 'INS-${now.millisecondsSinceEpoch}',
      surveyorName: 'Surveyor NSS',
      plateNumber: InspectionValidator.normalizePlate(_plateController.text),
      exteriorCondition: _exteriorCondition!,
      engineCondition: _engineCondition!,
      currentKilometer: int.parse(_kilometerController.text.trim()),
      location: InspectionLocationModel(
        latitude: location.latitude,
        longitude: location.longitude,
        addressNote: _addressController.text.trim(),
        accuracy: location.accuracy,
        isMocked: location.isMocked,
        fakeGpsWarnings: location.fakeGpsWarnings,
      ),
      photos: _photos.values.toList(),
      canBeMoved: _canBeMoved,
      unableMoveReason:
          _canBeMoved ? null : _unableReasonController.text.trim(),
      additionalNote: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
      signature: InspectionSignatureModel(
        localPath: 'signature_canvas_${now.millisecondsSinceEpoch}',
        createdAt: now,
        signatureData: _signatureData,
      ),
      createdAt: now,
    );
  }

  Future<void> _submit() async {
    final bool formValid = _formKey.currentState?.validate() ?? false;

    if (!formValid) return;

    if (_location == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lokasi kendaraan wajib diambil')),
      );
      return;
    }

    if (!_validatePhotos()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua 5 foto wajib diambil')),
      );
      return;
    }

    if (_signatureData == null || _signatureData!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tanda tangan wajib diisi')),
      );
      return;
    }

    if (!_debtorPhotoConfirmed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Konfirmasi foto kendaraan/debitur wajib dicentang'),
        ),
      );
      return;
    }

    setState(() => _submitting = true);

    try {
      final InspectionModel data = _buildInspectionModel();
      await _inspectionLocalDatasource.saveDraft(
        InspectionDraftModel(
          id: data.id,
          updatedAt: DateTime.now(),
          data: data,
        ),
      );

      final bool online = await ConnectivityHelper.hasConnection();

      if (!online) {
        await _syncLocalDatasource.addToQueue(
          SyncQueueModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            inspectionId: data.id,
            status: 'pending',
            createdAt: DateTime.now(),
          ),
        );
      }

      await _autosaveLocalDatasource.clearSnapshot();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            online
                ? 'Data inspeksi valid dan tersimpan. Siap dikirim ke server.'
                : 'Offline: data tersimpan dan masuk antrean sync.',
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan inspeksi: $error')),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.screenGradient),
        child: SafeArea(
          child: Form(
            key: _formKey,
            onChanged: _scheduleAutosave,
            child: ListView(
              physics: _isSigningSignature
                  ? const NeverScrollableScrollPhysics()
                  : null,
              padding: AppSpacing.screen(context),
              children: <Widget>[
                if (widget.showBackButton) ...<Widget>[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: AppBackButton(),
                  ),
                  context.gapV16,
                ],
                const AppBrandHeader(
                  title: 'Inspeksi Kendaraan',
                  subtitle:
                      'Lengkapi data kendaraan, lokasi, foto, dan tanda tangan.',
                  icon: Icons.fact_check_outlined,
                ),
                context.gapV24,
                Text(
                  'Data kendaraan',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                context.gapV12,
                AppTextField(
                  controller: _plateController,
                  label: 'Nomor Polisi',
                  hint: 'B 1234 ABC',
                  textInputAction: TextInputAction.next,
                  validator: InspectionValidator.plateNumber,
                ),
                context.gapV16,
                AppDropdownField(
                  label: 'Kondisi Eksterior',
                  value: _exteriorCondition,
                  items: const <String>[
                    'Baik',
                    'Lecet Ringan',
                    'Rusak',
                    'Sangat Rusak',
                  ],
                  validator: InspectionValidator.required,
                  onChanged: (String? value) {
                    setState(() => _exteriorCondition = value);
                    _scheduleAutosave();
                  },
                ),
                context.gapV16,
                AppDropdownField(
                  label: 'Kondisi Mesin',
                  value: _engineCondition,
                  items: const <String>[
                    'Hidup Normal',
                    'Hidup Tidak Normal',
                    'Mati',
                  ],
                  validator: InspectionValidator.required,
                  onChanged: (String? value) {
                    setState(() => _engineCondition = value);
                    _scheduleAutosave();
                  },
                ),
                context.gapV16,
                AppTextField(
                  controller: _kilometerController,
                  label: 'Kilometer Saat Ini',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: InspectionValidator.kilometer,
                ),
                context.gapV16,
                AppTextField(
                  controller: _addressController,
                  label: 'Keterangan Alamat Lokasi',
                  validator: InspectionValidator.required,
                ),
                context.gapV12,
                ElevatedButton.icon(
                  onPressed: _loadingLocation ? null : _getLocation,
                  icon: _loadingLocation
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.my_location),
                  label: Text(
                    _location == null
                        ? 'Ambil GPS Otomatis'
                        : 'GPS Sudah Diambil',
                  ),
                ),
                if (_location != null) ...<Widget>[
                  context.gapV8,
                  Text(
                    'Lat: ${_location!.latitude}, '
                    'Lng: ${_location!.longitude}, '
                    'Accuracy: ${_location!.accuracy?.toStringAsFixed(1) ?? '-'}m',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (_location!.fakeGpsWarnings.isNotEmpty)
                    Text(
                      _location!.fakeGpsWarnings.join('\n'),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.error),
                    ),
                ],
                context.gapV16,
                AppSurface(
                  color: AppColors.surface,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Kendaraan Bisa Dipindahkan',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            context.gapV4,
                            Text(
                              _canBeMoved ? 'Ya' : 'Tidak',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: _canBeMoved,
                        onChanged: (bool value) {
                          setState(() => _canBeMoved = value);
                          _scheduleAutosave();
                        },
                      ),
                    ],
                  ),
                ),
                if (!_canBeMoved) ...<Widget>[
                  context.gapV16,
                  AppTextField(
                    controller: _unableReasonController,
                    label: 'Alasan Tidak Bisa Dipindahkan',
                    maxLines: 3,
                    validator: (String? value) =>
                        InspectionValidator.unableMoveReason(
                      canBeMoved: _canBeMoved,
                      value: value,
                    ),
                  ),
                ],
                context.gapV16,
                AppTextField(
                  controller: _noteController,
                  label: 'Catatan Tambahan',
                  maxLines: 3,
                ),
                context.gapV24,
                InspectionPhotoSection(
                  photos: _photos,
                  onCapture: _capturePhoto,
                ),
                context.gapV16,
                AppSurface(
                  color: AppColors.surface,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                        value: _debtorPhotoConfirmed,
                        onChanged: (bool? value) {
                          setState(
                            () => _debtorPhotoConfirmed = value ?? false,
                          );
                          _scheduleAutosave();
                        },
                      ),
                      context.gapH8,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Validasi Foto Debitur/Kendaraan',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            context.gapV4,
                            Text(
                              'Sistem menggunakan konfirmasi ini untuk menandai '
                              'foto kendaraan/debitur sudah sesuai dengan data '
                              'inspeksi.',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                context.gapV24,
                InspectionSignatureSection(
                  signatureData: _signatureData,
                  onDrawingStateChanged: (bool value) {
                    setState(() => _isSigningSignature = value);
                  },
                  onChanged: (String? value) {
                    setState(() => _signatureData = value);
                    _scheduleAutosave();
                  },
                ),
                context.gapV24,
                ElevatedButton(
                  onPressed: _submitting ? null : _submit,
                  child: Text(_submitting ? 'Menyimpan...' : 'Submit Inspeksi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

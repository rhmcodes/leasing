import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/utils/formatters.dart';
import '../../domain/repositories/inspection_repository.dart';
import '../controllers/inspection_form_controller.dart';
import '../widgets/photo_capture_card.dart';
import '../widgets/section_card.dart';
import '../widgets/signature_pad.dart';

class InspectionFormPage extends StatefulWidget {
  const InspectionFormPage({super.key, required this.repository});

  final InspectionRepository repository;

  @override
  State<InspectionFormPage> createState() => _InspectionFormPageState();
}

class _InspectionFormPageState extends State<InspectionFormPage> {
  late final InspectionFormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = InspectionFormController(repository: widget.repository);
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Inspeksi Kendaraan Leasing'),
            actions: [
              IconButton(
                tooltip: 'Isi data dummy',
                onPressed: _controller.isLoading
                    ? null
                    : _controller.fillWithDummyData,
                icon: const Icon(Icons.auto_fix_high_outlined),
              ),
              IconButton(
                tooltip: 'Reset draft',
                onPressed: _controller.isLoading
                    ? null
                    : _controller.resetDraft,
                icon: const Icon(Icons.restart_alt),
              ),
            ],
          ),
          body: _controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Form(
                    key: _controller.formKey,
                    autovalidateMode: _controller.showValidation
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
                      children: [
                        _buildTopStatus(context),
                        const SizedBox(height: 16),
                        SectionCard(
                          title: 'Identitas Inspeksi',
                          subtitle:
                              'Masukkan nomor polisi, kilometer, dan lokasi kendaraan.',
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _controller.policeNumberController,
                                textCapitalization:
                                    TextCapitalization.characters,
                                decoration: const InputDecoration(
                                  labelText: 'Nomor Polisi',
                                  hintText: 'Contoh: B 1234 XYZ',
                                ),
                                validator: _controller.policeNumberValidator,
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: _controller.odometerController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: const InputDecoration(
                                  labelText: 'Kilometer',
                                  hintText: 'Masukkan angka kilometer',
                                ),
                                validator: _controller.odometerValidator,
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller:
                                    _controller.vehicleLocationController,
                                decoration: const InputDecoration(
                                  labelText: 'Lokasi Kendaraan',
                                  hintText:
                                      'Contoh: Pool Leasing Jakarta Selatan',
                                ),
                                validator: _controller.locationValidator,
                                maxLines: 2,
                                minLines: 1,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        SectionCard(
                          title: 'Foto Wajib',
                          subtitle:
                              'Semua foto harus tersedia. Metadata GPS dan timestamp disimpan pada tiap foto.',
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                _controller.requiredPhotoCategories.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisSpacing: 12,
                                  mainAxisExtent: 246,
                                ),
                            itemBuilder: (context, index) {
                              final category =
                                  _controller.requiredPhotoCategories[index];
                              final photo = _controller.photos[category];
                              return PhotoCaptureCard(
                                category: category,
                                photo: photo,
                                errorText: _controller.photoError(category),
                                onCapture: () =>
                                    _controller.captureDummyPhoto(category),
                                onRemove: photo == null
                                    ? null
                                    : () => _controller.removePhoto(category),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        SectionCard(
                          title: 'Kondisi Pemindahan',
                          subtitle:
                              'Saat memilih tidak, alasan tetap dicatat dan tanda tangan menjadi wajib.',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kendaraan bisa dipindahkan?',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(height: 12),
                              SegmentedButton<bool>(
                                showSelectedIcon: false,
                                segments: const [
                                  ButtonSegment<bool>(
                                    value: true,
                                    label: Text('Ya'),
                                    icon: Icon(Icons.local_shipping_outlined),
                                  ),
                                  ButtonSegment<bool>(
                                    value: false,
                                    label: Text('Tidak'),
                                    icon: Icon(Icons.block_outlined),
                                  ),
                                ],
                                selected: <bool>{_controller.canBeMoved},
                                onSelectionChanged: (selection) {
                                  _controller.setCanBeMoved(selection.first);
                                },
                              ),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 220),
                                child: _controller.canBeMoved
                                    ? const SizedBox.shrink()
                                    : Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: TextFormField(
                                          key: const ValueKey(
                                            'cannot-move-reason',
                                          ),
                                          controller: _controller
                                              .cannotMoveReasonController,
                                          maxLines: 3,
                                          decoration: const InputDecoration(
                                            labelText:
                                                'Alasan Tidak Bisa Dipindahkan',
                                            hintText:
                                                'Contoh: rem blong, ban pecah, akses sempit',
                                          ),
                                          validator:
                                              _controller.reasonValidator,
                                        ),
                                      ),
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller:
                                    _controller.additionalNotesController,
                                maxLines: 4,
                                decoration: const InputDecoration(
                                  labelText: 'Catatan Tambahan',
                                  hintText:
                                      'Tambahkan observasi lain bila diperlukan',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        SectionCard(
                          title: 'Tanda Tangan Digital',
                          subtitle:
                              'Canvas berjalan lokal dan ikut masuk ke draft autosave.',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _controller.requiresSignature
                                    ? 'Status: wajib karena kendaraan tidak bisa dipindahkan.'
                                    : 'Status: opsional selama kendaraan masih bisa dipindahkan.',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 12),
                              SignaturePad(
                                initialPoints: _controller.signaturePoints,
                                errorText: _controller.signatureError,
                                onChanged: _controller.setSignaturePoints,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          onPressed: () async {
                            final messenger = ScaffoldMessenger.of(context);
                            final success = await _controller.submit();
                            if (!mounted) {
                              return;
                            }

                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(
                                  success
                                      ? 'Form inspeksi dummy berhasil divalidasi dan disimpan.'
                                      : 'Validasi gagal. Lengkapi field wajib terlebih dahulu.',
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.check_circle_outline),
                          label: const Text('Submit Form Dummy'),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildTopStatus(BuildContext context) {
    final theme = Theme.of(context);
    final lastUpdated = _controller.draft.updatedAt;

    return SectionCard(
      title: 'Status Draft',
      subtitle:
          'Autosave aktif dengan debounce agar tetap ringan di perangkat.',
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _controller.autosaveStatusText,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Update lokal terakhir ${formatDateTime(lastUpdated)}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Switch(
                value: _controller.isOnline,
                onChanged: _controller.setConnectivity,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withAlpha(140),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _controller.isOnline
                      ? 'Mode online: kompresi foto aktif saat autosave.'
                      : 'Mode offline: draft tersimpan lokal tanpa kompresi tambahan.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  _controller.metadataSummary,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

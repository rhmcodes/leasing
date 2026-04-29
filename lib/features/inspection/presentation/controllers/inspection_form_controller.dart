import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../app/utils/formatters.dart';
import '../../domain/entities/inspection_draft.dart';
import '../../domain/entities/inspection_photo.dart';
import '../../domain/entities/signature_point.dart';
import '../../domain/repositories/inspection_repository.dart';

class InspectionFormController extends ChangeNotifier {
  InspectionFormController({required InspectionRepository repository})
    : _repository = repository {
    policeNumberController.addListener(_onTextChanged);
    odometerController.addListener(_onTextChanged);
    vehicleLocationController.addListener(_onTextChanged);
    cannotMoveReasonController.addListener(_onTextChanged);
    additionalNotesController.addListener(_onTextChanged);
  }

  static const autosaveDelay = Duration(milliseconds: 700);

  final InspectionRepository _repository;
  final formKey = GlobalKey<FormState>();

  final policeNumberController = TextEditingController();
  final odometerController = TextEditingController();
  final vehicleLocationController = TextEditingController();
  final cannotMoveReasonController = TextEditingController();
  final additionalNotesController = TextEditingController();

  InspectionDraft _draft = InspectionDraft.initial();
  bool _isLoading = true;
  bool _showValidation = false;
  bool _isHydrating = false;
  bool _isSaving = false;
  bool _isDirty = false;
  bool _saveQueued = false;
  Timer? _autosaveTimer;

  bool get isLoading => _isLoading;
  bool get showValidation => _showValidation;
  bool get isSaving => _isSaving;
  bool get isDirty => _isDirty;
  InspectionDraft get draft => _draft;
  bool get canBeMoved => _draft.canBeMoved;
  bool get isOnline => _draft.isOnline;
  bool get requiresSignature => _draft.requiresSignature;
  Map<PhotoCategory, InspectionPhoto> get photos => _draft.photos;
  List<SignaturePoint> get signaturePoints => _draft.signaturePoints;
  bool get hasPoliceNumber => policeNumberController.text.trim().isNotEmpty;
  bool get hasOdometer => draft.odometerKm != null;
  bool get hasSignature => _draft.signaturePoints.isNotEmpty;
  bool get hasAllRequiredPhotos =>
      requiredPhotoCategories.every(_draft.photos.containsKey);

  List<PhotoCategory> get requiredPhotoCategories => PhotoCategory.values;
  int get totalRequiredItems => 7 + (requiresSignature ? 1 : 0);
  int get completedRequiredItems =>
      (hasPoliceNumber ? 1 : 0) +
      (hasOdometer ? 1 : 0) +
      _draft.photos.length.clamp(0, requiredPhotoCategories.length) +
      (requiresSignature && hasSignature ? 1 : 0);
  double get completionProgress {
    if (totalRequiredItems == 0) {
      return 0;
    }

    return completedRequiredItems / totalRequiredItems;
  }

  String get inspectionReference {
    final createdAt = _draft.createdAt;
    final year = createdAt.year.toString();
    final month = createdAt.month.toString().padLeft(2, '0');
    final day = createdAt.day.toString().padLeft(2, '0');
    final plate = policeNumberController.text.trim().replaceAll(' ', '');
    final suffix = plate.isEmpty ? 'DRAFT' : plate;
    return 'INSP-$year$month$day-$suffix';
  }

  String get movementStatusLabel =>
      canBeMoved ? 'Bisa dipindahkan' : 'Tidak bisa dipindahkan';

  String get signatureStatusLabel {
    if (!requiresSignature) {
      return hasSignature ? 'Sudah ada' : 'Opsional';
    }

    return hasSignature ? 'Sudah ada' : 'Masih wajib';
  }

  List<String> get missingRequirements {
    final missing = <String>[];
    if (!hasPoliceNumber) {
      missing.add('Nomor polisi');
    }
    if (!hasOdometer) {
      missing.add('Kilometer');
    }
    for (final category in requiredPhotoCategories) {
      if (!_draft.photos.containsKey(category)) {
        missing.add(category.label);
      }
    }
    if (requiresSignature && !hasSignature) {
      missing.add('Tanda tangan digital');
    }

    return missing;
  }

  String get autosaveStatusText {
    switch (_draft.saveState) {
      case DraftSaveState.idle:
        return 'Belum ada autosave';
      case DraftSaveState.autosavedOffline:
        return 'Draft tersimpan lokal ${_timeSuffix(_draft.lastAutosavedAt)}';
      case DraftSaveState.autosavedOnline:
        return 'Draft tersimpan online + kompresi ${_timeSuffix(_draft.lastAutosavedAt)}';
      case DraftSaveState.submitted:
        return 'Form dummy tersubmit ${_timeSuffix(_draft.lastAutosavedAt)}';
    }
  }

  String get metadataSummary {
    final totalPhotos = _draft.photos.length;
    if (totalPhotos == 0) {
      return 'Metadata GPS dan timestamp akan dibuat saat foto dummy diambil.';
    }

    final compressedCount = _draft.photos.values
        .where((photo) => photo.metadata.isCompressed)
        .length;
    return '$totalPhotos/5 foto tersimpan, $compressedCount sudah terkompresi.';
  }

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    _draft = await _repository.loadDraft();
    _hydrateControllers(_draft);
    _isDirty = false;

    _isLoading = false;
    notifyListeners();
  }

  void setConnectivity(bool value) {
    _draft = _snapshotDraft().copyWith(isOnline: value);
    _isDirty = true;
    notifyListeners();
    _scheduleAutosave();
  }

  void setCanBeMoved(bool value) {
    _draft = _snapshotDraft().copyWith(canBeMoved: value);
    if (value) {
      cannotMoveReasonController.clear();
    }
    _isDirty = true;
    notifyListeners();
    _scheduleAutosave();
  }

  void setSignaturePoints(List<SignaturePoint> points) {
    _draft = _snapshotDraft().copyWith(signaturePoints: points);
    _isDirty = true;
    notifyListeners();
    _scheduleAutosave();
  }

  void captureDummyPhoto(PhotoCategory category) {
    final updatedPhotos = Map<PhotoCategory, InspectionPhoto>.from(
      _draft.photos,
    );
    updatedPhotos[category] = _buildDummyPhoto(category);
    _draft = _snapshotDraft().copyWith(photos: updatedPhotos);
    _isDirty = true;
    notifyListeners();
    _scheduleAutosave();
  }

  void removePhoto(PhotoCategory category) {
    final updatedPhotos = Map<PhotoCategory, InspectionPhoto>.from(
      _draft.photos,
    );
    updatedPhotos.remove(category);
    _draft = _snapshotDraft().copyWith(photos: updatedPhotos);
    _isDirty = true;
    notifyListeners();
    _scheduleAutosave();
  }

  void fillWithDummyData() {
    _isHydrating = true;
    policeNumberController.text = 'B 1234 RAH';
    odometerController.text = '48215';
    vehicleLocationController.text = 'Pool Leasing Jakarta Selatan';
    cannotMoveReasonController.text = 'Aki lemah dan ban depan kiri kempis';
    additionalNotesController.text =
        'Unit perlu towing ringan. Dokumen fisik kendaraan tersedia.';
    _isHydrating = false;

    final seededPhotos = <PhotoCategory, InspectionPhoto>{
      for (final category in PhotoCategory.values)
        category: _buildDummyPhoto(category),
    };

    _draft = _snapshotDraft().copyWith(
      canBeMoved: false,
      photos: seededPhotos,
      signaturePoints: _dummySignature(),
    );

    _isDirty = true;
    notifyListeners();
    _scheduleAutosave();
  }

  Future<void> resetDraft() async {
    _autosaveTimer?.cancel();
    await _repository.clearDraft();
    _draft = InspectionDraft.initial();
    _hydrateControllers(_draft);
    _showValidation = false;
    _isDirty = false;
    notifyListeners();
  }

  Future<void> saveNow() async {
    _autosaveTimer?.cancel();
    await _performAutosave(force: true);
  }

  void showValidationErrors() {
    if (_showValidation) {
      return;
    }

    _showValidation = true;
    notifyListeners();
  }

  Future<bool> submit() async {
    _showValidation = true;
    notifyListeners();

    final formIsValid = formKey.currentState?.validate() ?? false;
    if (!formIsValid || !_passesBusinessValidation) {
      return false;
    }

    final submittedDraft = await _repository.submitDraft(_snapshotDraft());
    _draft = submittedDraft;
    _isDirty = false;
    notifyListeners();
    return true;
  }

  String? policeNumberValidator(String? value) {
    if (!_showValidation) {
      return null;
    }

    final cleaned = (value ?? '').trim();
    if (cleaned.isEmpty) {
      return 'Nomor polisi wajib diisi.';
    }

    return null;
  }

  String? odometerValidator(String? value) {
    if (!_showValidation) {
      return null;
    }

    final cleaned = (value ?? '').trim();
    if (cleaned.isEmpty) {
      return 'Kilometer wajib diisi.';
    }

    final parsed = int.tryParse(cleaned);
    if (parsed == null) {
      return 'Kilometer harus berupa angka.';
    }

    return null;
  }

  String? locationValidator(String? value) {
    return null;
  }

  String? reasonValidator(String? value) {
    return null;
  }

  String? photoError(PhotoCategory category) {
    if (!_showValidation) {
      return null;
    }

    if (_draft.photos.containsKey(category)) {
      return null;
    }

    return 'Foto wajib diisi.';
  }

  String? get signatureError {
    if (!_showValidation || !requiresSignature) {
      return null;
    }

    if (_draft.signaturePoints.isNotEmpty) {
      return null;
    }

    return 'Tanda tangan wajib jika kendaraan tidak bisa dipindahkan.';
  }

  @override
  void dispose() {
    _autosaveTimer?.cancel();
    policeNumberController.dispose();
    odometerController.dispose();
    vehicleLocationController.dispose();
    cannotMoveReasonController.dispose();
    additionalNotesController.dispose();
    super.dispose();
  }

  bool get _passesBusinessValidation {
    final requiredPhotosPresent = requiredPhotoCategories.every(
      _draft.photos.containsKey,
    );
    final signatureValid =
        !requiresSignature || _draft.signaturePoints.isNotEmpty;

    return requiredPhotosPresent && signatureValid;
  }

  void _onTextChanged() {
    if (_isHydrating) {
      return;
    }

    _draft = _snapshotDraft();
    _isDirty = true;
    notifyListeners();
    _scheduleAutosave();
  }

  void _scheduleAutosave() {
    _autosaveTimer?.cancel();
    _autosaveTimer = Timer(autosaveDelay, _performAutosave);
  }

  Future<void> _performAutosave({bool force = false}) async {
    if (!force && !_isDirty) {
      return;
    }

    if (_isSaving) {
      _saveQueued = true;
      return;
    }

    _isSaving = true;
    try {
      final savedDraft = await _repository.saveDraft(_snapshotDraft());
      _draft = savedDraft;
      _isDirty = false;
      notifyListeners();
    } finally {
      _isSaving = false;
      if (_saveQueued) {
        _saveQueued = false;
        unawaited(_performAutosave(force: true));
      }
    }
  }

  void _hydrateControllers(InspectionDraft draft) {
    _isHydrating = true;
    policeNumberController.text = draft.policeNumber;
    odometerController.text = draft.odometerKm?.toString() ?? '';
    vehicleLocationController.text = draft.vehicleLocation;
    cannotMoveReasonController.text = draft.cannotMoveReason;
    additionalNotesController.text = draft.additionalNotes;
    _isHydrating = false;
  }

  InspectionDraft _snapshotDraft() {
    final odometerText = odometerController.text.trim();
    return _draft.copyWith(
      policeNumber: policeNumberController.text.trim().toUpperCase(),
      odometerKm: odometerText.isEmpty ? null : int.tryParse(odometerText),
      clearOdometer: odometerText.isEmpty,
      vehicleLocation: vehicleLocationController.text.trim(),
      cannotMoveReason: cannotMoveReasonController.text.trim(),
      additionalNotes: additionalNotesController.text.trim(),
      updatedAt: DateTime.now(),
    );
  }

  InspectionPhoto _buildDummyPhoto(PhotoCategory category) {
    final capturedAt = DateTime.now().add(
      Duration(minutes: category.index * 3),
    );
    final latitude = -6.21462 + (category.index * 0.0007);
    final longitude = 106.84513 + (category.index * 0.0009);
    final baseColor = <int>[
      0xFF355070,
      0xFF0D5C63,
      0xFF6D597A,
      0xFFB56576,
      0xFF2D6A4F,
    ][category.index];
    final originalSize = 180 * 1024 + (category.index * 24 * 1024);
    final fileSlug = category.name.replaceAll('_', '-');

    return InspectionPhoto(
      category: category,
      fileName: '$fileSlug-${capturedAt.millisecondsSinceEpoch}.jpg',
      localPath: '/dummy/cache/$fileSlug.jpg',
      previewColorValue: baseColor,
      metadata: PhotoMetadata(
        latitude: latitude,
        longitude: longitude,
        capturedAt: capturedAt,
        watermarkText:
            '${latitude.toStringAsFixed(5)}, ${longitude.toStringAsFixed(5)} | ${formatDateTime(capturedAt)}',
        originalSizeBytes: originalSize,
        compressedSizeBytes: originalSize,
        isCompressed: false,
        storageMode: _draft.isOnline ? 'online-pending' : 'offline-local',
      ),
    );
  }

  List<SignaturePoint> _dummySignature() {
    const points = <List<double?>>[
      <double?>[24, 64],
      <double?>[48, 52],
      <double?>[84, 80],
      <double?>[116, 40],
      <double?>[148, 88],
      <double?>[null, null],
      <double?>[170, 86],
      <double?>[210, 48],
      <double?>[248, 92],
      <double?>[286, 60],
    ];

    return points
        .map(
          (item) => item.first == null || item.last == null
              ? const SignaturePoint.breakPoint()
              : SignaturePoint(x: item.first, y: item.last),
        )
        .toList(growable: false);
  }

  String _timeSuffix(DateTime? value) {
    if (value == null) {
      return '';
    }

    return 'pada ${formatDateTime(value)}';
  }
}

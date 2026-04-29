import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/inspection_draft.dart';
import '../../domain/entities/inspection_photo.dart';
import '../../domain/repositories/inspection_repository.dart';

class LocalInspectionRepository implements InspectionRepository {
  LocalInspectionRepository({Future<SharedPreferences>? preferences})
    : _preferences = preferences ?? SharedPreferences.getInstance();

  static const _draftKey = 'inspection_vehicle_draft';

  final Future<SharedPreferences> _preferences;

  @override
  Future<InspectionDraft> loadDraft() async {
    final preferences = await _preferences;
    final rawDraft = preferences.getString(_draftKey);
    if (rawDraft == null || rawDraft.isEmpty) {
      return InspectionDraft.initial();
    }

    return InspectionDraft.fromJson(
      jsonDecode(rawDraft) as Map<String, dynamic>,
    );
  }

  @override
  Future<InspectionDraft> saveDraft(InspectionDraft draft) async {
    final preferences = await _preferences;
    final now = DateTime.now();
    var nextDraft = draft.copyWith(
      updatedAt: now,
      lastAutosavedAt: now,
      saveState: draft.isOnline
          ? DraftSaveState.autosavedOnline
          : DraftSaveState.autosavedOffline,
    );

    if (draft.isOnline) {
      nextDraft = _compressPhotos(nextDraft);
    }

    await preferences.setString(_draftKey, jsonEncode(nextDraft.toJson()));

    return nextDraft;
  }

  @override
  Future<InspectionDraft> submitDraft(InspectionDraft draft) async {
    final preferences = await _preferences;
    final now = DateTime.now();
    final processedDraft = (draft.isOnline ? _compressPhotos(draft) : draft)
        .copyWith(
          updatedAt: now,
          lastAutosavedAt: now,
          saveState: DraftSaveState.submitted,
        );

    await preferences.setString(_draftKey, jsonEncode(processedDraft.toJson()));

    return processedDraft;
  }

  @override
  Future<void> clearDraft() async {
    final preferences = await _preferences;
    await preferences.remove(_draftKey);
  }

  InspectionDraft _compressPhotos(InspectionDraft draft) {
    if (draft.photos.isEmpty) {
      return draft;
    }

    final compressed = <PhotoCategory, InspectionPhoto>{};
    for (final entry in draft.photos.entries) {
      final photo = entry.value;
      final compressedSize = max(
        90 * 1024,
        (photo.metadata.originalSizeBytes * 0.62).round(),
      );

      compressed[entry.key] = photo.copyWith(
        metadata: photo.metadata.copyWith(
          compressedSizeBytes: compressedSize,
          isCompressed: true,
          storageMode: 'online-compressed',
        ),
      );
    }

    return draft.copyWith(photos: compressed);
  }
}

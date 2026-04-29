import '../entities/inspection_draft.dart';

abstract class InspectionRepository {
  Future<InspectionDraft> loadDraft();
  Future<InspectionDraft> saveDraft(InspectionDraft draft);
  Future<InspectionDraft> submitDraft(InspectionDraft draft);
  Future<void> clearDraft();
}

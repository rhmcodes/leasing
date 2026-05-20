import '../models/inspection/inspection_model.dart';

abstract class InspectionRepository {
  Future<void> saveDraft(InspectionModel data);
  Future<void> submit(InspectionModel data);
}

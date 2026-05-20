import '../../core/helpers/connectivity_helper.dart';
import '../datasources/local/inspection_local_datasource.dart';
import '../datasources/local/sync_local_datasource.dart';
import '../datasources/remote/inspection_remote_datasource.dart';
import '../models/inspection/inspection_draft_model.dart';
import '../models/inspection/inspection_model.dart';
import '../models/inspection/sync_queue_model.dart';
import 'inspection_repository.dart';

class InspectionRepositoryImpl implements InspectionRepository {
  const InspectionRepositoryImpl({
    required this.localDatasource,
    required this.syncLocalDatasource,
    required this.remoteDatasource,
  });

  final InspectionLocalDatasource localDatasource;
  final SyncLocalDatasource syncLocalDatasource;
  final InspectionRemoteDatasource remoteDatasource;

  @override
  Future<void> saveDraft(InspectionModel data) {
    return localDatasource.saveDraft(
      InspectionDraftModel(
        id: data.id,
        updatedAt: DateTime.now(),
        data: data,
      ),
    );
  }

  @override
  Future<void> submit(InspectionModel data) async {
    final bool online = await ConnectivityHelper.hasConnection();

    if (!online) {
      await saveDraft(data);
      await syncLocalDatasource.addToQueue(
        SyncQueueModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          inspectionId: data.id,
          status: 'pending',
          createdAt: DateTime.now(),
        ),
      );
      return;
    }

    await remoteDatasource.submitInspection(data);
    await localDatasource.deleteLatestDraft();
  }
}

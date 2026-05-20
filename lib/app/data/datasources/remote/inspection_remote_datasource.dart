import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../models/inspection/inspection_model.dart';

class InspectionRemoteDatasource {
  const InspectionRemoteDatasource(this._apiClient);

  final ApiClient _apiClient;

  Future<void> submitInspection(InspectionModel data) async {
    await _apiClient.post(
      ApiEndpoints.submitInspection,
      data: data.toJson(),
    );
  }
}

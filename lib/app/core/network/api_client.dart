import 'package:dio/dio.dart';

import 'dio_client.dart';

class ApiClient {
  ApiClient(this._dioClient);

  final DioClient _dioClient;

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _dioClient.dio.get<dynamic>(
      path,
      queryParameters: queryParameters,
    );
  }

  Future<Response<dynamic>> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _dioClient.dio.post<dynamic>(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }
}

import 'package:dio/dio.dart';

import '../constants/app_constants.dart';
import 'api_endpoints.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/device_info_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

class DioClient {
  DioClient({Future<String?> Function()? tokenProvider})
      : dio = Dio(
          BaseOptions(
            baseUrl: ApiEndpoints.baseUrl,
            connectTimeout: const Duration(seconds: AppConstants.requestConnectTimeoutSeconds),
            receiveTimeout: const Duration(seconds: AppConstants.requestReceiveTimeoutSeconds),
            headers: const <String, dynamic>{
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
          ),
        ) {
    dio.interceptors.addAll(<Interceptor>[
      AuthInterceptor(tokenProvider: tokenProvider),
      DeviceInfoInterceptor(),
      ErrorInterceptor(),
      LoggingInterceptor(),
    ]);
  }

  final Dio dio;
}

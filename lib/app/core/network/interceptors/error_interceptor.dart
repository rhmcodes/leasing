import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final int? statusCode = err.response?.statusCode;

    if (statusCode == 401) {
      err.requestOptions.extra['friendlyMessage'] = 'Sesi berakhir. Silakan login kembali.';
    } else if (statusCode == 500) {
      err.requestOptions.extra['friendlyMessage'] = 'Server sedang bermasalah. Coba lagi nanti.';
    } else if (err.type == DioExceptionType.connectionError) {
      err.requestOptions.extra['friendlyMessage'] = 'Tidak ada koneksi internet.';
    } else if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      err.requestOptions.extra['friendlyMessage'] = 'Koneksi timeout. Coba lagi.';
    }

    handler.next(err);
  }
}

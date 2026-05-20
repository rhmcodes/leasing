import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';

class DeviceInfoInterceptor extends Interceptor {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['X-OS'] = Platform.operatingSystem;
    options.headers['X-OS-Version'] = Platform.operatingSystemVersion;

    try {
      if (Platform.isAndroid) {
        final AndroidDeviceInfo info = await _deviceInfo.androidInfo;
        options.headers['X-Device-Model'] = '${info.manufacturer} ${info.model}';
      } else if (Platform.isIOS) {
        final IosDeviceInfo info = await _deviceInfo.iosInfo;
        options.headers['X-Device-Model'] = info.utsname.machine;
      }
    } catch (_) {
      options.headers['X-Device-Model'] = 'unknown';
    }

    handler.next(options);
  }
}

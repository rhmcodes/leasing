import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
  const ConnectivityHelper._();

  static Future<bool> hasConnection() async {
    final List<ConnectivityResult> results = await Connectivity().checkConnectivity();
    return results.any((result) => result != ConnectivityResult.none);
  }
}

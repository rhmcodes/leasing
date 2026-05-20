import '../helpers/connectivity_helper.dart';

class NetworkInfo {
  const NetworkInfo();

  Future<bool> get isConnected => ConnectivityHelper.hasConnection();
}

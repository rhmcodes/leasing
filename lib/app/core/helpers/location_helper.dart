import 'package:geolocator/geolocator.dart';

class LocationHelper {
  const LocationHelper._();

  static Future<Position> getCurrentPosition() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('GPS belum aktif');
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Permission lokasi ditolak permanen');
    }

    if (permission == LocationPermission.denied) {
      throw Exception('Permission lokasi ditolak');
    }

    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}

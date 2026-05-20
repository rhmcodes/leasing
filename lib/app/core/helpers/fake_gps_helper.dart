import 'package:geolocator/geolocator.dart';

class FakeGpsHelper {
  const FakeGpsHelper._();

  static List<String> inspect(Position position) {
    final List<String> warnings = <String>[];

    if (position.isMocked) {
      warnings.add('Lokasi terindikasi mock/fake GPS');
    }

    if (position.accuracy > 100) {
      warnings.add('Akurasi GPS rendah (${position.accuracy.toStringAsFixed(0)} meter)');
    }

    if (position.speed > 60) {
      warnings.add('Kecepatan lokasi tidak wajar untuk proses inspeksi');
    }

    final DateTime gpsTimestamp = position.timestamp;
    final Duration diff = DateTime.now().difference(gpsTimestamp);
    if (diff.inMinutes.abs() > 10) {
      warnings.add('Timestamp GPS berbeda jauh dari waktu perangkat');
    }

    return warnings;
  }
}

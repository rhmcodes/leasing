import '../../../../../core/constants/app_enum.dart';

class InspectionPhotoHelper {
  const InspectionPhotoHelper._();

  static String label(InspectionPhotoType type) {
    return switch (type) {
      InspectionPhotoType.front => 'Depan',
      InspectionPhotoType.back => 'Belakang',
      InspectionPhotoType.left => 'Kiri',
      InspectionPhotoType.right => 'Kanan',
      InspectionPhotoType.speedometer => 'Speedometer',
    };
  }
}

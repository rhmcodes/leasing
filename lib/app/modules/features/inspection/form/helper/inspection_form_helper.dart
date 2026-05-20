import '../../../../../core/validators/inspection_validator.dart';

class InspectionFormHelper {
  const InspectionFormHelper._();

  static String normalizePlateNumber(String value) {
    return InspectionValidator.normalizePlate(value);
  }

  static String generateInspectionId() {
    return 'INS-${DateTime.now().millisecondsSinceEpoch}';
  }
}

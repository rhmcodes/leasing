import '../constants/app_constants.dart';
import '../constants/app_regex.dart';
import '../constants/app_strings.dart';

class InspectionValidator {
  const InspectionValidator._();

  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) return AppStrings.requiredField;
    return null;
  }

  static String? plateNumber(String? value) {
    final String text = normalizePlate(value ?? '');
    if (text.isEmpty) return AppStrings.requiredField;
    if (!AppRegex.indonesiaPlateNumber.hasMatch(text)) {
      return AppStrings.invalidPlateNumber;
    }
    return null;
  }

  static String? kilometer(String? value) {
    final String text = value?.trim() ?? '';
    if (text.isEmpty) return AppStrings.requiredField;
    if (!AppRegex.numberOnly.hasMatch(text)) return 'Kilometer hanya boleh angka';

    final int? kilometer = int.tryParse(text);
    if (kilometer == null || kilometer <= 0) return AppStrings.invalidKilometer;
    return null;
  }

  static String? unableMoveReason({
    required bool canBeMoved,
    required String? value,
  }) {
    if (canBeMoved) return null;

    final String text = value?.trim() ?? '';
    if (text.isEmpty) return AppStrings.requiredField;
    if (text.length < AppConstants.minimumUnableMoveReasonLength) {
      return 'Alasan minimal ${AppConstants.minimumUnableMoveReasonLength} karakter';
    }
    return null;
  }

  static String normalizePlate(String value) {
    return value.trim().toUpperCase().replaceAll(RegExp(r'\s+'), ' ');
  }
}

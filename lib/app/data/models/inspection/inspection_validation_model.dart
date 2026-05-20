class InspectionValidationModel {
  const InspectionValidationModel({
    required this.hasValidPlateNumber,
    required this.hasAllRequiredPhotos,
    required this.hasValidKilometer,
    required this.hasValidLocation,
    required this.hasValidUnableMoveReason,
    required this.hasSignature,
  });

  final bool hasValidPlateNumber;
  final bool hasAllRequiredPhotos;
  final bool hasValidKilometer;
  final bool hasValidLocation;
  final bool hasValidUnableMoveReason;
  final bool hasSignature;

  bool get isValid {
    return hasValidPlateNumber &&
        hasAllRequiredPhotos &&
        hasValidKilometer &&
        hasValidLocation &&
        hasValidUnableMoveReason &&
        hasSignature;
  }
}

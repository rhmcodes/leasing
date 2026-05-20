class InspectionSignatureModel {
  const InspectionSignatureModel({
    required this.localPath,
    required this.createdAt,
    this.signatureData,
  });

  /// For real production, this can be a PNG file path.
  /// In this mini project, signatureData stores serialized canvas points so the
  /// signature is still saved with the inspection payload.
  final String localPath;
  final DateTime createdAt;
  final String? signatureData;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'localPath': localPath,
      'createdAt': createdAt.toIso8601String(),
      'signatureData': signatureData,
    };
  }

  factory InspectionSignatureModel.fromJson(Map<String, dynamic> json) {
    return InspectionSignatureModel(
      localPath: json['localPath'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      signatureData: json['signatureData'] as String?,
    );
  }
}

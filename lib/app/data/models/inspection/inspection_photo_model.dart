import 'inspection_metadata_model.dart';

class InspectionPhotoModel {
  const InspectionPhotoModel({
    required this.type,
    required this.localPath,
    required this.metadata,
    this.remoteUrl,
    this.watermarkText,
  });

  final String type;
  final String localPath;
  final InspectionMetadataModel metadata;
  final String? remoteUrl;
  final String? watermarkText;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'type': type,
      'localPath': localPath,
      'metadata': metadata.toJson(),
      'remoteUrl': remoteUrl,
      'watermarkText': watermarkText,
    };
  }

  factory InspectionPhotoModel.fromJson(Map<String, dynamic> json) {
    return InspectionPhotoModel(
      type: json['type'] as String,
      localPath: json['localPath'] as String,
      metadata: InspectionMetadataModel.fromJson(
        json['metadata'] as Map<String, dynamic>,
      ),
      remoteUrl: json['remoteUrl'] as String?,
      watermarkText: json['watermarkText'] as String?,
    );
  }
}

import 'inspection_location_model.dart';
import 'inspection_photo_model.dart';
import 'inspection_signature_model.dart';

class InspectionModel {
  const InspectionModel({
    required this.id,
    required this.surveyorName,
    required this.plateNumber,
    required this.exteriorCondition,
    required this.engineCondition,
    required this.currentKilometer,
    required this.location,
    required this.photos,
    required this.canBeMoved,
    required this.createdAt,
    this.unableMoveReason,
    this.additionalNote,
    this.signature,
  });

  final String id;
  final String surveyorName;
  final String plateNumber;
  final String exteriorCondition;
  final String engineCondition;
  final int currentKilometer;
  final InspectionLocationModel location;
  final List<InspectionPhotoModel> photos;
  final bool canBeMoved;
  final String? unableMoveReason;
  final String? additionalNote;
  final InspectionSignatureModel? signature;
  final DateTime createdAt;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'surveyorName': surveyorName,
      'plateNumber': plateNumber,
      'exteriorCondition': exteriorCondition,
      'engineCondition': engineCondition,
      'currentKilometer': currentKilometer,
      'location': location.toJson(),
      'photos': photos.map((photo) => photo.toJson()).toList(),
      'canBeMoved': canBeMoved,
      'unableMoveReason': unableMoveReason,
      'additionalNote': additionalNote,
      'signature': signature?.toJson(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory InspectionModel.fromJson(Map<String, dynamic> json) {
    return InspectionModel(
      id: json['id'] as String,
      surveyorName: json['surveyorName'] as String,
      plateNumber: json['plateNumber'] as String,
      exteriorCondition: json['exteriorCondition'] as String,
      engineCondition: json['engineCondition'] as String,
      currentKilometer: json['currentKilometer'] as int,
      location: InspectionLocationModel.fromJson(
        json['location'] as Map<String, dynamic>,
      ),
      photos: (json['photos'] as List<dynamic>)
          .map((item) => InspectionPhotoModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      canBeMoved: json['canBeMoved'] as bool,
      unableMoveReason: json['unableMoveReason'] as String?,
      additionalNote: json['additionalNote'] as String?,
      signature: json['signature'] == null
          ? null
          : InspectionSignatureModel.fromJson(
              json['signature'] as Map<String, dynamic>,
            ),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

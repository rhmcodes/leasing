import 'inspection_model.dart';

class InspectionDraftModel {
  const InspectionDraftModel({
    required this.id,
    required this.updatedAt,
    required this.data,
  });

  final String id;
  final DateTime updatedAt;
  final InspectionModel data;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'updatedAt': updatedAt.toIso8601String(),
      'data': data.toJson(),
    };
  }

  factory InspectionDraftModel.fromJson(Map<String, dynamic> json) {
    return InspectionDraftModel(
      id: json['id'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      data: InspectionModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

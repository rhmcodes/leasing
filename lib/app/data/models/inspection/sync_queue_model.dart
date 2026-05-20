class SyncQueueModel {
  const SyncQueueModel({
    required this.id,
    required this.inspectionId,
    required this.status,
    required this.createdAt,
    this.lastError,
  });

  final String id;
  final String inspectionId;
  final String status;
  final DateTime createdAt;
  final String? lastError;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'inspectionId': inspectionId,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'lastError': lastError,
    };
  }

  factory SyncQueueModel.fromJson(Map<String, dynamic> json) {
    return SyncQueueModel(
      id: json['id'] as String,
      inspectionId: json['inspectionId'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastError: json['lastError'] as String?,
    );
  }
}

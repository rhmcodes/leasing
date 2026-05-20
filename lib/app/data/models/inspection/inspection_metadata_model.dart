class InspectionMetadataModel {
  const InspectionMetadataModel({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.surveyorName,
    this.accuracy,
    this.address,
    this.fakeGpsWarnings = const <String>[],
  });

  final double latitude;
  final double longitude;
  final DateTime timestamp;
  final String surveyorName;
  final double? accuracy;
  final String? address;
  final List<String> fakeGpsWarnings;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.toIso8601String(),
      'surveyorName': surveyorName,
      'accuracy': accuracy,
      'address': address,
      'fakeGpsWarnings': fakeGpsWarnings,
    };
  }

  factory InspectionMetadataModel.fromJson(Map<String, dynamic> json) {
    return InspectionMetadataModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      surveyorName: json['surveyorName'] as String,
      accuracy: (json['accuracy'] as num?)?.toDouble(),
      address: json['address'] as String?,
      fakeGpsWarnings: (json['fakeGpsWarnings'] as List<dynamic>? ?? <dynamic>[])
          .map((item) => item.toString())
          .toList(),
    );
  }
}

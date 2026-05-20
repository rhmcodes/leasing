class InspectionLocationModel {
  const InspectionLocationModel({
    required this.latitude,
    required this.longitude,
    required this.addressNote,
    this.accuracy,
    this.isMocked,
    this.fakeGpsWarnings = const <String>[],
  });

  final double latitude;
  final double longitude;
  final String addressNote;
  final double? accuracy;
  final bool? isMocked;
  final List<String> fakeGpsWarnings;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'addressNote': addressNote,
      'accuracy': accuracy,
      'isMocked': isMocked,
      'fakeGpsWarnings': fakeGpsWarnings,
    };
  }

  factory InspectionLocationModel.fromJson(Map<String, dynamic> json) {
    return InspectionLocationModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      addressNote: json['addressNote'] as String,
      accuracy: (json['accuracy'] as num?)?.toDouble(),
      isMocked: json['isMocked'] as bool?,
      fakeGpsWarnings: (json['fakeGpsWarnings'] as List<dynamic>? ?? <dynamic>[])
          .map((item) => item.toString())
          .toList(),
    );
  }
}

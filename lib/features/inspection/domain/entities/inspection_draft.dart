import 'inspection_photo.dart';
import 'signature_point.dart';

enum DraftSaveState { idle, autosavedOffline, autosavedOnline, submitted }

class InspectionDraft {
  const InspectionDraft({
    required this.policeNumber,
    required this.vehicleLocation,
    required this.cannotMoveReason,
    required this.additionalNotes,
    required this.canBeMoved,
    required this.isOnline,
    required this.photos,
    required this.signaturePoints,
    required this.createdAt,
    required this.updatedAt,
    required this.saveState,
    this.odometerKm,
    this.lastAutosavedAt,
  });

  final String policeNumber;
  final int? odometerKm;
  final String vehicleLocation;
  final bool canBeMoved;
  final String cannotMoveReason;
  final String additionalNotes;
  final bool isOnline;
  final Map<PhotoCategory, InspectionPhoto> photos;
  final List<SignaturePoint> signaturePoints;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastAutosavedAt;
  final DraftSaveState saveState;

  bool get requiresSignature => !canBeMoved;

  InspectionDraft copyWith({
    String? policeNumber,
    int? odometerKm,
    bool clearOdometer = false,
    String? vehicleLocation,
    bool? canBeMoved,
    String? cannotMoveReason,
    String? additionalNotes,
    bool? isOnline,
    Map<PhotoCategory, InspectionPhoto>? photos,
    List<SignaturePoint>? signaturePoints,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastAutosavedAt,
    bool clearAutosavedAt = false,
    DraftSaveState? saveState,
  }) {
    return InspectionDraft(
      policeNumber: policeNumber ?? this.policeNumber,
      odometerKm: clearOdometer ? null : odometerKm ?? this.odometerKm,
      vehicleLocation: vehicleLocation ?? this.vehicleLocation,
      canBeMoved: canBeMoved ?? this.canBeMoved,
      cannotMoveReason: cannotMoveReason ?? this.cannotMoveReason,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      isOnline: isOnline ?? this.isOnline,
      photos: photos ?? this.photos,
      signaturePoints: signaturePoints ?? this.signaturePoints,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastAutosavedAt: clearAutosavedAt
          ? null
          : lastAutosavedAt ?? this.lastAutosavedAt,
      saveState: saveState ?? this.saveState,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'policeNumber': policeNumber,
      'odometerKm': odometerKm,
      'vehicleLocation': vehicleLocation,
      'canBeMoved': canBeMoved,
      'cannotMoveReason': cannotMoveReason,
      'additionalNotes': additionalNotes,
      'isOnline': isOnline,
      'photos': photos.map((key, value) => MapEntry(key.name, value.toJson())),
      'signaturePoints': signaturePoints
          .map((point) => point.toJson())
          .toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'lastAutosavedAt': lastAutosavedAt?.toIso8601String(),
      'saveState': saveState.name,
    };
  }

  factory InspectionDraft.fromJson(Map<String, dynamic> json) {
    final rawPhotos =
        (json['photos'] as Map?)?.cast<String, dynamic>() ??
        <String, dynamic>{};
    final photoMap = <PhotoCategory, InspectionPhoto>{};
    for (final entry in rawPhotos.entries) {
      photoMap[PhotoCategory.values.byName(
        entry.key,
      )] = InspectionPhoto.fromJson(
        (entry.value as Map).cast<String, dynamic>(),
      );
    }

    return InspectionDraft(
      policeNumber: json['policeNumber'] as String? ?? '',
      odometerKm: json['odometerKm'] as int?,
      vehicleLocation: json['vehicleLocation'] as String? ?? '',
      canBeMoved: json['canBeMoved'] as bool? ?? true,
      cannotMoveReason: json['cannotMoveReason'] as String? ?? '',
      additionalNotes: json['additionalNotes'] as String? ?? '',
      isOnline: json['isOnline'] as bool? ?? false,
      photos: photoMap,
      signaturePoints: ((json['signaturePoints'] as List?) ?? <dynamic>[])
          .map(
            (item) =>
                SignaturePoint.fromJson((item as Map).cast<String, dynamic>()),
          )
          .toList(),
      createdAt: DateTime.parse(
        json['createdAt'] as String? ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] as String? ?? DateTime.now().toIso8601String(),
      ),
      lastAutosavedAt: json['lastAutosavedAt'] == null
          ? null
          : DateTime.parse(json['lastAutosavedAt'] as String),
      saveState: DraftSaveState.values.byName(
        json['saveState'] as String? ?? DraftSaveState.idle.name,
      ),
    );
  }

  factory InspectionDraft.initial() {
    final now = DateTime.now();
    return InspectionDraft(
      policeNumber: '',
      odometerKm: null,
      vehicleLocation: '',
      canBeMoved: true,
      cannotMoveReason: '',
      additionalNotes: '',
      isOnline: false,
      photos: const <PhotoCategory, InspectionPhoto>{},
      signaturePoints: const <SignaturePoint>[],
      createdAt: now,
      updatedAt: now,
      saveState: DraftSaveState.idle,
    );
  }
}

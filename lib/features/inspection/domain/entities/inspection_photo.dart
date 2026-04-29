enum PhotoCategory {
  numberPlate,
  vehicleWithGpsWatermark,
  speedometer,
  exterior,
  engine,
}

extension PhotoCategoryX on PhotoCategory {
  String get label {
    switch (this) {
      case PhotoCategory.numberPlate:
        return 'Foto Nomor Polisi';
      case PhotoCategory.vehicleWithGpsWatermark:
        return 'Foto Kendaraan + Watermark GPS';
      case PhotoCategory.speedometer:
        return 'Foto Speedometer';
      case PhotoCategory.exterior:
        return 'Foto Kondisi Eksterior';
      case PhotoCategory.engine:
        return 'Foto Kondisi Mesin';
    }
  }

  String get helperText {
    switch (this) {
      case PhotoCategory.numberPlate:
        return 'Pastikan nomor polisi terbaca jelas.';
      case PhotoCategory.vehicleWithGpsWatermark:
        return 'Watermark lokasi dan waktu disematkan di preview dummy.';
      case PhotoCategory.speedometer:
        return 'Gunakan kilometer terakhir sebagai acuan.';
      case PhotoCategory.exterior:
        return 'Ambil sisi kendaraan yang paling representatif.';
      case PhotoCategory.engine:
        return 'Dokumentasikan ruang mesin dan kondisi utamanya.';
    }
  }
}

class PhotoMetadata {
  const PhotoMetadata({
    required this.latitude,
    required this.longitude,
    required this.capturedAt,
    required this.watermarkText,
    required this.originalSizeBytes,
    required this.compressedSizeBytes,
    required this.isCompressed,
    required this.storageMode,
  });

  final double latitude;
  final double longitude;
  final DateTime capturedAt;
  final String watermarkText;
  final int originalSizeBytes;
  final int compressedSizeBytes;
  final bool isCompressed;
  final String storageMode;

  PhotoMetadata copyWith({
    double? latitude,
    double? longitude,
    DateTime? capturedAt,
    String? watermarkText,
    int? originalSizeBytes,
    int? compressedSizeBytes,
    bool? isCompressed,
    String? storageMode,
  }) {
    return PhotoMetadata(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      capturedAt: capturedAt ?? this.capturedAt,
      watermarkText: watermarkText ?? this.watermarkText,
      originalSizeBytes: originalSizeBytes ?? this.originalSizeBytes,
      compressedSizeBytes: compressedSizeBytes ?? this.compressedSizeBytes,
      isCompressed: isCompressed ?? this.isCompressed,
      storageMode: storageMode ?? this.storageMode,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'capturedAt': capturedAt.toIso8601String(),
      'watermarkText': watermarkText,
      'originalSizeBytes': originalSizeBytes,
      'compressedSizeBytes': compressedSizeBytes,
      'isCompressed': isCompressed,
      'storageMode': storageMode,
    };
  }

  factory PhotoMetadata.fromJson(Map<String, dynamic> json) {
    return PhotoMetadata(
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      capturedAt: DateTime.parse(
        json['capturedAt'] as String? ?? DateTime.now().toIso8601String(),
      ),
      watermarkText: json['watermarkText'] as String? ?? '',
      originalSizeBytes: json['originalSizeBytes'] as int? ?? 0,
      compressedSizeBytes: json['compressedSizeBytes'] as int? ?? 0,
      isCompressed: json['isCompressed'] as bool? ?? false,
      storageMode: json['storageMode'] as String? ?? 'offline',
    );
  }
}

class InspectionPhoto {
  const InspectionPhoto({
    required this.category,
    required this.fileName,
    required this.localPath,
    required this.previewColorValue,
    required this.metadata,
  });

  final PhotoCategory category;
  final String fileName;
  final String localPath;
  final int previewColorValue;
  final PhotoMetadata metadata;

  InspectionPhoto copyWith({
    PhotoCategory? category,
    String? fileName,
    String? localPath,
    int? previewColorValue,
    PhotoMetadata? metadata,
  }) {
    return InspectionPhoto(
      category: category ?? this.category,
      fileName: fileName ?? this.fileName,
      localPath: localPath ?? this.localPath,
      previewColorValue: previewColorValue ?? this.previewColorValue,
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'category': category.name,
      'fileName': fileName,
      'localPath': localPath,
      'previewColorValue': previewColorValue,
      'metadata': metadata.toJson(),
    };
  }

  factory InspectionPhoto.fromJson(Map<String, dynamic> json) {
    return InspectionPhoto(
      category: PhotoCategory.values.byName(
        json['category'] as String? ?? PhotoCategory.numberPlate.name,
      ),
      fileName: json['fileName'] as String? ?? '',
      localPath: json['localPath'] as String? ?? '',
      previewColorValue: json['previewColorValue'] as int? ?? 0xFF0D5C63,
      metadata: PhotoMetadata.fromJson(
        (json['metadata'] as Map?)?.cast<String, dynamic>() ??
            <String, dynamic>{},
      ),
    );
  }
}

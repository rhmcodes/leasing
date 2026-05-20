class PhotoWatermarkHelper {
  const PhotoWatermarkHelper._();

  /// Builds watermark text that is saved with photo metadata.
  /// This text can also be rendered visually above the image preview/upload file.
  static String buildWatermarkText({
    required double latitude,
    required double longitude,
    required DateTime timestamp,
    required String surveyorName,
  }) {
    return 'GPS: ${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)} | '
        'Time: ${timestamp.toIso8601String()} | Surveyor: $surveyorName';
  }
}

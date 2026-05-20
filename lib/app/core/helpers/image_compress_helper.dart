import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

import '../constants/app_constants.dart';

class ImageCompressHelper {
  const ImageCompressHelper._();

  static Future<File> compress(File file) async {
    final Directory tempDir = await getTemporaryDirectory();
    final String targetPath =
        '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';

    final XFile? result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: AppConstants.imageQuality,
      minWidth: AppConstants.imageMaxWidth,
      minHeight: AppConstants.imageMaxHeight,
      format: CompressFormat.jpeg,
    );

    return result == null ? file : File(result.path);
  }
}

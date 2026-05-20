import 'package:image_picker/image_picker.dart';

class CameraHelper {
  const CameraHelper._();

  static final ImagePicker _picker = ImagePicker();

  static Future<XFile?> captureFromCamera({
    int imageQuality = 85,
    double? maxWidth,
    double? maxHeight,
  }) {
    return _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: imageQuality,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      preferredCameraDevice: CameraDevice.rear,
    );
  }
}

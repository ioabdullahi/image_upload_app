import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  static final _picker = ImagePicker();

  static Future<XFile?> pickFromGallery() async {
    try {
      return await _picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      return null;
    }
  }

  static Future<XFile?> captureFromCamera() async {
    try {
      return await _picker.pickImage(source: ImageSource.camera);
    } catch (e) {
      return null;
    }
  }
}
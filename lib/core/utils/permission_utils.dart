import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<bool> requestPhotosPermission() async {
    if (await Permission.photos.isGranted) {
      return true;
    }
    
    // Request permission and handle platform differences
    final status = await Permission.photos.request();
    
    if (status.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog
      return false;
    }
    
    return status.isGranted;
  }

  static Future<bool> requestCameraPermission() async {
    if (await Permission.camera.isGranted) {
      return true;
    }
    
    final status = await Permission.camera.request();
    
    if (status.isPermanentlyDenied) {
      return false;
    }
    
    return status.isGranted;
  }

  static Future<void> openAppSettings() async {
    await openAppSettings();
  }
}
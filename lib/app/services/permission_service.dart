import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  // Hàm xin quyền thông báo
  static Future<void> requestNotificationPermission() async {
    // Xin quyền thông báo trên iOS
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
    // Kiểm tra trạng thái quyền
    if (await Permission.notification.isGranted) {
      print("Notification permission granted");
    } else {
      print("Notification permission denied");
    }
  }
}

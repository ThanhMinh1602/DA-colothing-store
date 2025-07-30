import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:male_clothing_store/core/utils/notification_helper.dart';
import 'dart:convert';

import 'package:male_clothing_store/get_server_key.dart';

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  // Khởi tạo FCM và yêu cầu quyền thông báo
  static Future<void> init() async {
    // Lấy token thiết bị
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");
    await NotificationHelper.initialize();
    // Lắng nghe thông báo khi app đang foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Message received: ${message.notification?.title}");
      if (message.notification != null) {
        // Hiển thị thông báo khi app đang foreground
        NotificationHelper.showNotification(message.notification!);
      }
    });

    // Lắng nghe thông báo khi app ở background hoặc đóng
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  }

  // Gửi thông báo đến device
  static Future<void> sendPushNotification(
    String deviceToken,
    String title,
    String body,
  ) async {
    final String url =
        "https://fcm.googleapis.com/v1/projects/male-store-ab1d1/messages:send";

    final key = await GetServerKey().getServerKey();
    // 'ya29.c.c0ASRK0GYvgzB7rv0VCWpKpbkFHG-vUPAvhdjczxsI70hz1lYRtCSaqd4mHZ7jPUqsyyjUTCNL-T_AJsTWAcYXuFRpz1g5Hu54I3yxxcvrcyzyRTEXDzwSRLLG6kpOjVa0DGXzVm0OCnoRPDerqBo_MNfbblwariIwCxYdoNXFi2Qh9vbOWEHluJ1DdEWZbAKjFG15Y5YbYM2Ayz1gO1kV5-lsJDNybIr59TsRjZhMgLRQbterNLsFfTKv37CfGyfvgL_dTGgUiIqpQyOaPtIGnxwdDrXCPLbFrhat863AyUgZjTFQ330A8LU7_yHIdkB_AGKhtJmO1yssOyLzTVWaFrfjETVo-pQXCOrWoXEecgUGvoUk09eT3sMJbnRqDAG391CskIFBUYkYUi0avl6ZyVfZqWfMoe1cwv-6VMRpzaiwsjtmWZn5wMV1O052B5wpY-3adz8B00f-l5aaYcww9Fibbv7q9rUdWB0SrIVxneanz-r4nv19ZY6RWaOkYiuQe-_Xk84fvvum-emq2xi4RlFQxi3ubta8mX4-8ljYYjXiF4b_tcmmrfktIi6Yf1zmjmxlQgiRXxJznMetSiwbSr5erhJtfUBXUS0OgUta6ddpnUknO_qOVfgvRVtzBJMw93MIqcJbIig36eVmZJellt_IpM2OZc4FUVrYvQlgXar7gZQ91y3xQhpnUIvQJS6W49kaYh-SoaBsqc17h704nXsXJ16U6UeY8pVFOtf0yqbtbcrF-yrRJjucphqFB5u5U_O74tW9pvZeqQn1iFm3WI79fZnXuz3_6_JdbegmacOligp1J1Z_lfxMVrj9cwz-hsliUtJtWvJez84vy24g_Rdh4b_gV8u9rafMulsjZX4360bu5lSn9fR6qB3v8eRiq-ummvnhdrhJFaBrlf56BRtQOfpnb9z20nOghzoy305n3aWepkVhzh5Xqa3stcJb54SvhhkWezdzF_pcoiV7f_MYZB9SXmBR8Ivab6IqXMyj0k3FzhoW_j0';
    var headers = {
      'Authorization': 'Bearer $key',
      'Content-Type': 'application/json',
    };

    var payload = json.encode({
      "message": {
        "token": deviceToken,
        "notification": {"body": body, "title": title},
      },
    });

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: payload,
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print('Failed to send notification: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

  // Xử lý thông báo khi app đang ở background hoặc đóng
  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    print("Background message received: ${message.notification?.title}");
    // Bạn có thể xử lý thông báo tại đây khi app đang ở background hoặc đóng
  }
}

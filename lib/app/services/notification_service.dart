import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:male_clothing_store/core/utils/notification_helper.dart';
import 'dart:convert';

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

    final key =
        'ya29.c.c0ASRK0GZbZFduWMp9ytNiIwNPfg3QS3bAZWYx-CFza9EkHfMrypAjkdlGMNbs571hpahE-Mvwvq-6yDF8YjF7JQ-uSSHzog9gQEZshlFfo7kKOozdKnQh53nPl08inw7bb9f0aaTOZuBylzzliLgIQv0rAVkeMBEF_XqViWntiFMuJB3VtwPWxVjTwPDmWMSsNMJUOaorVddo8DlqGRmGv65p6EACJZu3EnkB-Qv5HFuEq-IavgGtssPqnepqxWMKRCjkMjhpSbUXdZYq_Qzh5M6PU1-QY-4pxkIW7jh1OkET1YC0IcFlxyn2o13zQYNl4NRq60wj-KJ3ZFZMFB0mcNKbnisdoGedgV29HmQn2EByKjdoBVbaq5Y-TDqQ8gG391Khg-tv2Ss1BMBhew5-8ipuceZdcjZ6Zn0k3YyJ2sWaW9dMIp1i_pU5xUJ4q7SwyOtjue0wfieUgJyZrs-Br8wxrj0J4-0btohVwfU4h-36SdlSF-41xmOhtxM2_zoUV1Bf5SW-j-Vxjt1xv0rzh3id1bW09Uk7bSScYpqqSlBoykt06voQz66UlZBM9bZvIvf3QV9kuf0zs400UeMt9zts0y4hxQ3savr0e3JssJFb8b0bWxe8yrbrBtl4fqgX57c042J89lSh0IuRpj8VW_miUrQzWvj2hl7cmVq0xxejxY4ljq__I548mU8aVehSBnsrmy6noq4w4qub0sq8XgXlU97_guyfvb0Y7kxxtjX1Vf4ktmmaeBsOhkb13dhbYrIrS3lh15XehdOqc8dxhqMunIqOduSWSkmV-1Q2Yk2fX4S7wxR2r4s3zW2yo38SV1l7lcQ50qtQ-cVufhr-ucXikJj9syImwn5J1tSzUVfnWqSrYpWpo1ijys3rJ8ceyJmvVug951S9Yxc8S80uQBhFU_Uqcl4vISfXkxS1WBmwhbRknbdnIopddaml8nsouW_j34Ua4Jm7ZzxpmZxsreeBYOI94OpxVUt2jXQnoq';
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

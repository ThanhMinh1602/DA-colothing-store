import 'package:get/get.dart';
import 'package:male_clothing_store/modules/web-admin/chat-bot/chat_bot_controller.dart';

class ChatBotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatBotController());
  }
}

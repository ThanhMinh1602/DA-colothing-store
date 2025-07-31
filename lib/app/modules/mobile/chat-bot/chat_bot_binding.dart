import 'package:get/get.dart';
import 'package:male_clothing_store/app/modules/admin/chat-bot/chat_bot_controller.dart';

class ChatBotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatBotController());
  }
}

import 'package:get/get.dart';
import 'package:male_clothing_store/app/modules/admin/chat-bot/chat_bot_controller.dart';

class ChatBotBingding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatBotController());
  }
}

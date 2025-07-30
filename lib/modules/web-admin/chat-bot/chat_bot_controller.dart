import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/app/model/message_model.dart';
import 'package:male_clothing_store/app/services/chat_service.dart';
import 'package:male_clothing_store/app/services/gemini_service.dart';
import 'package:male_clothing_store/app/services/order_service.dart';
import 'package:male_clothing_store/app/services/product_service.dart';
import 'package:male_clothing_store/app/services/category_service.dart';
import 'package:male_clothing_store/app/services/user_service.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';

enum GeminiType {
  product('product', 'Sản phẩm'),
  user('user', 'Khách hàng'),
  category('category', 'Danh mục'),
  order('order', 'Đơn hàng'),
  chat('chat', 'Live Chat');

  const GeminiType(this.value, this.title);

  final String value;
  final String title;

  static GeminiType fromValue(String? value) {
    return GeminiType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => GeminiType.product,
    );
  }
}

class ChatBotController extends BaseController {
  final promptController = TextEditingController();
  final GeminiService _geminiService = GeminiService();
  final ChatService _chatService = ChatService();
  var isLoading = false.obs;
  RxList<MessageModel> messages = <MessageModel>[].obs;
  String conversationContext = '';

  Rx<GeminiType> typeGemini = GeminiType.chat.obs;

  @override
  void onInit() {
    super.onInit();
    _loadChatHistory();
  }

  Future<void> _loadChatHistory() async {
    messages.value = await _chatService.getChatHistory();
    _updateConversationContext();
  }

  void _updateConversationContext() {
    conversationContext = '';
    for (var message in messages) {
      conversationContext +=
          "\n${message.isSentByUser ? 'User' : 'Gemini'}: ${message.content}";
    }
  }

  void changeTypeGemini(GeminiType type) {
    typeGemini.value = type;
  }

  void sendMessage() {
    final prompt = promptController.text.trim();
    if (prompt.isEmpty) return;

    conversationContext += "\nUser: $prompt";
    messages.add(MessageModel(content: prompt, isSentByUser: true));
    messages.add(MessageModel(content: 'Đang trả lời...', isSentByUser: false));
    promptController.clear();

    _chatService.saveMessage(
      messages.lastWhere((msg) => msg.content != 'Đang trả lời...'),
    );

    generateGeminiContent(conversationContext);
  }

  Future<void> generateGeminiContent(String context) async {
    try {
      isLoading.value = true;
      String dataJson = '';

      switch (typeGemini.value) {
        case GeminiType.product:
          final products = await ProductService().getProducts().first;
          dataJson = jsonEncode(
            products.map((product) => product.toJson()).toList(),
          );
          break;

        case GeminiType.user:
          final users = await UserService().getUsers().first;
          dataJson = jsonEncode(users.map((user) => user.toJson()).toList());
          break;

        case GeminiType.category:
          final categories = await CategoryService().getCategories().first;
          dataJson = jsonEncode(
            categories.map((category) => category.toJson()).toList(),
          );
          break;

        case GeminiType.order:
          final orders = await OrderService().getAllOrders().first;
          dataJson = jsonEncode(orders.map((order) => order.toMap()).toList());
          break;

        case GeminiType.chat:
          dataJson = '';
          break;
      }

      final response = await _geminiService.generateContent(context, dataJson);

      messages.removeWhere((msg) => msg.content == 'Đang trả lời...');
      messages.add(MessageModel(content: response, isSentByUser: false));

      conversationContext += "\nGemini: $response";

      _chatService.saveMessage(messages.last);
    } catch (e) {
      messages.removeWhere((msg) => msg.content == 'Đang trả lời...');
      messages.add(MessageModel(content: 'Error: $e', isSentByUser: false));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> clearChatHistory() async {
    messages.clear();
    await _chatService.clearChatHistory();
  }
}

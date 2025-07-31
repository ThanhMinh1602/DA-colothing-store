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
  analysic('analysic', 'Phân tích'),
  chat('chat', 'Live Chat');

  const GeminiType(this.value, this.title);

  final String value;
  final String title;

  static GeminiType fromValue(String? value) {
    return GeminiType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => GeminiType.analysic,
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

  Rx<GeminiType> typeGemini = GeminiType.analysic.obs;

  @override
  void onInit() {
    super.onInit();
    _loadChatHistory();
  }

  // Tải lịch sử trò chuyện
  Future<void> _loadChatHistory() async {
    messages.value = await _chatService.getChatHistory();
    _updateConversationContext();
  }

  // Cập nhật lại bối cảnh cuộc trò chuyện
  void _updateConversationContext() {
    conversationContext = '';
    for (var message in messages) {
      conversationContext +=
          "\n${message.isSentByUser ? 'User' : 'Gemini'}: ${message.content}";
    }
  }

  // Thay đổi loại Gemini
  void changeTypeGemini(GeminiType type) {
    typeGemini.value = type;
  }

  // Gửi tin nhắn từ người dùng
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

  // Gửi yêu cầu tạo nội dung từ Gemini
  Future<void> generateGeminiContent(String context) async {
    try {
      isLoading.value = true;
      String productData = '';
      String userData = '';
      String categoryData = '';
      String orderData = '';

      // Lấy dữ liệu phù hợp với loại Gemini
      switch (typeGemini.value) {
        case GeminiType.analysic:
          final products = await ProductService().getProducts().first;
          productData = jsonEncode(
            products.map((product) => product.toJson()).toList(),
          );

          final users = await UserService().getUsers().first;
          userData = jsonEncode(users.map((user) => user.toJson()).toList());

          final categories = await CategoryService().getCategories().first;
          categoryData = jsonEncode(
            categories.map((category) => category.toJson()).toList(),
          );

          final orders = await OrderService().getAllOrders().first;
          orderData = jsonEncode(orders.map((order) => order.toMap()).toList());
          break;

        case GeminiType.chat:
          // Dữ liệu trống cho loại chat
          productData = '';
          userData = '';
          categoryData = '';
          orderData = '';
          break;
      }

      // Gửi yêu cầu tới Gemini API với dữ liệu cụ thể
      final response = await _geminiService.generateContent(
        context,
        productData: productData,
        userData: userData,
        categoryData: categoryData,
        orderData: orderData,
      );

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

  // Xóa lịch sử trò chuyện
  Future<void> clearChatHistory() async {
    messages.clear();
    await _chatService.clearChatHistory();
  }
}

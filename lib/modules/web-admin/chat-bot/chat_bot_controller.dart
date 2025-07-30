import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/app/model/message_model.dart';
import 'package:male_clothing_store/app/model/user_model.dart';
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
  var isLoading = false.obs;
  RxList<MessageModel> messages = <MessageModel>[].obs;
  String conversationContext = '';

  Rx<GeminiType> typeGemini = GeminiType.chat.obs;

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

    // Generate response based on the GeminiType
    generateGeminiContent(conversationContext);
  }

  // Generate content based on the GeminiType
  Future<void> generateGeminiContent(String context) async {
    try {
      isLoading.value = true;

      var dataJson = '';
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

      print('Generated data JSON: $dataJson');
      final response = await _geminiService.generateContent(context, dataJson);

      messages.removeWhere((msg) => msg.content == 'Đang trả lời...');
      messages.add(MessageModel(content: response, isSentByUser: false));

      conversationContext += "\nGemini: $response";
    } catch (e) {
      messages.removeWhere((msg) => msg.content == 'Đang trả lời...');
      messages.add(MessageModel(content: 'Error: $e', isSentByUser: false));
    } finally {
      isLoading.value = false;
    }
  }
}

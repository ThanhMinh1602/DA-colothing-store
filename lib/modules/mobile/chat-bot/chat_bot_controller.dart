import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/app/model/message_model.dart';
import 'package:male_clothing_store/app/services/chat_service.dart';
import 'package:male_clothing_store/app/services/gemini_service.dart';
import 'package:male_clothing_store/app/services/order_service.dart';
import 'package:male_clothing_store/app/services/product_service.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';

class ChatBotController extends BaseController {
  final promptController = TextEditingController();
  final GeminiService _geminiService = GeminiService();
  final ChatService _chatService = ChatService();
  final ProductService _productService = ProductService();
  final OrderService _orderService = OrderService();
  var isLoading = false.obs;
  RxList<MessageModel> messages = <MessageModel>[].obs;
  String conversationContext = '';

  @override
  void onInit() {
    super.onInit();
    _loadChatHistory();
  }

  // Load chat history from Firestore
  Future<void> _loadChatHistory() async {
    try {
      messages.value = await _chatService.getChatHistory();
      _updateConversationContext();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load chat history: $e');
    }
  }

  // Update conversation context for Gemini
  void _updateConversationContext() {
    conversationContext = '';
    for (var message in messages) {
      conversationContext +=
          "\n${message.isSentByUser ? 'Customer' : 'Bot'}: ${message.content}";
    }
  }

  // Send customer message
  void sendMessage() async {
    final prompt = promptController.text.trim();
    if (prompt.isEmpty) return;

    // Add user message to the list
    conversationContext += "\nCustomer: $prompt";
    messages.add(MessageModel(content: prompt, isSentByUser: true));
    messages.add(MessageModel(content: 'Đang trả lời...', isSentByUser: false));
    promptController.clear();

    // Save user message
    await _chatService.saveMessage(
      messages.lastWhere((msg) => msg.content != 'Đang trả lời...'),
    );

    // Generate response
    await generateGeminiContent(conversationContext);
  }

  // Generate response using GeminiService
  Future<void> generateGeminiContent(String context) async {
    try {
      isLoading.value = true;

      // Fetch product and order data
      String productData = '';
      String orderData = '';

      // Get products
      final products = await _productService.getProducts().first;
      productData = jsonEncode(
        products.map((product) => product.toJson()).toList(),
      );

      // Get user orders
      final orders = await _orderService.getUserOrders().first;
      orderData = jsonEncode(orders.map((order) => order.toMap()).toList());

      // Generate response from Gemini
      final response = await _geminiService.generateContent(
        context,
        productData: productData,
        orderData: orderData,
        userData: '',
        categoryData: '',
      );

      // Update messages
      messages.removeWhere((msg) => msg.content == 'Đang trả lời...');
      messages.add(MessageModel(content: response, isSentByUser: false));
      conversationContext += "\nBot: $response";

      // Save bot response
      await _chatService.saveMessage(messages.last);
    } catch (e) {
      messages.removeWhere((msg) => msg.content == 'Đang trả lời...');
      messages.add(MessageModel(content: 'Lỗi: $e', isSentByUser: false));
      Get.snackbar('Error', 'Failed to generate response: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Clear chat history
  Future<void> clearChatHistory() async {
    try {
      messages.clear();
      conversationContext = '';
      await _chatService.clearChatHistory();
    } catch (e) {
      Get.snackbar('Error', 'Failed to clear chat history: $e');
    }
  }
}

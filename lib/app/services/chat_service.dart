import 'dart:convert';

import 'package:male_clothing_store/app/model/message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatService {
  // Save a message to local storage
  Future<void> saveMessage(MessageModel message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> chatHistory = prefs.getStringList('chatHistory') ?? [];

    // Convert MessageModel to JSON and store it as a string
    chatHistory.add(
      jsonEncode({
        'content': message.content,
        'isSentByUser': message.isSentByUser,
      }),
    );

    await prefs.setStringList('chatHistory', chatHistory);
  }

  // Get all messages from local storage
  Future<List<MessageModel>> getChatHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> chatHistory = prefs.getStringList('chatHistory') ?? [];

    // Convert stored JSON strings back to MessageModel
    return chatHistory.map((msg) {
      Map<String, dynamic> messageMap = jsonDecode(msg);
      return MessageModel(
        content: messageMap['content'],
        isSentByUser: messageMap['isSentByUser'],
      );
    }).toList();
  }

  // Clear chat history from local storage
  Future<void> clearChatHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('chatHistory');
  }
}

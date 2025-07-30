import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:male_clothing_store/app/model/message_model.dart';
import 'package:male_clothing_store/app/services/auth_service.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _auth = AuthService(); // Dùng để lấy user ID

  // Lưu tin nhắn vào Firestore
  Future<void> saveMessage(MessageModel message) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not logged in');
      }

      // Lưu tin nhắn vào subcollection 'chatHistory' của user
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('chatHistory')
          .add({
            'content': message.content,
            'isSentByUser': message.isSentByUser,
            'timestamp':
                FieldValue.serverTimestamp(), // Thêm timestamp để sắp xếp
          });
    } catch (e) {
      throw Exception('Failed to save message: $e');
    }
  }

  // Lấy lịch sử tin nhắn từ Firestore
  Future<List<MessageModel>> getChatHistory() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not logged in');
      }

      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('chatHistory')
          .orderBy('timestamp', descending: false) // Sắp xếp theo thời gian
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return MessageModel(
          content: data['content'] ?? '',
          isSentByUser: data['isSentByUser'] ?? false,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to get chat history: $e');
    }
  }

  // Xóa lịch sử tin nhắn từ Firestore
  Future<void> clearChatHistory() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not logged in');
      }

      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('chatHistory')
          .get();

      // Xóa từng document trong collection
      final batch = _firestore.batch();
      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to clear chat history: $e');
    }
  }
}

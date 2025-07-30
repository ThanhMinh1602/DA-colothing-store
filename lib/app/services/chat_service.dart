import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:male_clothing_store/app/model/message_model.dart';
import 'package:male_clothing_store/app/services/auth_service.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _auth = AuthService();

  Future<void> saveMessage(MessageModel message) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not logged in');
      }

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('chatHistory')
          .add({
            'content': message.content,
            'isSentByUser': message.isSentByUser,
            'timestamp': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      throw Exception('Failed to save message: $e');
    }
  }

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
          .orderBy('timestamp', descending: false)
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

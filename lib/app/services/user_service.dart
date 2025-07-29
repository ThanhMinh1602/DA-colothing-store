import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:male_clothing_store/app/model/user_model.dart';

class UserService {
  final CollectionReference userRef = FirebaseFirestore.instance.collection(
    'users',
  );

  // Thêm user mới
  Future<DocumentReference> addUser(UserModel user) async {
    return await userRef.add(user.toJson());
  }

  // Sửa user (theo docId)
  Future<void> updateUser(String docId, UserModel user) async {
    await userRef.doc(docId).update(user.toJson());
  }

  // Xoá user (theo docId)
  Future<void> deleteUser(String docId) async {
    await userRef.doc(docId).delete();
  }

  // Lấy danh sách user realtime
  Stream<List<UserModel>> getUsers() {
    return userRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  Stream<UserModel?> getUserByIdStream(String docId) {
    return userRef.doc(docId).snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    });
  }
}

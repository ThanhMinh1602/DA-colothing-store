import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:male_clothing_store/app/model/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userRef = FirebaseFirestore.instance.collection(
    'users',
  );
  Future<UserModel> registerWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;
    if (user == null) throw Exception('Register failed!');

    final userModel = UserModel(
      id: user.uid,
      name: name,
      email: email,
      avatarUrl: null,
      phone: null,
      address: null,
      role: 'customer',
    );

    await userRef.doc(user.uid).set(userModel.toJson());

    return userModel;
  }

  // / Hàm đăng nhập
  Future<UserCredential> loginWithEmail(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Lấy device token từ FCM
    String? deviceToken = await FirebaseMessaging.instance.getToken();

    if (userCredential.user != null && deviceToken != null) {
      // Cập nhật Firestore với deviceToken
      await userRef.doc(userCredential.user!.uid).update({
        'deviceToken': deviceToken,
      });
    }

    return userCredential;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<void> changePassword(String newPassword) async {
    if (_auth.currentUser != null) {
      await _auth.currentUser!.updatePassword(newPassword);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:male_clothing_store/app/model/order_model.dart';
import 'package:male_clothing_store/app/services/auth_service.dart';

class OrderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthService _auth = AuthService();

  Future<void> createOrder(OrderModel order) async {
    await _db.collection('orders').doc(order.id).set(order.toMap());
  }

  Stream<List<OrderModel>> getAllOrders() {
    return _db
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snap) =>
              snap.docs.map((doc) => OrderModel.fromMap(doc.data())).toList(),
        );
  }

  // Lấy danh sách đơn hàng của user
  Stream<List<OrderModel>> getUserOrders() {
    return _db
        .collection('orders')
        .where('userId', isEqualTo: _auth.currentUser!.uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => OrderModel.fromMap(doc.data()))
              .toList(),
        );
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await _db.collection('orders').doc(orderId).update({'status': status});
  }

  Future<void> deleteOrder(String orderId) async {
    await _db.collection('orders').doc(orderId).delete();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:male_clothing_store/app/model/order_model.dart';
import 'package:male_clothing_store/app/services/auth_service.dart';
import 'package:male_clothing_store/app/services/product_service.dart';

class OrderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthService _auth = AuthService();
  // final ProductService _productService = ProductService();

  Future<void> createOrder(OrderModel order) async {
    // Tạo đơn hàng trong Firestore
    await _db.collection('orders').doc(order.id).set(order.toMap());

    // Giảm số lượng của từng sản phẩm trong đơn hàng
    for (var item in order.items) {
      await _updateProductQuantity(item.productId, item.quantity);
    }
  }

  Future<void> _updateProductQuantity(
    String productId,
    int quantityOrdered,
  ) async {
    try {
      // Lấy sản phẩm từ Firestore
      DocumentSnapshot productSnapshot = await _db
          .collection('products')
          .doc(productId)
          .get();
      if (productSnapshot.exists) {
        var productData = productSnapshot.data() as Map<String, dynamic>;
        int currentQuantity = productData['quantity'] ?? 0;

        // Nếu số lượng sản phẩm còn lại đủ, giảm số lượng
        if (currentQuantity >= quantityOrdered) {
          int updatedQuantity = currentQuantity - quantityOrdered;

          // Cập nhật số lượng sản phẩm mới
          await _db.collection('products').doc(productId).update({
            'quantity': updatedQuantity,
          });
        } else {
          // Nếu số lượng không đủ, có thể throw lỗi hoặc thông báo
          throw Exception('Số lượng sản phẩm không đủ');
        }
      } else {
        throw Exception('Sản phẩm không tồn tại');
      }
    } catch (e) {
      throw Exception('Lỗi khi cập nhật số lượng sản phẩm: $e');
    }
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

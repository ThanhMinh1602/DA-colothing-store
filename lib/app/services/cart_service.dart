import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:male_clothing_store/app/model/cart_item_model.dart';
import 'package:male_clothing_store/app/model/cart_model.dart';
import 'package:male_clothing_store/app/services/auth_service.dart';

class CartService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthService _auth = AuthService();

  Stream<List<CartItemModel>> getCartItems() {
    return _db
        .collection('carts')
        .doc(_auth.currentUser!.uid)
        .collection('items')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CartItemModel.fromMap(doc.data()))
              .toList(),
        );
  }

  Future<void> addToCart({required CartItemModel item}) async {
    final docRef = _db
        .collection('carts')
        .doc(_auth.currentUser!.uid)
        .collection('items')
        .doc(item.id);

    final doc = await docRef.get();

    if (doc.exists) {
      final oldItem = CartItemModel.fromMap(doc.data()!);
      await docRef.update({'quantity': oldItem.quantity + item.quantity});
    } else {
      await docRef.set(item.toMap());
    }
  }

  Future<void> updateCartItem({
    required String cartItemId,
    required int quantity,
  }) async {
    await _db
        .collection('carts')
        .doc(_auth.currentUser!.uid)
        .collection('items')
        .doc(cartItemId)
        .update({'quantity': quantity});
  }

  Future<void> removeCartItem({required String cartItemId}) async {
    await _db
        .collection('carts')
        .doc(_auth.currentUser!.uid)
        .collection('items')
        .doc(cartItemId)
        .delete();
  }

  Future<void> clearCart() async {
    final batch = _db.batch();
    final itemsSnapshot = await _db
        .collection('carts')
        .doc(_auth.currentUser!.uid)
        .collection('items')
        .get();

    for (var doc in itemsSnapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}

import 'package:male_clothing_store/app/model/cart_item_model.dart';

class CartModel {
  final String userId;
  final List<CartItemModel> items;

  CartModel({required this.userId, required this.items});

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'items': items.map((e) => e.toMap()).toList()};
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      userId: map['userId'] ?? '',
      items: (map['items'] as List<dynamic>? ?? [])
          .map((item) => CartItemModel.fromMap(item))
          .toList(),
    );
  }
}

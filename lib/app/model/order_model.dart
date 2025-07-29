import 'package:male_clothing_store/app/model/cart_item_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final List<CartItemModel> items;
  final num total;
  final DateTime createdAt;
  final String status;

  // Thông tin giao hàng / nhận hàng
  final String receiverName; // Tên người nhận
  final String receiverPhone; // SĐT người nhận
  final String shippingAddress; // Địa chỉ giao hàng

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
    required this.createdAt,
    required this.status,
    required this.receiverName,
    required this.receiverPhone,
    required this.shippingAddress,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((e) => e.toMap()).toList(),
      'total': total,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
      'receiverName': receiverName,
      'receiverPhone': receiverPhone,
      'shippingAddress': shippingAddress,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      items: (map['items'] as List)
          .map((e) => CartItemModel.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
      total: map['total'] ?? 0,
      createdAt: DateTime.parse(map['createdAt']),
      status: map['status'] ?? 'pending',
      receiverName: map['receiverName'] ?? '',
      receiverPhone: map['receiverPhone'] ?? '',
      shippingAddress: map['shippingAddress'] ?? '',
    );
  }
}

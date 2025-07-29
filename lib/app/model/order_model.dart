class OrderModel {
  final int id;
  final String customerName;
  final double total;
  String status;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.customerName,
    required this.total,
    required this.status,
    required this.createdAt,
  });
}

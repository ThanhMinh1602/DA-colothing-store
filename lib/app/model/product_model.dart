class ProductModel {
  final String id;
  String name;
  double price;
  String category;
  String? imageUrl;
  String? description;
  List<String>? colors; // Thêm màu sắc
  List<String>? sizes; // Thêm size
  int quantity; // Thêm số lượng sản phẩm

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.imageUrl,
    this.description,
    this.colors,
    this.sizes,
    required this.quantity, // Khởi tạo số lượng sản phẩm
  });

  // fromJson (Firestore map)
  factory ProductModel.fromJson(Map<String, dynamic> json, String docId) {
    return ProductModel(
      id: docId,
      name: json['name'] ?? '',
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : (json['price'] ?? 0.0),
      category: json['category'] ?? '',
      imageUrl: json['imageUrl'],
      description: json['description'],
      colors: (json['colors'] as List?)?.map((e) => e.toString()).toList(),
      sizes: (json['sizes'] as List?)?.map((e) => e.toString()).toList(),
      quantity: json['quantity'] ?? 1, // Giả sử quantity mặc định là 1
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'description': description,
      'colors': colors,
      'sizes': sizes,
      'quantity': quantity, // Thêm quantity vào JSON
    };
  }
}

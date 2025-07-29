class ProductModel {
  final String id;
  String name;
  double price;
  String category;
  String? imageUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.imageUrl,
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
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
    };
  }
}

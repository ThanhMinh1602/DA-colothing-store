class ProductModel {
  final String id;
  String name;
  double price;
  String category;
  String? imageUrl;
  String? description;
  List<String>? colors; // Thêm màu sắc
  List<String>? sizes; // Thêm size

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.imageUrl,
    this.description,
    this.colors,
    this.sizes,
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
    };
  }
}

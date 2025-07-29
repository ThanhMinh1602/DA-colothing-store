class CategoryModel {
  final String id;
  final String name;

  CategoryModel({required this.id, required this.name});

  // From Firestore DocumentSnapshot or Map
  factory CategoryModel.fromJson(Map<String, dynamic> json, String docId) {
    return CategoryModel(id: docId, name: json['name'] ?? '');
  }

  // toJson để lưu lên Firestore
  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}

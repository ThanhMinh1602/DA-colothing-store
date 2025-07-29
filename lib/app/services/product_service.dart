import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:male_clothing_store/app/model/product_model.dart';

class ProductService {
  final CollectionReference productRef = FirebaseFirestore.instance.collection(
    'products',
  );

  // Thêm sản phẩm (auto id Firestore)
  Future<DocumentReference> addProduct(ProductModel product) async {
    return await productRef.add(product.toJson());
  }

  // Sửa sản phẩm (theo docId)
  Future<void> updateProduct(String docId, ProductModel product) async {
    await productRef.doc(docId).update(product.toJson());
  }

  // Xoá sản phẩm (theo docId)
  Future<void> deleteProduct(String docId) async {
    await productRef.doc(docId).delete();
  }

  // Lấy danh sách sản phẩm realtime
  Stream<List<ProductModel>> getProducts() {
    return productRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductModel.fromJson(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
  }

  // Lọc & search (filter trên client)
  Stream<List<ProductModel>> filterAndSearch({
    String? category,
    String? keyword,
  }) {
    return getProducts().map((products) {
      var result = products;
      if (category != null && category.isNotEmpty) {
        result = result.where((p) => p.category == category).toList();
      }
      if (keyword != null && keyword.isNotEmpty) {
        result = result
            .where((p) => p.name.toLowerCase().contains(keyword.toLowerCase()))
            .toList();
      }
      return result;
    });
  }
}

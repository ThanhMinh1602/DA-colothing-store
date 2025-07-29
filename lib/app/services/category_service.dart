import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:male_clothing_store/app/model/category_model.dart';

class CategoryService {
  final CollectionReference categoryRef = FirebaseFirestore.instance.collection(
    'categories',
  );

  // Thêm danh mục
  Future<DocumentReference> addCategory(String name) async {
    return await categoryRef.add({'name': name});
  }

  // Sửa danh mục
  Future<void> updateCategory(String docId, String name) async {
    await categoryRef.doc(docId).update({'name': name});
  }

  // Xoá danh mục
  Future<void> deleteCategory(String docId) async {
    await categoryRef.doc(docId).delete();
  }

  // Lấy danh sách danh mục realtime
  Stream<List<CategoryModel>> getCategories() {
    return categoryRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CategoryModel.fromJson(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
  }
}

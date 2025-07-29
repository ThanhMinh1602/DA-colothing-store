import 'package:get/get.dart';
import 'package:male_clothing_store/app/services/category_service.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';
import 'package:male_clothing_store/app/model/category_model.dart';

class CategoryManagerController extends BaseController {
  final CategoryService _service = CategoryService();

  // Danh sách danh mục realtime
  final categories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Lắng nghe Firestore realtime
    _service.getCategories().listen((data) {
      categories.value = data;
    }, onError: handleError);
  }

  // Thêm
  Future<void> addCategory(String name) async {
    try {
      showLoading();
      await _service.addCategory(name);
      hideLoading();
      showSnackbar(title: 'Thành công', message: 'Đã thêm danh mục');
    } catch (e, s) {
      handleError(e, s);
    }
  }

  // Sửa
  Future<void> updateCategory(String id, String name) async {
    try {
      showLoading();
      await _service.updateCategory(id, name);
      hideLoading();
      showSnackbar(title: 'Thành công', message: 'Đã sửa danh mục');
    } catch (e, s) {
      handleError(e, s);
    }
  }

  // Xoá
  Future<void> deleteCategory(String id) async {
    try {
      showLoading();
      await _service.deleteCategory(id);
      hideLoading();
      showSnackbar(title: 'Thành công', message: 'Đã xoá danh mục');
    } catch (e, s) {
      handleError(e, s);
    }
  }
}

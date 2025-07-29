import 'package:get/get.dart';
import 'package:male_clothing_store/app/services/category_service.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';
import 'package:male_clothing_store/app/model/category_model.dart';

class CategoryManagerController extends BaseController {
  final CategoryService _service = CategoryService();

  final categories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    _service.getCategories().listen(
      (data) {
        categories.value = data;
      },
      onError: (e) {
        showError(message: "Không thể lấy danh mục: $e");
      },
    );
  }

  Future<void> addCategory(String name) async {
    try {
      showLoading(message: "Đang thêm danh mục...");
      await _service.addCategory(name);
      hideLoading();
      await showSuccess(message: 'Đã thêm danh mục');
    } catch (e) {
      hideLoading();
      await showError(message: "Thêm danh mục thất bại!");
    }
  }

  Future<void> updateCategory(String id, String name) async {
    try {
      showLoading(message: "Đang sửa danh mục...");
      await _service.updateCategory(id, name);
      hideLoading();
      await showSuccess(message: 'Đã sửa danh mục');
    } catch (e) {
      hideLoading();
      await showError(message: "Sửa danh mục thất bại!");
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      showLoading(message: "Đang xoá danh mục...");
      await _service.deleteCategory(id);
      hideLoading();
      await showSuccess(message: 'Đã xoá danh mục');
    } catch (e) {
      hideLoading();
      await showError(message: "Xoá danh mục thất bại!");
    }
  }
}

import 'dart:async';
import 'package:get/get.dart';
import 'package:male_clothing_store/app/model/product_model.dart';
import 'package:male_clothing_store/app/model/category_model.dart';
import 'package:male_clothing_store/app/services/category_service.dart';
import 'package:male_clothing_store/app/services/product_service.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';

class ProductManagerController extends BaseController {
  final ProductService _productService = ProductService();
  final CategoryService _categoryService = CategoryService();

  final products = <ProductModel>[].obs;
  final categories = <CategoryModel>[].obs;
  final selectedCategory = ''.obs;
  final searchKeyword = ''.obs;

  StreamSubscription? _productsSub;

  @override
  void onInit() {
    super.onInit();

    _categoryService.getCategories().listen(
      (data) {
        categories.value = data;
      },
      onError: (e) {
        showError(message: "Không thể lấy danh mục: $e");
      },
    );

    loadProducts();

    everAll([selectedCategory, searchKeyword], (_) => loadProducts());
  }

  void loadProducts() {
    _productsSub?.cancel();
    _productsSub = _productService
        .filterAndSearch(
          category: selectedCategory.value,
          keyword: searchKeyword.value,
        )
        .listen(
          (data) {
            products.value = data;
          },
          onError: (e) {
            showError(message: "Không thể lấy sản phẩm: $e");
          },
        );
  }

  void onCategoryChanged(String? value) {
    selectedCategory.value = value ?? '';
  }

  void onSearchChanged(String value) {
    searchKeyword.value = value;
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      showLoading(message: "Đang thêm sản phẩm...");
      await _productService.addProduct(product);
      hideLoading();
      await showSuccess(message: 'Đã thêm sản phẩm');
    } catch (e) {
      hideLoading();
      await showError(message: "Thêm sản phẩm thất bại!");
    }
  }

  Future<void> updateProduct(String id, ProductModel product) async {
    try {
      showLoading(message: "Đang cập nhật sản phẩm...");
      await _productService.updateProduct(id, product);
      hideLoading();
      await showSuccess(message: 'Đã sửa sản phẩm');
    } catch (e) {
      hideLoading();
      await showError(message: "Sửa sản phẩm thất bại!");
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      showLoading(message: "Đang xoá sản phẩm...");
      await _productService.deleteProduct(id);
      hideLoading();
      await showSuccess(message: 'Đã xoá sản phẩm');
    } catch (e) {
      hideLoading();
      await showError(message: "Xoá sản phẩm thất bại!");
    }
  }

  @override
  void onClose() {
    _productsSub?.cancel();
    super.onClose();
  }
}

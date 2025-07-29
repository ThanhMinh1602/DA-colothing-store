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
    // Lấy danh mục sản phẩm
    _categoryService.getCategories().listen((data) {
      categories.value = data;
    }, onError: handleError);

    // Lấy sản phẩm ban đầu
    loadProducts();

    // Tự động lọc/search khi filter thay đổi
    everAll([selectedCategory, searchKeyword], (_) => loadProducts());
  }

  void loadProducts() {
    _productsSub?.cancel();
    _productsSub = _productService
        .filterAndSearch(
          category: selectedCategory.value,
          keyword: searchKeyword.value,
        )
        .listen((data) {
          products.value = data;
        }, onError: handleError);
  }

  void onCategoryChanged(String? value) {
    selectedCategory.value = value ?? '';
  }

  void onSearchChanged(String value) {
    searchKeyword.value = value;
  }

  // Thêm
  Future<void> addProduct(ProductModel product) async {
    try {
      showLoading();
      await _productService.addProduct(product);
      hideLoading();
      showSnackbar(title: 'Thành công', message: 'Đã thêm sản phẩm');
    } catch (e, s) {
      handleError(e, s);
    }
  }

  // Sửa
  Future<void> updateProduct(String id, ProductModel product) async {
    try {
      showLoading();
      await _productService.updateProduct(id, product);
      hideLoading();
      showSnackbar(title: 'Thành công', message: 'Đã sửa sản phẩm');
    } catch (e, s) {
      handleError(e, s);
    }
  }

  // Xoá
  Future<void> deleteProduct(String id) async {
    try {
      showLoading();
      await _productService.deleteProduct(id);
      hideLoading();
      showSnackbar(title: 'Thành công', message: 'Đã xoá sản phẩm');
    } catch (e, s) {
      handleError(e, s);
    }
  }

  @override
  void onClose() {
    _productsSub?.cancel();
    super.onClose();
  }
}

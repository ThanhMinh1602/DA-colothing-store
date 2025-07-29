import 'dart:async';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:male_clothing_store/app/model/category_model.dart';
import 'package:male_clothing_store/app/model/product_model.dart';
import 'package:male_clothing_store/app/model/user_model.dart';
import 'package:male_clothing_store/app/services/category_service.dart';
import 'package:male_clothing_store/app/services/product_service.dart';
import 'package:male_clothing_store/app/services/user_service.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';

class HomeController extends BaseController {
  final CategoryService _categoryService = CategoryService();
  final ProductService _productService = ProductService();

  final searchController = TextEditingController();

  final categories = <CategoryModel>[].obs;
  final allProducts = <ProductModel>[].obs;
  final products = <ProductModel>[].obs;

  final selectedCategory = "Tất cả".obs;
  final searchKeyword = "".obs;

  // Add user
  final Rxn<UserModel> currentUser = Rxn<UserModel>();
  StreamSubscription? _userSubscription;

  @override
  void onInit() {
    super.onInit();
    _loadCategories();
    _loadProducts();
    _loadProfile();

    everAll([selectedCategory, searchKeyword], (_) {
      unfocus();
      _filterProducts();
    });
  }

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  void setKeyword(String keyword) {
    searchKeyword.value = keyword;
  }

  Future<void> _loadCategories() async {
    try {
      showLoading(message: "Đang tải danh mục...");
      _categoryService.getCategories().listen(
        (cats) {
          categories.value = cats;
          if (cats.isEmpty || cats.first.name != "Tất cả") {
            categories.insert(0, CategoryModel(id: "all", name: "Tất cả"));
          }
          hideLoading();
        },
        onError: (e) {
          hideLoading();
          showError(message: "Không lấy được danh mục!");
        },
      );
    } catch (e) {
      hideLoading();
      showError(message: "Có lỗi khi tải danh mục!");
    }
  }

  Future<void> _loadProducts() async {
    try {
      showLoading(message: "Đang tải sản phẩm...");
      _productService.getProducts().listen(
        (list) {
          allProducts.value = list;
          _filterProducts();
          hideLoading();
        },
        onError: (e) {
          hideLoading();
          showError(message: "Không lấy được sản phẩm!");
        },
      );
    } catch (e) {
      hideLoading();
      showError(message: "Có lỗi khi tải sản phẩm!");
    }
  }

  void _filterProducts() {
    var result = allProducts;
    if (selectedCategory.value != "Tất cả") {
      result = result
          .where((p) => p.category == selectedCategory.value)
          .toList()
          .obs;
    }
    if (searchKeyword.value.isNotEmpty) {
      result = result
          .where(
            (p) => p.name.toLowerCase().contains(
              searchKeyword.value.toLowerCase(),
            ),
          )
          .toList()
          .obs;
    }
    products.value = result;
  }

  // Lấy profile user realtime
  void _loadProfile() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      _userSubscription = UserService().getUserByIdStream(userId).listen((
        user,
      ) {
        currentUser.value = user;
      });
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    _userSubscription?.cancel();
    super.onClose();
  }
}

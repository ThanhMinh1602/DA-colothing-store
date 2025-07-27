import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';

class ProductDetailController extends BaseController {
  // Demo: sizes, colors
  final List<String> sizes = ['S', 'M', 'L', 'XL'];
  final List<Color> colors = [
    Colors.black,
    Colors.blueGrey,
    Colors.brown,
    Colors.white,
  ];

  final RxInt selectedSize = 0.obs;
  final RxInt selectedColor = 0.obs;
  final RxInt quantity = 1.obs;
  final RxBool isFavorite = false.obs;

  void selectSize(int index) => selectedSize.value = index;
  void selectColor(int index) => selectedColor.value = index;

  void incrementQty() => quantity.value++;
  void decrementQty() {
    if (quantity.value > 1) quantity.value--;
  }

  void toggleFavorite() => isFavorite.value = !isFavorite.value;

  // (Tuỳ biến thêm cho Add to cart, show toast, v.v.)
  void addToCart() {
    // Xử lý thêm vào giỏ hàng, gọi API, show snackbar...
    Get.snackbar('Thành công', 'Đã thêm vào giỏ hàng!');
  }
}

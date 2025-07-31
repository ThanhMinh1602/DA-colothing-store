import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:male_clothing_store/app/model/cart_item_model.dart';
import 'package:male_clothing_store/app/model/product_model.dart';
import 'package:male_clothing_store/app/services/cart_service.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';

class ProductDetailController extends BaseController {
  final CartService _cartService = CartService();

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

  Future<void> addToCart(ProductModel product) async {
    final size = sizes[selectedSize.value];
    final color = colors[selectedColor.value];
    final cartItemId = '${product.id}_${size}_${color.value}';

    final cartItem = CartItemModel(
      id: cartItemId,
      productId: product.id,
      productImage: product.imageUrl ?? '',
      productName: product.name,
      price: product.price,
      quantity: quantity.value,
      size: size,
      colorValue: color,
    );

    try {
      showLoading(message: "Đang thêm vào giỏ hàng...");
      await _cartService.addToCart(item: cartItem);
      hideLoading();
      await showSuccess(message: 'Đã thêm vào giỏ hàng!');
    } catch (e) {
      hideLoading();
      await showError(message: 'Thêm vào giỏ hàng thất bại!');
    }
  }
}

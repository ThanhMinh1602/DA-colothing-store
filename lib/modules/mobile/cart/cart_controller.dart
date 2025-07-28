import 'package:get/get.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';

class CartItem {
  final String imageUrl;
  final String title;
  final String category;
  final int price;
  final int quantity;

  CartItem({
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.price,
    required this.quantity,
  });
}

class CartController extends BaseController {
  RxList<CartItem> cartItems = <CartItem>[
    CartItem(
      imageUrl:
          'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/b510594c-e6a0-4992-85a2-c97f9142f0d5/AS+M+NK+DF+FORM+JKT+GFX.png',
      title: 'Áo khoác thời trang hiện đại',
      category: 'Áo khoác nam',
      price: 1290000,
      quantity: 2,
    ),
    CartItem(
      imageUrl:
          'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/b510594c-e6a0-4992-85a2-c97f9142f0d5/AS+M+NK+DF+FORM+JKT+GFX.png',
      title: 'Áo phông basic',
      category: 'Áo thun',
      price: 490000,
      quantity: 1,
    ),
  ].obs;

  int get total =>
      cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  void removeItem(int index) {
    cartItems.removeAt(index);
  }
}

import 'package:get/get.dart';
import 'package:male_clothing_store/app/model/cart_item_model.dart';
import 'package:male_clothing_store/app/model/order_model.dart';
import 'package:male_clothing_store/app/model/user_model.dart';
import 'package:male_clothing_store/app/services/auth_service.dart';
import 'package:male_clothing_store/app/services/cart_service.dart';
import 'package:male_clothing_store/app/services/order_service.dart';
import 'package:male_clothing_store/app/services/user_service.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';
import 'package:uuid/uuid.dart';

class CartController extends BaseController {
  final CartService _cartService = CartService();
  final OrderService _orderService = OrderService();
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();

    _cartService.getCartItems().listen((items) {
      cartItems.value = items;
    });

    final uid = _authService.currentUser?.uid;
    if (uid != null) {
      _userService.userRef.doc(uid).snapshots().listen((doc) {
        if (doc.exists) {
          currentUser.value = UserModel.fromJson(
            doc.data() as Map<String, dynamic>,
            doc.id,
          );
        }
      });
    }
  }

  int get totalQuantity =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);

  int get total => cartItems.fold(
    0,
    (sum, item) => sum + (item.price * item.quantity).toInt(),
  );
  Future<void> removeItemById(String cartItemId) async {
    showLoading();
    try {
      await _cartService.removeCartItem(cartItemId: cartItemId);
      hideLoading();
      await showSuccess(message: "Đã xoá sản phẩm khỏi giỏ hàng!");
    } catch (e) {
      hideLoading();
      await showError(message: "Xoá sản phẩm thất bại!");
    }
  }

  Future<void> updateQuantity(String cartItemId, int quantity) async {
    showLoading();
    try {
      await _cartService.updateCartItem(
        cartItemId: cartItemId,
        quantity: quantity,
      );
      hideLoading();
      await showSuccess(message: "Cập nhật số lượng thành công!");
    } catch (e) {
      hideLoading();
      await showError(message: "Cập nhật số lượng thất bại!");
    }
  }

  Future<void> checkout() async {
    if (cartItems.isEmpty) {
      await showInfo(message: 'Giỏ hàng của bạn đang trống!');
      return;
    }
    final user = currentUser.value;
    if (user == null) {
      await showError(message: 'Không lấy được thông tin tài khoản!');
      return;
    }

    final orderId = const Uuid().v4();
    final order = OrderModel(
      id: orderId,
      userId: user.id,
      items: List<CartItemModel>.from(cartItems),
      total: total,
      createdAt: DateTime.now(),
      status: 'pending',
      receiverName: user.name,
      receiverPhone: user.phone ?? '',
      shippingAddress: user.address ?? '',
    );
    showLoading();
    try {
      await _orderService.createOrder(order);
      await _cartService.clearCart();
      hideLoading();
      await showSuccess(message: 'Thanh toán thành công!');
    } catch (e) {
      hideLoading();
      await showError(message: e.toString());
    }
  }
}

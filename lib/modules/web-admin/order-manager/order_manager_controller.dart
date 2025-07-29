import 'package:get/get.dart';
import 'package:male_clothing_store/app/model/order_model.dart';
import 'package:male_clothing_store/app/services/order_service.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';

class OrderManagerController extends BaseController {
  final OrderService _orderService = OrderService();

  RxList<OrderModel> orders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    _orderService.getAllOrders().listen(
      (list) {
        orders.value = list;
      },
      onError: (e) {
        showError(message: "Không lấy được danh sách đơn hàng: $e");
      },
    );
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      showLoading(message: "Đang cập nhật trạng thái...");
      await _orderService.updateOrderStatus(orderId, status);
      hideLoading();
      await showSuccess(message: "Cập nhật trạng thái thành công!");
    } catch (e) {
      hideLoading();
      await showError(message: "Cập nhật trạng thái thất bại!");
    }
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      showLoading(message: "Đang xoá đơn hàng...");
      await _orderService.deleteOrder(orderId);
      hideLoading();
      await showSuccess(message: "Đã xoá đơn hàng!");
    } catch (e) {
      hideLoading();
      await showError(message: "Xoá đơn hàng thất bại!");
    }
  }
}

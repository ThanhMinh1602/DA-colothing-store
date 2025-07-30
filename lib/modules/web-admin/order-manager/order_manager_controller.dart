import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/app/model/order_model.dart';
import 'package:male_clothing_store/app/services/order_service.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/app/services/notification_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum OrderStatus {
  pending('Chờ xử lý', 'pending', AppColor.lightYellow, AppColor.warning),
  confirmed('Đã xác nhận', 'confirmed', AppColor.lightBlue, AppColor.blue),
  shipping('Đang giao', 'shipping', AppColor.lightGreen, AppColor.green),
  delivered('Đã giao', 'delivered', AppColor.lightGreen, AppColor.success),
  cancelled('Đã huỷ', 'cancelled', AppColor.saleBg, AppColor.error);

  final String title;
  final String value;
  final Color bgColor;
  final Color textColor;

  const OrderStatus(this.title, this.value, this.bgColor, this.textColor);

  static OrderStatus fromValue(String value) {
    return OrderStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => OrderStatus.pending,
    );
  }
}

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

  // Cập nhật trạng thái đơn hàng và gửi thông báo
  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    try {
      showLoading(message: "Đang cập nhật trạng thái...");
      // Chuyển đổi status thành value (string) của enum
      await _orderService.updateOrderStatus(orderId, status.value);

      // Lấy userId từ đơn hàng để lấy deviceToken
      final order = orders.firstWhere((order) => order.id == orderId);
      final userId =
          order.userId; // Giả sử `userId` là ID người dùng trong order

      // Lấy deviceToken từ Firestore của người dùng
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      final deviceToken = userDoc.data()?['deviceToken'];

      if (deviceToken != null) {
        // Gửi thông báo cho người dùng
        await NotificationService.sendPushNotification(
          deviceToken,
          'Cập nhật đơn hàng',
          'Chào bạn, trạng thái đơn hàng của bạn đã thay đổi. Nó hiện đang ở trạng thái: ${status.title}.',
        );
      }

      hideLoading();
      await showSuccess(message: "Cập nhật trạng thái thành công!");
    } catch (e) {
      hideLoading();
      await showError(message: "Cập nhật trạng thái thất bại!");
    }
  }

  // Xoá đơn hàng
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

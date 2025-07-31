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
  RxList<OrderModel> filteredOrders = <OrderModel>[].obs;
  Rx<String?> selectedStatus = Rx<String?>(null);
  Rx<DateTimeRange?> selectedDateRange = Rx<DateTimeRange?>(null);

  @override
  void onInit() {
    super.onInit();

    _orderService.getAllOrders().listen(
      (list) {
        orders.value = list;
        applyFilters();
      },
      onError: (e) {
        showError(message: "Không lấy được danh sách đơn hàng: $e");
      },
    );
  }

  // Lọc theo trạng thái
  void filterByStatus(String? status) {
    selectedStatus.value = status;
    applyFilters();
  }

  // Xóa bộ lọc ngày
  void clearDateRangeFilter() {
    selectedDateRange.value = null; // Xóa bộ lọc ngày
    applyFilters(); // Áp dụng lại bộ lọc
  }

  // Lọc theo khoảng ngày
  void filterByDateRange(DateTimeRange range) {
    selectedDateRange.value = range;
    applyFilters();
  }

  // Áp dụng các bộ lọc
  void applyFilters() {
    filteredOrders.value = orders.where((order) {
      bool statusMatch =
          selectedStatus.value == null || order.status == selectedStatus.value;
      bool dateMatch =
          selectedDateRange.value == null ||
          (order.createdAt.isAfter(selectedDateRange.value!.start) &&
              order.createdAt.isBefore(
                selectedDateRange.value!.end.add(const Duration(days: 1)),
              ));
      return statusMatch && dateMatch;
    }).toList();
  }

  // Cập nhật trạng thái đơn hàng và gửi thông báo
  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    try {
      showLoading(message: "Đang cập nhật trạng thái...");
      await _orderService.updateOrderStatus(orderId, status.value);

      final order = orders.firstWhere((order) => order.id == orderId);
      final userId = order.userId;

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      final deviceToken = userDoc.data()?['deviceToken'];

      if (deviceToken != null) {
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

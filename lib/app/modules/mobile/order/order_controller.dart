import 'package:get/get.dart';
import 'package:male_clothing_store/app/services/order_service.dart';
import 'package:male_clothing_store/app/model/order_model.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';

class OrderController extends BaseController {
  final OrderService _orderService = OrderService();

  var orders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _orderService.getUserOrders().listen((ordersList) {
      orders.assignAll(ordersList);
    });
  }
}

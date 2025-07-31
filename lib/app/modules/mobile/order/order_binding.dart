import 'package:get/get.dart';
import 'package:male_clothing_store/app/modules/mobile/order/order_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderController());
  }
}

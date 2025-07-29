import 'package:get/get.dart';
import 'package:male_clothing_store/modules/web-admin/order-manager/order_manager_controller.dart';

class OrderManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderManagerController());
  }
}

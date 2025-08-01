import 'package:get/get.dart';
import 'customer_manager_controller.dart';

class CustomerManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerManagerController());
  }
}

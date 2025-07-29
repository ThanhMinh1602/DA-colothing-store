import 'package:get/get.dart';
import 'package:male_clothing_store/modules/web-admin/product-manager/product_manager_controller.dart';

class ProductManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductManagerController());
  }
}

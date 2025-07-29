import 'package:get/get.dart';
import 'package:male_clothing_store/modules/web-admin/category-manager/category_manager_controller.dart';

class CategoryManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryManagerController());
  }
}

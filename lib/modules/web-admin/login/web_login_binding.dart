import 'package:get/get.dart';
import 'package:male_clothing_store/modules/web-admin/login/web_login_controller.dart';

class WebLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebLoginController());
  }
}

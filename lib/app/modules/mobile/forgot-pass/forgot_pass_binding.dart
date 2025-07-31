import 'package:get/get.dart';
import 'forgot_pass_controller.dart';

class ForgotPassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPassController>(() => ForgotPassController());
  }
}

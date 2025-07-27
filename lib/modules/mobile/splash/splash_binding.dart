import 'package:get/get.dart';
import 'package:male_clothing_store/modules/mobile/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}

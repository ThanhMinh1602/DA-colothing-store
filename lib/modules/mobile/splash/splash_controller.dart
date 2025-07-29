import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';

class SplashController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    _checkLogin();
  }

  void _checkLogin() async {
    await Future.delayed(const Duration(milliseconds: 800));
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        goOffAll(AppRoutes.main);
      } else {
        goOffAll(AppRoutes.login);
      }
    } catch (e) {
      await showError(message: "Lỗi khởi động ứng dụng!");
      goOffAll(AppRoutes.login);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';

class WebLoginController extends BaseController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    isLoading.value = true;
    try {
      // TODO: Thực hiện logic đăng nhập
      // await Future.delayed(const Duration(seconds: 2));
      // Sau khi login thành công thì...
      // Get.toNamed(AppRoutes.home); // hoặc tuỳ logic của bạn
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

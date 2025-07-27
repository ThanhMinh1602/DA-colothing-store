import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';

class RegisterController extends BaseController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void register() async {
    showLoading();
    await Future.delayed(const Duration(seconds: 1));
    hideLoading();

    if (emailController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text &&
        passwordController.text.length >= 6) {
      showSnackbar(
        title: 'Thành công',
        message: 'Đăng ký thành công!',
        backgroundColor: Colors.green,
      );
      goTo(AppRoutes.login);
    } else {
      showSnackbar(
        title: 'Lỗi',
        message: 'Vui lòng kiểm tra lại thông tin!',
        backgroundColor: Colors.red[400],
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}

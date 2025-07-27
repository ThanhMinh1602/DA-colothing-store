import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';
import 'package:male_clothing_store/core/base/base_controller.dart'; // Import BaseController của bạn

class LoginController extends BaseController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    showLoading();
    await Future.delayed(const Duration(seconds: 1)); // mô phỏng API call
    hideLoading();

    // VD kiểm tra tài khoản hợp lệ
    if (true) {
      goTo(AppRoutes.main);
    } else {
      // Thông báo lỗi (dùng showSnackbar từ base)
      showSnackbar(
        title: 'Đăng nhập thất bại',
        message: 'Email hoặc mật khẩu không đúng',
        backgroundColor: Colors.orange,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

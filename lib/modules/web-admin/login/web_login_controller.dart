import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';
import 'package:male_clothing_store/app/services/auth_service.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';

class WebLoginController extends BaseController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _authService = AuthService();

  Future<void> login() async {
    unfocus();
    showLoading(message: "Đang đăng nhập...");
    try {
      final role = await _authService.loginWithEmail(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      await showSuccess(message: "Đăng nhập thành công!");
      if (role == 'admin') {
        goOffAll(WebRouter.productManager);
      }
    } catch (e) {
      showError(message: "Tên đăng nhập hoặc mật khẩu không đúng");
    } finally {
      hideLoading();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

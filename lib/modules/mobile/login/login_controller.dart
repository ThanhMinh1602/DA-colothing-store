import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';
import 'package:male_clothing_store/app/services/auth_service.dart';

class LoginController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  Future<void> login() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    unfocus();

    try {
      showLoading(message: "Đang đăng nhập...");
      await _authService.loginWithEmail(
        emailController.text.trim(),
        passwordController.text,
      );
      hideLoading();

      goTo(AppRoutes.main);
    } catch (e) {
      hideLoading();
      await showError(message: 'Đăng nhập thất bại, vui lòng thử lại!');
    }
  }
}

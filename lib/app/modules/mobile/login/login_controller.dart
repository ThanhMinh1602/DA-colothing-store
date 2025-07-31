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
    showLoading(message: "Đang đăng nhập...");
    try {
      final role = await _authService.loginWithEmail(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      await showSuccess(message: "Đăng nhập thành công!");
      if (role == 'admin') {
        goOffAll(AdminRouter.dashboard);
      } else {
        goOffAll(AppRoutes.main);
      }
    } catch (e) {
      showError(message: "Tên đăng nhập hoặc mật khẩu không đúng");
    } finally {
      hideLoading();
    }
  }
}

Future<void> login() async {}

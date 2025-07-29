import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';
import 'package:male_clothing_store/app/services/auth_service.dart';

class RegisterController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final AuthService _authService = AuthService();

  Future<void> register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final pass = passwordController.text;

    if (!(formKey.currentState?.validate() ?? false)) return;

    unfocus();

    try {
      showLoading(message: "Đang đăng ký...");
      await _authService.registerWithEmail(
        email: email,
        password: pass,
        name: name,
      );
      hideLoading();
      await showSuccess(message: 'Đăng ký thành công!');
      goTo(AppRoutes.login);
    } catch (e) {
      hideLoading();
      await showError(message: 'Email đã tồn tại hoặc có lỗi xảy ra!');
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

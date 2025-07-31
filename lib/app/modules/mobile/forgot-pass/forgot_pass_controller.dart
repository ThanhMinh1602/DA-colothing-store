import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';
import 'package:male_clothing_store/app/services/auth_service.dart';

class ForgotPassController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> sendResetLink() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    unfocus();

    final email = emailController.text.trim();
    try {
      showLoading(message: 'Đang gửi email...');
      await _authService.sendPasswordResetEmail(email);

      await showSuccess(message: 'Hãy kiểm tra email để đặt lại mật khẩu!');
      goBack();
    } catch (e) {
      hideLoading();

      await showError(message: 'Không gửi được email, vui lòng thử lại!');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}

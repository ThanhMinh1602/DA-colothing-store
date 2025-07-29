import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';

class WebLoginController extends BaseController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    unfocus();
    showLoading(message: "Đang đăng nhập...");
    try {
      await showSuccess(message: "Đăng nhập thành công!");
    } catch (e) {
      await showError(message: "Đăng nhập thất bại, vui lòng thử lại!");
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

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';

class ForgotPassController extends BaseController {
  final emailController = TextEditingController();

  void sendResetLink() async {
    showLoading();
    await Future.delayed(const Duration(seconds: 1));
    hideLoading();

    if (emailController.text.isNotEmpty && emailController.text.contains('@')) {
      showSnackbar(
        title: 'Thành công',
        message: 'Hãy kiểm tra email để đặt lại mật khẩu!',
        backgroundColor: Colors.green,
      );
      goBack();
    } else {
      showSnackbar(
        title: 'Lỗi',
        message: 'Vui lòng nhập email hợp lệ!',
        backgroundColor: Colors.red[400],
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}

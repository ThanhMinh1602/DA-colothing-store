import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';

abstract class BaseController extends GetxController {
  // Loading state dùng chung
  final isLoading = false.obs;

  // Hiện loading
  void showLoading() => isLoading.value = true;

  // Ẩn loading
  void hideLoading() => isLoading.value = false;

  // Hiện snackbar nhanh
  void showSnackbar({
    required String title,
    required String message,
    SnackPosition position = SnackPosition.BOTTOM,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 2),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      backgroundColor: backgroundColor,
      duration: duration,
    );
  }

  // Ẩn bàn phím
  void unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  // Điều hướng nhanh
  void goTo(String route, {dynamic arguments}) {
    Get.toNamed(route, arguments: arguments);
  }

  // Quay về màn trước
  void goBack([dynamic result]) {
    Get.back(result: result);
  }

  // Xử lý lỗi chung
  void handleError(Object e, [StackTrace? stackTrace]) {
    hideLoading();
    showSnackbar(
      title: 'Lỗi',
      message: e.toString(),
      backgroundColor: Colors.red[400],
    );
  }
}

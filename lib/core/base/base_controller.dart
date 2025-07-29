import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

abstract class BaseController extends GetxController {
  void showLoading({String? message}) {
    EasyLoading.show(status: message ?? "Đang xử lý...");
  }

  void hideLoading() {
    EasyLoading.dismiss();
  }

  Future<void> showSuccess({String? message}) async {
    await EasyLoading.showSuccess(message ?? 'Thành công');
  }

  Future<void> showError({String? message}) async {
    await EasyLoading.showError(message ?? 'Lỗi');
  }

  Future<void> showInfo({String? message}) async {
    await EasyLoading.showInfo(message ?? 'Info');
  }

  void unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void goTo(String route, {dynamic arguments}) {
    Get.toNamed(route, arguments: arguments);
  }

  void goBack([dynamic result]) {
    Get.back(result: result);
  }

  void goOffAll(String route, {dynamic arguments}) {
    Get.offAllNamed(route, arguments: arguments);
  }
}

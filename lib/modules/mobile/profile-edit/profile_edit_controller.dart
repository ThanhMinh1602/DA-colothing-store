import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/app/model/user_model.dart';
import 'package:male_clothing_store/app/services/user_service.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';

class ProfileEditController extends BaseController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  final _userService = UserService();

  Future<void> saveProfile(UserModel user) async {
    unfocus();
    showLoading(message: "Đang lưu thay đổi...");
    final newUser = UserModel(
      id: user.id,
      name: nameController.text.trim(),
      email: user.email,
      avatarUrl: user.avatarUrl,
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      role: user.role,
    );
    try {
      await _userService.updateUser(user.id, newUser);
      hideLoading();
      await showSuccess(message: "Cập nhật thành công");
      goBack();
    } catch (e) {
      hideLoading();
      await showError(message: "Cập nhật thất bại, vui lòng thử lại!");
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }
}

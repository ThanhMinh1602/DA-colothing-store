import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/components/app-bar/custom_small_app_bar.dart';
import 'package:male_clothing_store/core/components/button/custom_button.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/app/model/user_model.dart';
import 'profile_edit_controller.dart';

class ProfileEditScreen extends StatelessWidget {
  ProfileEditScreen({super.key});
  final controller = Get.find<ProfileEditController>();

  @override
  Widget build(BuildContext context) {
    final UserModel user = Get.arguments as UserModel;

    controller.nameController.text = user.name;
    controller.emailController.text = user.email;
    controller.phoneController.text = user.phone ?? '';
    controller.addressController.text = user.address ?? '';

    return Scaffold(
      appBar: CustomSmallAppBar(title: 'Thông tin cá nhân'),
      backgroundColor: AppColor.backgroundColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        children: [
          Center(
            child: CircleAvatar(
              radius: 45,
              backgroundImage: user.avatarUrl != null
                  ? NetworkImage(user.avatarUrl!)
                  : null,
              backgroundColor: AppColor.grey2,
              child: user.avatarUrl == null
                  ? const Icon(Icons.person, size: 50, color: AppColor.grey4)
                  : null,
            ),
          ),
          const SizedBox(height: 28),

          _buildTextLabel('Họ và tên'),
          _buildTextField(controller.nameController, 'Nhập họ tên'),
          const SizedBox(height: 20),

          _buildTextLabel('Email'),
          _buildTextField(
            controller.emailController,
            'Nhập email',
            enabled: false,
          ),
          const SizedBox(height: 20),

          _buildTextLabel('Số điện thoại'),
          _buildTextField(
            controller.phoneController,
            'Nhập số điện thoại',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),

          _buildTextLabel('Địa chỉ'),
          _buildTextField(controller.addressController, 'Nhập địa chỉ'),
          const SizedBox(height: 32),
          CustomButton(
            onPressed: () => controller.saveProfile(user),
            btnText: 'Lưu thông tin',
          ),
        ],
      ),
    );
  }

  Widget _buildTextLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: CustomText(
        label,
        style: AppStyle.labelSmall.copyWith(color: AppColor.k292526),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    bool enabled = true,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      style: AppStyle.regular14,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppStyle.inputHint,
        filled: true,
        fillColor: AppColor.kFDFDFD,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColor.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColor.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColor.primary, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColor.grey2),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/components/button/custom_button.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/components/text-field/custom_text_field.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'register_controller.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterController>();
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(24),
          children: [
            CustomText(
              'Đăng ký',
              style: AppStyle.loginTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            CustomTextField(
              controller: controller.nameController,
              hintText: 'Họ và tên',
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: controller.emailController,
              hintText: 'Email',
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: controller.passwordController,
              hintText: 'Mật khẩu',
              isPassword: true,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: controller.confirmPasswordController,
              hintText: 'Xác nhận mật khẩu',
              isPassword: true,
            ),
            const SizedBox(height: 24),
            Obx(
              () => CustomButton(
                onPressed: controller.register,
                btnText: 'Đăng ký',
                isLoading: controller.isLoading.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

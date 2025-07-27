import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/components/button/custom_button.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/components/text-field/custom_text_field.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'forgot_pass_controller.dart';

class ForgotPassView extends StatelessWidget {
  const ForgotPassView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPassController>();
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(24),
          children: [
            CustomText(
              'Quên mật khẩu',
              style: AppStyle.loginTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            CustomText(
              'Nhập email để nhận liên kết đặt lại mật khẩu.',
              style: AppStyle.hintAction,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            CustomTextField(
              controller: controller.emailController,
              hintText: 'Email',
            ),
            const SizedBox(height: 24),
            Obx(
              () => CustomButton(
                onPressed: controller.sendResetLink,
                btnText: 'Gửi liên kết',
                isLoading: controller.isLoading.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

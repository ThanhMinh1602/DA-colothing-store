import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/components/button/custom_button.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/components/text-field/custom_text_field.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/core/extension/build_context_extension.dart';
import 'package:male_clothing_store/core/utils/validate_utils.dart';
import 'forgot_pass_controller.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';

class ForgotPassView extends StatelessWidget {
  const ForgotPassView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPassController>();
    return GestureDetector(
      onTap: context.unfocus,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Card containing the Forgot Password form fields
                Card(
                  elevation: 4.0,
                  color: AppColor.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomText(
                            Get.arguments.toString() == 'changePass'
                                ? 'Đổi mật khẩu'
                                : 'Quên mật khẩu',
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
                            validator: (value) =>
                                AppValidator.required(value) ??
                                AppValidator.email(value),
                          ),
                          const SizedBox(height: 24),

                          // Send Reset Link Button
                          CustomButton(
                            onPressed: controller.sendResetLink,
                            btnText: 'Gửi liên kết',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

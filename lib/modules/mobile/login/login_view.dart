import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';
import 'package:male_clothing_store/core/components/bottom-bar/custom_bottom_bar.dart';
import 'package:male_clothing_store/core/components/button/custom_button.dart';
import 'package:male_clothing_store/core/components/text-field/custom_text_field.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/core/extension/build_context_extension.dart';
import 'package:male_clothing_store/core/utils/validate_utils.dart';
import 'login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return GestureDetector(
      onTap: context.unfocus,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Icon above the login form

                // Card containing the form fields
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
                            'Đăng nhập',
                            style: AppStyle.loginTitle,
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
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: controller.passwordController,
                            hintText: 'Mật khẩu',
                            isPassword: true,
                            validator: AppValidator.password,
                          ),
                          const SizedBox(height: 16),

                          // Forgot Password link below the password field
                          InkWell(
                            onTap: () => Get.toNamed(AppRoutes.forgotPass),
                            child: Text(
                              'Quên mật khẩu?',
                              style: AppStyle.linkAction,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Login Button
                          CustomButton(
                            onPressed: controller.login,
                            btnText: 'Đăng nhập',
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
        bottomNavigationBar: CustomBottomBar(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => Get.toNamed(AppRoutes.register),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Chưa có tài khoản? ',
                    style: AppStyle.hintAction,
                    children: [
                      TextSpan(text: 'Đăng ký', style: AppStyle.linkAction),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

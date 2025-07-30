import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/components/bottom-bar/custom_bottom_bar.dart';
import 'package:male_clothing_store/core/components/button/custom_button.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/components/text-field/custom_text_field.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/core/extension/build_context_extension.dart';
import 'package:male_clothing_store/core/utils/validate_utils.dart';
import 'register_controller.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterController>();
    return GestureDetector(
      onTap: context.unfocus,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Card containing the registration form fields
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
                            'Đăng ký',
                            style: AppStyle.loginTitle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          CustomTextField(
                            controller: controller.nameController,
                            hintText: 'Họ và tên',
                            validator: AppValidator.required,
                          ),
                          const SizedBox(height: 16),
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
                          CustomTextField(
                            controller: controller.confirmPasswordController,
                            hintText: 'Xác nhận mật khẩu',
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Trường này không được để trống';
                              }
                              if (value != controller.passwordController.text) {
                                return 'Mật khẩu không trùng khớp';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),

                          // Register Button
                          CustomButton(
                            onPressed: controller.register,
                            btnText: 'Đăng ký',
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
                onTap: () => Get.toNamed(AppRoutes.login),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Đã có tài khoản? ',
                    style: AppStyle.hintAction,
                    children: [
                      TextSpan(text: 'Đăng nhập', style: AppStyle.linkAction),
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

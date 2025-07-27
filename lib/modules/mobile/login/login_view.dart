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
import 'login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return GestureDetector(
      onTap: () => context.unfocus(),
      child: Scaffold(
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(24),
            children: [
              CustomText(
                'Login',
                style: AppStyle.loginTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: controller.emailController,
                hintText: 'Email',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: controller.passwordController,
                hintText: 'Password',
                isPassword: true,
              ),
              const SizedBox(height: 24),
              Obx(
                () => CustomButton(
                  onPressed: controller.login,
                  btnText: 'Login',
                  isLoading: controller.isLoading.value,
                ),
              ),
            ],
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
              InkWell(
                onTap: () => Get.toNamed(AppRoutes.forgotPass),
                child: Text(
                  'Quên mật khẩu?',
                  style: AppStyle.linkAction,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

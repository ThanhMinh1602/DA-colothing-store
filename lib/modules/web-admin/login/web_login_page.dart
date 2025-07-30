import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/components/button/custom_button.dart';
import 'package:male_clothing_store/core/components/text-field/custom_text_field.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/modules/web-admin/login/web_login_controller.dart';

class WebLoginPage extends StatelessWidget {
  const WebLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WebLoginController>();
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: Card(
            elevation: 5,
            color: AppColor.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Tiêu đề
                    CustomText(
                      'Đăng nhập',
                      style: AppStyle.loginTitle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // TextField cho Email
                    CustomTextField(
                      controller: controller.emailController,
                      hintText: 'Email',
                    ),
                    const SizedBox(height: 20),

                    // TextField cho Password
                    CustomTextField(
                      controller: controller.passwordController,
                      hintText: 'Mật khẩu',
                      isPassword: true,
                    ),
                    const SizedBox(height: 32),

                    CustomButton(
                      onPressed: controller.login,
                      btnText: 'Đăng nhập',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

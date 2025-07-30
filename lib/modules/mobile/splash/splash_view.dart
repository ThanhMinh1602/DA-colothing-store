import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/modules/mobile/splash/splash_controller.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});
  final controller = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background with AppColor.gradientPrimary
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:
                AppColor.gradientPrimary, // gradientPrimary for stylish look
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo/Icon - can be replaced with your app's logo
              Icon(
                Icons.shopping_bag, // Placeholder icon
                size: 80,
                color: AppColor.white,
              ),
              SizedBox(height: 20),
              // App Name with improved styling using AppStyle
              Text(
                'NamWear',
                style: AppStyle.loginTitle.copyWith(
                  color: AppColor
                      .white, // Ensuring it's readable against the gradient
                ),
              ),
              SizedBox(height: 10),
              // Optional Tagline or additional text
              Text(
                'The best fashion for men',
                style: AppStyle.subtitle.copyWith(color: AppColor.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

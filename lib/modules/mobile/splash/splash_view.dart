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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColor.gradientPrimary,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.shopping_bag, size: 80, color: AppColor.white),
              SizedBox(height: 20),
              Text(
                'M Clothing Store',
                style: AppStyle.loginTitle.copyWith(color: AppColor.white),
              ),
              SizedBox(height: 10),

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

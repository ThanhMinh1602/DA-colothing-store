import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/modules/mobile/splash/splash_controller.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});
  final controller = Get.find<SplashController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: const Text(
          'NamWear',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:male_clothing_store/app/router/app_page.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NamWear',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
        textTheme: GoogleFonts.encodeSansTextTheme(),
        scaffoldBackgroundColor:
            AppColor.backgroundColor, // Background cho toàn app
      ),
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:male_clothing_store/app/router/app_page.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';
import 'package:male_clothing_store/app/services/notification_service.dart';
import 'package:male_clothing_store/app/services/permission_service.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load();

  await PermissionService.requestNotificationPermission();
  await NotificationService.init();

  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    // ignore: deprecated_member_use
    ..maskColor = Colors.black.withOpacity(0.2)
    ..backgroundColor = Colors.white
    ..indicatorColor = AppColor.primary
    ..textColor = AppColor.primary
    ..userInteractions = false;

  runApp(
    GetMaterialApp(
      title: 'M Clothing Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
        textTheme: GoogleFonts.encodeSansTextTheme(),
        scaffoldBackgroundColor: AppColor.backgroundColor,
      ),
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,

      builder: EasyLoading.init(),
    ),
  );
}

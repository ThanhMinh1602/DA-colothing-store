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
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:male_clothing_store/firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:male_clothing_store/get_server_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load();
  if (!kIsWeb) {
    await PermissionService.requestNotificationPermission();
    await NotificationService.init();
    // }
    // final GetServerKey serverKey = GetServerKey();
    // String? key = await serverKey.getServerKey();
    // print("Server Key: $key ------");
  }
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..maskColor = Colors.black.withOpacity(0.2)
    ..backgroundColor = Colors.white
    ..indicatorColor = AppColor.primary
    ..textColor = AppColor.primary
    ..userInteractions = false
    ..dismissOnTap = false;

  runApp(
    GetMaterialApp(
      title: 'NamWear',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
        textTheme: GoogleFonts.encodeSansTextTheme(),
        scaffoldBackgroundColor: AppColor.backgroundColor,
      ),
      defaultTransition: kIsWeb ? Transition.fade : Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: kIsWeb ? 0 : 200),
      initialRoute: kIsWeb ? WebRouter.dashboard : AppRoutes.splash,
      getPages: kIsWeb ? WebPage.routes : AppPages.routes,

      builder: EasyLoading.init(),
    ),
  );
}

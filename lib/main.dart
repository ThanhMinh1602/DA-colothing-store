import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:male_clothing_store/app/router/app_page.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:male_clothing_store/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
    ),
  );
}

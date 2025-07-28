import 'package:get/get.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';
import 'package:male_clothing_store/modules/mobile/cart/cart_binding.dart';
import 'package:male_clothing_store/modules/mobile/cart/cart_view.dart';
import 'package:male_clothing_store/modules/mobile/checkout/checkout_binding.dart';
import 'package:male_clothing_store/modules/mobile/checkout/checkout_view.dart';
import 'package:male_clothing_store/modules/mobile/favourite/favourite_binding.dart';
import 'package:male_clothing_store/modules/mobile/favourite/favourite_screen.dart';
import 'package:male_clothing_store/modules/mobile/forgot-pass/forgot_pass_binding.dart';
import 'package:male_clothing_store/modules/mobile/forgot-pass/forgot_pass_view.dart';
import 'package:male_clothing_store/modules/mobile/home/home_binding.dart';
import 'package:male_clothing_store/modules/mobile/home/home_screen.dart';
import 'package:male_clothing_store/modules/mobile/login/login_binding.dart';
import 'package:male_clothing_store/modules/mobile/login/login_view.dart';
import 'package:male_clothing_store/modules/mobile/main/main_binding.dart';
import 'package:male_clothing_store/modules/mobile/main/main_view.dart';
import 'package:male_clothing_store/modules/mobile/product-detail/product_detail_binding.dart';
import 'package:male_clothing_store/modules/mobile/product-detail/product_detail_view.dart';
import 'package:male_clothing_store/modules/mobile/profile/profile_binding.dart';
import 'package:male_clothing_store/modules/mobile/profile/profile_screen.dart';
import 'package:male_clothing_store/modules/mobile/register/register_binding.dart';
import 'package:male_clothing_store/modules/mobile/register/register_view.dart';
import 'package:male_clothing_store/modules/mobile/splash/splash_binding.dart';
import 'package:male_clothing_store/modules/mobile/splash/splash_view.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPass,
      page: () => const ForgotPassView(),
      binding: ForgotPassBinding(),
    ),
    GetPage(
      name: AppRoutes.productDetail,
      page: () => ProductDetailView(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.checkout,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainView(),
      bindings: [
        MainBinding(),
        HomeBinding(),
        CartBinding(),
        FavouriteBinding(),
        ProfileBinding(),
      ],
      children: [
        GetPage(name: AppRoutes.home, page: () => HomeScreen()),
        GetPage(name: AppRoutes.cart, page: () => const CartView()),
        GetPage(name: AppRoutes.favourite, page: () => const FavouriteScreen()),
        GetPage(name: AppRoutes.profile, page: () => const ProfileScreen()),
      ],
    ),
  ];
}

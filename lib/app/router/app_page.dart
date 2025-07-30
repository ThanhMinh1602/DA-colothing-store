import 'package:get/get.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';
import 'package:male_clothing_store/modules/mobile/cart/cart_binding.dart';
import 'package:male_clothing_store/modules/mobile/cart/cart_view.dart';
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
import 'package:male_clothing_store/modules/mobile/profile-edit/profile_edit_binding.dart';
import 'package:male_clothing_store/modules/mobile/profile-edit/profile_edit_screen.dart';
import 'package:male_clothing_store/modules/mobile/profile/profile_binding.dart';
import 'package:male_clothing_store/modules/mobile/profile/profile_screen.dart';
import 'package:male_clothing_store/modules/mobile/register/register_binding.dart';
import 'package:male_clothing_store/modules/mobile/register/register_view.dart';
import 'package:male_clothing_store/modules/mobile/splash/splash_binding.dart';
import 'package:male_clothing_store/modules/mobile/splash/splash_view.dart';
import 'package:male_clothing_store/modules/web-admin/category-manager/category_manager_binding.dart';
import 'package:male_clothing_store/modules/web-admin/category-manager/category_manager_page.dart';
import 'package:male_clothing_store/modules/web-admin/chat-bot/chat_bot_bingding.dart';
import 'package:male_clothing_store/modules/web-admin/chat-bot/chat_bot_page.dart';
import 'package:male_clothing_store/modules/web-admin/dash-board/dash_board_binding.dart';
import 'package:male_clothing_store/modules/web-admin/dash-board/dash_board_page.dart';
import 'package:male_clothing_store/modules/web-admin/login/web_login_binding.dart';
import 'package:male_clothing_store/modules/web-admin/login/web_login_page.dart';
import 'package:male_clothing_store/modules/web-admin/order-manager/order_manager_binding.dart';
import 'package:male_clothing_store/modules/web-admin/order-manager/order_manager_controller.dart';
import 'package:male_clothing_store/modules/web-admin/order-manager/order_manager_page.dart';
import 'package:male_clothing_store/modules/web-admin/product-manager/product_manager_binding.dart';
import 'package:male_clothing_store/modules/web-admin/product-manager/product_manager_page.dart';

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
      name: AppRoutes.profileEdit,
      page: () => ProfileEditScreen(),
      binding: ProfileEditBinding(),
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

class WebPage {
  static final routes = [
    // Login page
    GetPage(
      name: WebRouter.login,
      page: () => WebLoginPage(),
      binding: WebLoginBinding(),
    ),

    // Main shell page (bao gồm sidebar/header)
    GetPage(
      name: WebRouter.dashboard,
      page: () => DashBoardPage(),
      binding: DashBoardBinding(),
    ),
    // Product Manager
    GetPage(
      name: WebRouter.productManager,
      page: () => ProductManagerPage(),
      binding: ProductManagerBinding(),
    ),
    // Category Manager
    GetPage(
      name: WebRouter.categoryManager,
      page: () => CategoryManagerPage(),
      binding: CategoryManagerBinding(),
    ),
    GetPage(
      name: WebRouter.orderManager,
      page: () => OrderManagerPage(),
      binding: OrderManagerBinding(),
    ),
    GetPage(
      name: WebRouter.chatBot,
      page: () => ChatBotPage(),
      binding: ChatBotBingding(),
    ),
  ];
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/constants/app_assets.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/app/modules/mobile/cart/cart_view.dart';
import 'package:male_clothing_store/app/modules/mobile/favourite/favourite_screen.dart';
import 'package:male_clothing_store/app/modules/mobile/home/home_screen.dart';
import 'package:male_clothing_store/app/modules/mobile/profile/profile_screen.dart';
import 'main_controller.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();
    final List<String> iconAssets = [
      AppAssets.home2,
      AppAssets.shoppingBag,
      AppAssets.heart,
      AppAssets.profile,
    ];

    return Obx(
      () => Scaffold(
        body: Stack(
          children: [
            IndexedStack(
              index: controller.tabIndex.value,
              children: [
                HomeScreen(),
                CartView(),
                FavouriteScreen(),
                ProfileScreen(),
              ],
            ),

            Positioned(
              bottom: 32.0,
              left: 24.0,
              right: 24.0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.k292526,
                  borderRadius: BorderRadius.circular(44),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(iconAssets.length, (index) {
                    final bool isActive = controller.tabIndex.value == index;
                    return GestureDetector(
                      onTap: () => controller.changeTab(index),
                      behavior: HitTestBehavior.opaque,
                      child: _buildNavBarItem(isActive, iconAssets, index),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBarItem(bool isActive, List<String> iconAssets, int index) {
    return FittedBox(
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive
              ? AppColor.white.withOpacity(0.08)
              : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            SvgPicture.asset(
              iconAssets[index],
              color: isActive
                  ? AppColor.white
                  : AppColor.white.withOpacity(0.6),
            ),
            const SizedBox(height: 1.0),

            if (isActive)
              CircleAvatar(backgroundColor: AppColor.white, radius: 2.0)
            else
              const SizedBox(height: 4.0),
          ],
        ),
      ),
    );
  }
}

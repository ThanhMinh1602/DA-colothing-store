import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/components/button/custom_outline_circle_button.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_assets.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';

class CustomSmallAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final bool showMenu;

  const CustomSmallAppBar({
    super.key,
    this.title = 'Thanh toán',
    this.showBack = true,
    this.showMenu = true,
  });

  bool get _isNoIconTitle =>
      title.trim().toLowerCase() == 'giỏ hàng' ||
      title.trim().toLowerCase() == 'yêu thích' ||
      title.trim().toLowerCase() == 'thông tin cá nhân' ||
      title.trim().toLowerCase() == 'đơn hàng';

  @override
  Widget build(BuildContext context) {
    final bool hideIcons = _isNoIconTitle;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: _isNoIconTitle ? 16.0 : 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            hideIcons || !showBack
                ? const SizedBox(width: 40.0)
                : CustomOutlineCircleButton(
                    size: 40.0,
                    iconSize: 24.0,
                    svgAsset: AppAssets.arrowLeft,
                    onTap: () => Get.back(),
                  ),
            Expanded(
              child: Center(
                child: CustomText(title, style: AppStyle.titleMedium),
              ),
            ),
            hideIcons || !showMenu
                ? const SizedBox(width: 40.0)
                : CustomOutlineCircleButton(
                    size: 40.0,
                    iconSize: 24.0,
                    svgAsset: AppAssets.menu,
                    onTap: () {},
                  ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_isNoIconTitle ? 72 : 56);
}

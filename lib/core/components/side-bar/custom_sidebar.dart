import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';

class SidebarMenuItem {
  final IconData icon;
  final String title;
  final String route;

  const SidebarMenuItem({
    required this.icon,
    required this.title,
    required this.route,
  });
}

class CustomSidebar extends StatelessWidget {
  final String currentTitle;
  final VoidCallback? onLogout;

  static const List<SidebarMenuItem> menuItems = [
    SidebarMenuItem(
      icon: Icons.dashboard,
      title: "Trang chủ",
      route: WebRouter.dashboard,
    ),
    SidebarMenuItem(
      icon: Icons.shopping_bag,
      title: "Sản phẩm",
      route: WebRouter.productManager,
    ),
    SidebarMenuItem(
      icon: Icons.category,
      title: "Danh mục",
      route: WebRouter.categoryManager,
    ),
    SidebarMenuItem(
      icon: Icons.receipt_long,
      title: "Đơn hàng",
      route: WebRouter.orderManager,
    ),
    SidebarMenuItem(
      icon: Icons.chat,
      title: "Chat bot",
      route: WebRouter.chatBot,
    ),
  ];

  const CustomSidebar({super.key, required this.currentTitle, this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: double.infinity,
      color: AppColor.white,
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: CustomText(
              'MaleStore',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColor.primary,
                letterSpacing: 2,
              ),
            ),
          ),

          ...menuItems.map((item) {
            final isSelected = item.title == currentTitle;
            return ListTile(
              leading: Icon(
                item.icon,
                color: isSelected ? AppColor.primary : AppColor.iconGrey,
              ),
              title: Text(
                item.title,
                style: TextStyle(
                  color: isSelected ? AppColor.primary : AppColor.iconGrey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              onTap: () {
                if (Get.currentRoute != item.route) {
                  Get.offNamed(item.route);
                }
              },
            );
          }),
          const Spacer(),

          ListTile(
            leading: const Icon(Icons.logout, color: AppColor.error),
            title: const Text(
              'Đăng xuất',
              style: TextStyle(color: AppColor.error),
            ),
            onTap:
                onLogout ??
                () {
                  Get.offAllNamed(WebRouter.login);
                },
          ),
        ],
      ),
    );
  }
}

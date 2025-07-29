import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';
import 'package:male_clothing_store/core/components/app-bar/custom_small_app_bar.dart';
import 'package:male_clothing_store/core/components/button/custom_button.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/modules/mobile/profile/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSmallAppBar(title: 'Thông tin cá nhân'),
      body: Obx(() {
        final user = controller.user.value;
        if (user == null) {
          // Show loading hoặc skeleton
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 44,
                    backgroundImage: user.avatarUrl != null
                        ? NetworkImage(user.avatarUrl!)
                        : null,
                    backgroundColor: AppColor.grey2,
                    child: user.avatarUrl == null
                        ? const Icon(
                            Icons.person,
                            size: 50,
                            color: AppColor.grey4,
                          )
                        : null,
                  ),
                  const SizedBox(height: 12),
                  CustomText(
                    user.name,
                    style: AppStyle.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  CustomText(
                    user.email,
                    style: AppStyle.regular14.copyWith(color: AppColor.grey3),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildProfileMenu(
              icon: Icons.receipt_long,
              title: 'Đơn hàng của tôi',
              onTap: () {},
            ),

            _buildProfileMenu(
              icon: Icons.lock_outline,
              title: 'Đổi mật khẩu',
              onTap: () {},
            ),
            _buildProfileMenu(
              icon: Icons.info_outline,
              title: 'Thông tin tài khoản',
              onTap: () {
                Get.toNamed(
                  AppRoutes.profileEdit,
                  arguments: controller.user.value,
                );
              },
            ),
            const SizedBox(height: 32),
            CustomButton(
              btnText: "Đăng xuất",
              backgroundColor: Colors.redAccent,
              onPressed: () async {
                await controller.logout(context);
              },
            ),
          ],
        );
      }),
    );
  }

  Widget _buildProfileMenu({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, color: AppColor.k292526),
          title: CustomText(title, style: AppStyle.regular14),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
        Divider(height: 1, color: AppColor.grey6),
      ],
    );
  }
}

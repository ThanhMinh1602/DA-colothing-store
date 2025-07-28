import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/components/app-bar/custom_small_app_bar.dart';
import 'package:male_clothing_store/core/components/button/custom_button.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/core/extension/build_context_extension.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Giả lập dữ liệu user, sau này thay bằng controller hoặc model user thực tế
    final String userName = "Nguyễn Văn Nam";
    final String email = "nam.nguyen@example.com";
    final String avatarUrl =
        "https://i.pravatar.cc/150?img=3"; // Có thể thay bằng link khác

    return Scaffold(
      appBar: CustomSmallAppBar(title: 'Thông tin cá nhân'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        children: [
          // Avatar + tên + email
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                const SizedBox(height: 12),
                CustomText(
                  userName,
                  style: AppStyle.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                CustomText(
                  email,
                  style: AppStyle.regular14.copyWith(color: AppColor.grey3),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Danh sách menu tài khoản
          _buildProfileMenu(
            icon: Icons.receipt_long,
            title: 'Đơn hàng của tôi',
            onTap: () {},
          ),
          _buildProfileMenu(
            icon: Icons.location_on_outlined,
            title: 'Sổ địa chỉ',
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
            onTap: () {},
          ),
          const SizedBox(height: 32),
          // Nút đăng xuất
          CustomButton(
            btnText: "Đăng xuất",
            backgroundColor: Colors.redAccent,
            onPressed: () {
              Get.snackbar(
                'Đăng xuất',
                'Bạn đã đăng xuất khỏi tài khoản!',
                backgroundColor: Colors.red.shade100,
                colorText: Colors.black,
              );
            },
          ),
        ],
      ),
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

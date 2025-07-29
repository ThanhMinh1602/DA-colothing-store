import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/app/model/user_model.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.userModel});
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText('Xin chào 👋', style: AppStyle.bodySmall12),
                const SizedBox(height: 4.0),
                CustomText(
                  userModel?.name ?? 'Người dùng',
                  style: AppStyle.titleMedium,
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                if (userModel != null) {
                  Get.toNamed(AppRoutes.profileEdit, arguments: userModel);
                }
              },
              child: CircleAvatar(
                radius: 20,
                backgroundImage:
                    (userModel?.avatarUrl != null &&
                        userModel!.avatarUrl!.isNotEmpty)
                    ? NetworkImage(userModel!.avatarUrl!)
                    : null,
                backgroundColor: AppColor.grey2,
                child:
                    (userModel?.avatarUrl == null ||
                        userModel!.avatarUrl!.isEmpty)
                    ? const Icon(Icons.person, color: AppColor.grey4)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

import 'package:flutter/material.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText('Hello, Welcome 👋', style: AppStyle.bodySmall12),
                SizedBox(height: 4.0),
                CustomText('Albert Stevano', style: AppStyle.titleMedium),
              ],
            ),
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                'https://cdn2.tuoitre.vn/zoom/700_700/2019/5/8/avatar-publicitystill-h2019-1557284559744252594756-crop-15572850428231644565436.jpg',
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_assets.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String category;
  final String price;
  final double rating;
  final VoidCallback? onFavoriteTap;

  const ProductItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Positioned(
              right: 14.0,
              top: 14.0,
              child: GestureDetector(
                onTap: onFavoriteTap,
                child: CircleAvatar(
                  radius: 12.0,
                  backgroundColor: AppColor.k292526,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(
                      AppAssets.heart,
                      color: AppColor.kFDFDFD,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        CustomText(name, style: AppStyle.titleMedium),
        const SizedBox(height: 4.0),
        CustomText(category, style: AppStyle.bodySmall10),
        const SizedBox(height: 12.0),
        Row(
          children: [
            CustomText(price, style: AppStyle.titleMedium),
            const Spacer(),
            SvgPicture.asset(AppAssets.star, width: 16, height: 16),
            const SizedBox(width: 4.0),
            CustomText(rating.toStringAsFixed(1), style: AppStyle.bodySmall12),
            const SizedBox(width: 10.0),
          ],
        ),
      ],
    );
  }
}

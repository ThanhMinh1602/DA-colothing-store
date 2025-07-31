import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:male_clothing_store/core/components/common/quantity_stepper.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_assets.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';

class ProductCartItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String category;
  final String price;

  final int? quantity;
  final ValueChanged<int>? onQuantityChanged;

  final bool isFavourite;
  final VoidCallback? onFavouriteTap;

  final VoidCallback? onMenuTap;

  const ProductCartItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.price,
    this.quantity,
    this.onQuantityChanged,
    this.isFavourite = false,
    this.onFavouriteTap,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: Image.network(
              imageUrl,
              width: 70.0,
              height: 70.0,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          const SizedBox(width: 15.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(title, style: AppStyle.productCardTitle),
                const SizedBox(height: 4.0),
                CustomText(category, style: AppStyle.bodySmall10),
                const SizedBox(height: 4.0),
                const Spacer(),
                CustomText(price, style: AppStyle.productCardTitle),
              ],
            ),
          ),
          const SizedBox(width: 15.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isFavourite
                  ? IconButton(
                      icon: Icon(Icons.favorite, color: Colors.red.shade400),
                      onPressed: onFavouriteTap,
                      tooltip: 'Bỏ khỏi yêu thích',
                    )
                  : GestureDetector(
                      onTap: onMenuTap,
                      child: SvgPicture.asset(AppAssets.menu1),
                    ),

              if (!isFavourite && quantity != null && onQuantityChanged != null)
                QuantityStepper(value: quantity!, onChanged: onQuantityChanged!)
              else if (isFavourite)
                const SizedBox(height: 24),
            ],
          ),
        ],
      ),
    );
  }
}

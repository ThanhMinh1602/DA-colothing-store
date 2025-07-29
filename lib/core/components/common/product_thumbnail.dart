import 'package:flutter/material.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';

class ProductThumbnail extends StatelessWidget {
  final String? imageUrl;
  final double size;

  const ProductThumbnail({super.key, this.imageUrl, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: imageUrl == null || imageUrl!.isEmpty
          ? Container(
              width: size,
              height: size,
              color: AppColor.grey3,
              child: const Icon(
                Icons.image,
                size: 28,
                color: AppColor.iconGrey,
              ),
            )
          : Image.network(
              imageUrl!,
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(
                width: size,
                height: size,
                color: AppColor.grey3,
                child: const Icon(Icons.broken_image, color: AppColor.error),
              ),
            ),
    );
  }
}

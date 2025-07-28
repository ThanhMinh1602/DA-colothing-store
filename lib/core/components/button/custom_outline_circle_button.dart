import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomOutlineCircleButton extends StatelessWidget {
  final IconData? iconData;
  final String? svgAsset;
  final VoidCallback onTap;
  final double size;
  final double iconSize;
  final Color borderColor;
  final double borderWidth;
  final Color? iconColor;
  final Color? backgroundColor;

  const CustomOutlineCircleButton({
    super.key,
    this.iconData,
    this.svgAsset,
    required this.onTap,
    this.size = 32.0,
    this.iconSize = 16.0,
    this.borderColor = const Color(0xFFE0E0E0),
    this.borderWidth = 1.0,
    this.iconColor,
    this.backgroundColor,
  }) : assert(
         iconData != null || svgAsset != null,
         'Bạn phải truyền iconData hoặc svgAsset!',
       );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(9999),
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          border: Border.all(width: borderWidth, color: borderColor),
        ),
        child: Center(
          child: svgAsset != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    svgAsset!,
                    width: iconSize,
                    height: iconSize,
                    color: iconColor ?? Colors.black,
                  ),
                )
              : Icon(
                  iconData,
                  size: iconSize,
                  color: iconColor ?? Colors.black,
                ),
        ),
      ),
    );
  }
}

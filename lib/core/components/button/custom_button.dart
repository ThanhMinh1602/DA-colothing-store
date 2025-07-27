import 'package:flutter/material.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? btnText;
  final Widget? child;

  const CustomButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor = Colors.white,
    this.btnText,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      height: 60,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColor.primary,
          foregroundColor: foregroundColor ?? AppColor.kFDFDFD,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          elevation: 0, // Nếu bạn không muốn shadow
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColor.kFDFDFD,
                ),
              )
            : child ?? CustomText(btnText ?? '', style: AppStyle.buttonText),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';

class CustomDialog {
  static Future<bool> showConfirmDialog({
    required BuildContext context,
    String title = "Xác nhận",
    required String message,
    String cancelText = "Huỷ",
    String confirmText = "Xoá",
    Color? confirmColor,
    Color? cancelColor,
    TextStyle? titleStyle,
    TextStyle? contentStyle,
    TextStyle? confirmStyle,
    TextStyle? cancelStyle,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title, style: titleStyle ?? AppStyle.semiBold14),
        content: Text(message, style: contentStyle ?? AppStyle.regular14),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            style: TextButton.styleFrom(
              foregroundColor: cancelColor ?? AppColor.k292526,
              textStyle: cancelStyle ?? AppStyle.semiBold14,
            ),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmColor ?? Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle:
                  confirmStyle ??
                  AppStyle.semiBold14.copyWith(color: Colors.white),
              elevation: 0,
              foregroundColor: Colors.white,
            ),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result == true;
  }

  static Future<bool?> showDeleteConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColor.dialogBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: CustomText(title, style: AppStyle.bottomSheetTitle),
        content: CustomText(message, style: AppStyle.dialogMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const CustomText('Huỷ', style: AppStyle.hintAction),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const CustomText('Xoá', style: AppStyle.buttonPrimary),
          ),
        ],
      ),
    );
  }
}

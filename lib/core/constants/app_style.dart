import 'package:flutter/material.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';

class AppStyle {
  static const TextStyle buttonText = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 1.4,
    letterSpacing: 0,
    fontStyle: FontStyle.normal,
    color: Colors.white,
  );
  static const TextStyle productCardTitle = TextStyle(
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    height: 1.0,
    letterSpacing: 0,
    color: Colors.black,
  );
  static const TextStyle loginTitle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 28,
    color: Color(0xFF292526),
    letterSpacing: 0.5,
    height: 1.2,
  );

  static const TextStyle hintAction = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Color(0xFF757575),
    height: 1.4,
  );

  static const TextStyle linkAction = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: Color(0xFF292526),
    decoration: TextDecoration.underline,
    height: 1.4,
  );
  static const semiBold14 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1.0, // line-height 100%
    letterSpacing: 0,
  );
  static const regular14 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.0, // line-height 100%
    letterSpacing: 0,
  );

  static TextStyle bodySmall10 = TextStyle(
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 10,
    height: 1.5,
    letterSpacing: 0,
    color: AppColor.grey4,
  );
  static const TextStyle bodySmall12 = TextStyle(
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 12,
    height: 1.5,
    letterSpacing: 0,
    color: Colors.black,
  );
  static const TextStyle titleMedium = TextStyle(
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0,
    color: Colors.black,
  );
  static const TextStyle headingLarge = TextStyle(
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 24,
    height: 1.3,
    letterSpacing: 0,
    color: Colors.black,
  );
  static const TextStyle bodySmallBold = TextStyle(
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 12,
    height: 1.5,
    letterSpacing: 0,
    color: Colors.black,
  );
  // Text lớn nổi bật, ví dụ hiển thị giá to, số lớn, banner...
  static const TextStyle largeNumber = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 28,
    height: 1.1,
    color: AppColor.k292526,
    letterSpacing: 0,
  );

  // Tiêu đề danh mục hoặc section, trung bình
  static const TextStyle sectionTitle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: Colors.black,
    height: 1.3,
  );

  // Phụ đề nhỏ dưới heading, nhẹ
  static const TextStyle subtitle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 13,
    color: AppColor.grey3,
    height: 1.3,
  );

  // Text nhấn mạnh (danger/error)
  static const TextStyle error = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Colors.red,
    height: 1.3,
  );

  // Text thành công (success)
  static const TextStyle success = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Colors.green,
    height: 1.3,
  );

  // Label nhỏ trên form hoặc input
  static const TextStyle labelSmall = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 11,
    color: AppColor.grey4,
    height: 1.3,
  );

  // AppBar title mặc định
  static const TextStyle appBarTitle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: Colors.black,
    height: 1.2,
  );

  // Dùng cho số, số lượng, chip nhỏ
  static const TextStyle chip = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: Colors.black,
    height: 1.2,
  );

  // Mô tả nhỏ, text phụ, v.v.
  static const TextStyle caption = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 11,
    color: AppColor.grey4,
    height: 1.2,
  );

  // Giá to đậm, dùng cho sản phẩm
  static const TextStyle priceBig = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 22,
    color: Colors.black,
    height: 1.2,
    letterSpacing: 0,
  );

  // Giá nhỏ hơn, dùng cho giá gạch bỏ, giảm giá
  static const TextStyle priceOld = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColor.grey4,
    height: 1.2,
    decoration: TextDecoration.lineThrough,
  );

  // Style cho bottom sheet title
  static const TextStyle bottomSheetTitle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: Colors.black,
    height: 1.2,
  );

  // Style cho bottom sheet content
  static const TextStyle bottomSheetContent = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColor.grey4,
    height: 1.3,
  );

  // Style cho nút hành động nổi bật (primary)
  static const TextStyle buttonPrimary = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: Colors.white,
    height: 1.2,
  );

  // Style cho thông báo nhỏ ở dialog, snackbar
  static const TextStyle dialogMessage = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 15,
    color: AppColor.k292526,
    height: 1.4,
  );

  // Để dùng trong textfield, gợi ý placeholder
  static const TextStyle inputHint = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColor.grey3,
    height: 1.2,
  );
}

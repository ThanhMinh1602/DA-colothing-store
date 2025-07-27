import 'package:flutter/material.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';

class AppStyle {
  static const TextStyle buttonText = TextStyle(
    fontWeight: FontWeight.w700, // 700 = bold
    fontSize: 14,
    height: 1.4, // line height 140% = 1.4
    letterSpacing: 0,
    fontStyle: FontStyle.normal,
    color: Colors.white, // Thay đổi màu nếu muốn
  );
  static const TextStyle loginTitle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 28,
    color: Color(0xFF292526),
    letterSpacing: 0.5,
    height: 1.2,
  );
  // Dòng "Chưa có tài khoản? Đăng ký"
  static const TextStyle hintAction = TextStyle(
    fontFamily: 'EncodeSans',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Color(0xFF757575), // Màu xám nhẹ
    height: 1.4,
  );

  static const TextStyle linkAction = TextStyle(
    fontFamily: 'EncodeSans',
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: Color(0xFF292526), // Hoặc AppColor.primary cho nổi bật
    decoration: TextDecoration.underline,
    height: 1.4,
  );
  static TextStyle bodySmall10 = TextStyle(
    fontFamily: 'EncodeSans',
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 10,
    height: 1.5, // 150%
    letterSpacing: 0,
    color: AppColor.grey4, // hoặc màu bạn muốn
  );
  static const TextStyle bodySmall12 = TextStyle(
    fontFamily: 'EncodeSans',
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 12,
    height: 1.5, // 150%
    letterSpacing: 0,
    color: Colors.black, // hoặc màu bạn muốn
  );
  static const TextStyle titleMedium = TextStyle(
    fontFamily: 'EncodeSans',
    fontWeight: FontWeight.w700, // Bold
    fontStyle: FontStyle.normal,
    fontSize: 16,
    height: 1.5, // 150%
    letterSpacing: 0,
    color: Colors.black, // Đổi màu tuỳ nhu cầu
  );
  static const TextStyle headingLarge = TextStyle(
    fontFamily: 'EncodeSans',
    fontWeight: FontWeight.w600, // SemiBold
    fontStyle: FontStyle.normal,
    fontSize: 24,
    height: 1.3, // 130%
    letterSpacing: 0,
    color: Colors.black, // Đổi màu theo theme nếu cần
  );
   static const TextStyle bodySmallBold = TextStyle(
    fontFamily: 'EncodeSans',
    fontWeight: FontWeight.w700, // Bold
    fontStyle: FontStyle.normal,
    fontSize: 12,
    height: 1.5, // 150%
    letterSpacing: 0,
    color: Colors.black, // Đổi theo nhu cầu
  );
}

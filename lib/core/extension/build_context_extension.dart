import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  /// Lấy padding top của safe area (ví dụ: status bar)
  double get paddingTop => MediaQuery.of(this).padding.top;

  /// Lấy padding bottom của safe area (ví dụ: khu vực điều hướng)
  double get paddingBottom => MediaQuery.of(this).padding.bottom;

  /// Lấy khoảng trống của bàn phím (viewInsets)
  double get viewInsetsBottom => MediaQuery.of(this).viewInsets.bottom;

  /// Kiểm tra xem bàn phím có đang hiển thị không
  bool get isKeyboardOpen => MediaQuery.of(this).viewInsets.bottom > 0;

  /// Lấy chiều rộng màn hình
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Lấy chiều cao màn hình
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Tổng padding vertical (top + bottom)
  double get paddingVertical =>
      MediaQuery.of(this).padding.top + MediaQuery.of(this).padding.bottom;

  /// Tổng padding horizontal (left + right)
  double get paddingHorizontal =>
      MediaQuery.of(this).padding.left + MediaQuery.of(this).padding.right;

  void unfocus() => FocusScope.of(this).unfocus();
}

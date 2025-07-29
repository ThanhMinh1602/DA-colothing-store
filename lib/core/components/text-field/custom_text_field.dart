import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:male_clothing_store/core/constants/app_assets.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool isPassword;
  final bool isSearch;
  final TextStyle? textStyle;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.isPassword = false,
    this.textStyle,
    this.keyboardType,
    this.isSearch = false,
    this.onChanged,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        validator: widget.validator,
        obscureText: widget.isPassword ? _obscureText : false,
        style: widget.textStyle ?? const TextStyle(fontSize: 14),
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: AppColor.grey6, // tuỳ chỉnh màu hint nếu muốn
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColor.grey6, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColor.grey6, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF292526), width: 1.5),
          ),
          prefixIcon: widget.isSearch
              ? FittedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 14.0,
                      horizontal: 16.0,
                    ).copyWith(right: 8.0),
                    child: SvgPicture.asset(
                      AppAssets.searchNormal,
                      color: AppColor.grey6,
                    ),
                  ),
                )
              : null,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: const Color(0xFFB0B0B0),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}

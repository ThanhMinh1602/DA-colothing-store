import 'package:flutter/material.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/core/utils/validate_utils.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/components/text-field/custom_text_field.dart';

class CategoryDialog extends StatefulWidget {
  final String title;
  final String? initialName;
  final Future<void> Function(String name) onSubmit;
  final bool isLoading;

  const CategoryDialog({
    super.key,
    required this.title,
    this.initialName,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? "");
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.dialogBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: CustomText(widget.title, style: AppStyle.bottomSheetTitle),
      content: Form(
        key: _formKey,
        child: CustomTextField(
          controller: _nameController,
          hintText: "Nhập tên danh mục",
          validator: AppValidator.required,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const CustomText('Huỷ', style: AppStyle.hintAction),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: widget.isLoading
              ? null
              : () async {
                  if (_formKey.currentState!.validate()) {
                    await widget.onSubmit(_nameController.text.trim());
                    Navigator.pop(context);
                  }
                },
          child: widget.isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const CustomText('Lưu', style: AppStyle.buttonPrimary),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/components/text-field/custom_text_field.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/core/utils/validate_utils.dart';
import 'package:male_clothing_store/app/model/category_model.dart';
import 'package:male_clothing_store/app/model/product_model.dart';

class ProductDialog extends StatefulWidget {
  final String title;
  final Future<void> Function(ProductModel product) onSubmit;
  final List<CategoryModel> categories;
  final ProductModel? initialProduct;
  final bool isLoading;

  const ProductDialog({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.categories,
    this.initialProduct,
    this.isLoading = false,
  });

  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _imageUrlController;
  late final TextEditingController _sizesController;
  late final TextEditingController _colorsController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _quantityController;

  String? _selectedCategory;
  String _imagePreview = '';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.initialProduct?.name ?? "",
    );
    _priceController = TextEditingController(
      text: widget.initialProduct?.price.toString() ?? "",
    );
    _imageUrlController = TextEditingController(
      text: widget.initialProduct?.imageUrl ?? "",
    );
    _sizesController = TextEditingController(
      text: widget.initialProduct?.sizes?.join(", ") ?? '',
    );
    _colorsController = TextEditingController(
      text: widget.initialProduct?.colors?.join(", ") ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.initialProduct?.description ?? '',
    );
    _quantityController = TextEditingController(
      text: widget.initialProduct?.quantity.toString() ?? '',
    );

    _selectedCategory = widget.initialProduct?.category;
    _imagePreview = widget.initialProduct?.imageUrl ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();

    _sizesController.dispose();
    _colorsController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.dialogBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: CustomText(widget.title, style: AppStyle.bottomSheetTitle),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: _nameController,
                hintText: 'Tên sản phẩm',
                validator: AppValidator.required,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _priceController,
                hintText: 'Giá',
                keyboardType: TextInputType.number,
                validator: AppValidator.positiveNumber,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                isExpanded: true,

                items: widget.categories.map((cat) {
                  return DropdownMenuItem(
                    value: cat.name,
                    child: Text(cat.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedCategory = value);
                },
                decoration: InputDecoration(
                  hintStyle: AppStyle.hintAction,
                  hintText: 'Chọn danh mục',
                  filled: true,
                  fillColor: AppColor.grey6,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: AppValidator.requiredDropdown,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _imageUrlController,
                hintText: 'Link ảnh (URL)',
                onChanged: (val) {
                  setState(() {
                    _imagePreview = val.trim();
                  });
                },
                validator: AppValidator.imageUrl,
              ),
              const SizedBox(height: 10),
              if (_imagePreview.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    _imagePreview,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(
                      height: 80,
                      width: 80,
                      color: AppColor.grey3,
                      child: const Icon(
                        Icons.broken_image,
                        color: AppColor.error,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _sizesController,
                hintText: 'Các size (vd: S, M, L, XL)',
                validator: AppValidator.required,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _colorsController,
                hintText: 'Các màu sắc (vd: Đỏ, Xanh, Đen)',
                validator: AppValidator.required,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                isNumber: true,
                controller: _quantityController,
                hintText: 'Số lượng sản phẩm',
                validator: AppValidator.positiveNumber,
              ),

              const SizedBox(height: 12),
              CustomTextField(
                controller: _descriptionController,
                hintText: 'Mô tả sản phẩm',
                maxLines: 5,
              ),
            ],
          ),
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
                    await widget.onSubmit(
                      ProductModel(
                        id: widget.initialProduct?.id ?? '',
                        name: _nameController.text.trim(),
                        price:
                            double.tryParse(_priceController.text.trim()) ?? 0,
                        category: _selectedCategory!,
                        imageUrl: _imageUrlController.text.trim().isEmpty
                            ? null
                            : _imageUrlController.text.trim(),
                        sizes: _sizesController.text
                            .split(',')
                            .map((s) => s.trim())
                            .where((s) => s.isNotEmpty)
                            .toList(),
                        quantity:
                            int.tryParse(_quantityController.text.trim()) ??
                            100,
                        // Mặc định là 1 nếu không nhập
                        colors: _colorsController.text
                            .split(',')
                            .map((c) => c.trim())
                            .where((c) => c.isNotEmpty)
                            .toList(),
                        description: _descriptionController.text.trim(),
                      ),
                    );

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
              : CustomText(
                  widget.initialProduct == null ? 'Thêm' : 'Lưu',
                  style: AppStyle.buttonPrimary,
                ),
        ),
      ],
    );
  }
}

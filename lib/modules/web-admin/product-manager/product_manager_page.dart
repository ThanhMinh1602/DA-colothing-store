import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/components/dialog/custom_dialog.dart';
import 'package:male_clothing_store/core/components/side-bar/custom_sidebar.dart';
import 'package:male_clothing_store/core/components/text-field/custom_text_field.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/modules/web-admin/product-manager/product_manager_controller.dart';
import 'package:male_clothing_store/app/model/product_model.dart';
import 'package:male_clothing_store/modules/web-admin/product-manager/widgets/product_dialog.dart';

class ProductManagerPage extends StatelessWidget {
  const ProductManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductManagerController>();

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Row(
        children: [
          const CustomSidebar(currentTitle: 'Sản phẩm'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        "Quản lý sản phẩm",
                        style: AppStyle.loginTitle.copyWith(fontSize: 28),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        onPressed: () => _showAddDialog(context, controller),
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const CustomText(
                          'Thêm sản phẩm',
                          style: AppStyle.buttonPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Obx(
                        () => IntrinsicWidth(
                          child: DropdownButtonFormField<String>(
                            value: controller.selectedCategory.value.isEmpty
                                ? null
                                : controller.selectedCategory.value,
                            hint: const Text('Tất cả danh mục'),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColor.grey6,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            items: [
                              const DropdownMenuItem(
                                value: '',
                                child: Text('Tất cả'),
                              ),
                              ...controller.categories
                                  .map(
                                    (cat) => DropdownMenuItem(
                                      value: cat.name,
                                      child: Text(cat.name),
                                    ),
                                  )
                                  .toList(),
                            ],
                            onChanged: controller.onCategoryChanged,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 220,
                        child: CustomTextField(
                          hintText: 'Nhập tên hoặc danh mục...',
                          onChanged: controller.onSearchChanged,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Expanded(
                    child: Card(
                      color: AppColor.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Obx(() {
                          if (controller.products.isEmpty) {
                            return const Center(
                              child: CustomText('Chưa có sản phẩm nào'),
                            );
                          }
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.grey2,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: const [
                                      Expanded(
                                        flex: 1,
                                        child: CustomText(
                                          textAlign: TextAlign.center,
                                          'Ảnh',
                                          style: AppStyle.semiBold14,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: CustomText(
                                          'Tên sản phẩm',
                                          style: AppStyle.semiBold14,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: CustomText(
                                          'Giá',
                                          style: AppStyle.semiBold14,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: CustomText(
                                          'Danh mục',
                                          style: AppStyle.semiBold14,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: CustomText(
                                          'Size',
                                          style: AppStyle.semiBold14,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: CustomText(
                                          'Màu sắc',
                                          style: AppStyle.semiBold14,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: CustomText(
                                          'Mô tả',
                                          style: AppStyle.semiBold14,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: CustomText(
                                          'Thao tác',
                                          style: AppStyle.semiBold14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                  color: AppColor.borderLight,
                                ),
                                ...controller.products.map((prod) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColor.kFDFDFD,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: prod.imageUrl == null
                                              ? const Icon(
                                                  Icons.image,
                                                  size: 35,
                                                  color: AppColor.grey3,
                                                )
                                              : Image.network(
                                                  prod.imageUrl!,
                                                  width: 60,
                                                  height: 60,
                                                  fit: BoxFit.fitHeight,
                                                  alignment: Alignment.center,
                                                ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: CustomText(
                                            prod.name,
                                            style: AppStyle.productCardTitle
                                                .copyWith(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: CustomText(
                                            '${prod.price} đ',
                                            style: AppStyle.priceBig.copyWith(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: CustomText(
                                            prod.category,
                                            style: AppStyle.bodySmall12,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: CustomText(
                                            (prod.sizes?.join(', ') ?? ''),
                                            style: AppStyle.bodySmall12,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: CustomText(
                                            (prod.colors?.join(', ') ?? ''),
                                            style: AppStyle.bodySmall12,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: CustomText(
                                            prod.description ?? '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppStyle.bodySmall12,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.edit,
                                                  size: 20,
                                                  color: AppColor.blue,
                                                ),
                                                tooltip: 'Sửa',
                                                onPressed: () =>
                                                    _showEditDialog(
                                                      context,
                                                      controller,
                                                      prod,
                                                    ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  size: 20,
                                                  color: AppColor.error,
                                                ),
                                                tooltip: 'Xoá',
                                                onPressed: () =>
                                                    _showDeleteDialog(
                                                      context,
                                                      controller,
                                                      prod,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddDialog(
    BuildContext context,
    ProductManagerController controller,
  ) {
    showDialog(
      context: context,
      builder: (_) => ProductDialog(
        title: "Thêm sản phẩm mới",
        categories: controller.categories,
        onSubmit: (product) => controller.addProduct(product),
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    ProductManagerController controller,
    ProductModel product,
  ) {
    showDialog(
      context: context,
      builder: (_) => ProductDialog(
        title: "Sửa sản phẩm",
        categories: controller.categories,
        initialProduct: product,
        onSubmit: (prod) => controller.updateProduct(product.id, prod),
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    ProductManagerController controller,
    ProductModel product,
  ) async {
    final confirm = await CustomDialog.showDeleteConfirmDialog(
      context,
      title: "Xoá sản phẩm",
      message: 'Bạn chắc chắn muốn xoá sản phẩm "${product.name}"?',
    );
    if (confirm == true) {
      controller.deleteProduct(product.id);
    }
  }
}

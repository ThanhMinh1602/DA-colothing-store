import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/components/app-bar/admin_app_bar.dart';
import 'package:male_clothing_store/core/components/dialog/custom_dialog.dart';
import 'package:male_clothing_store/core/components/side-bar/custom_sidebar.dart';
import 'package:male_clothing_store/core/components/text-field/custom_text_field.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/app/modules/admin/product-manager/product_manager_controller.dart';
import 'package:male_clothing_store/app/model/product_model.dart';
import 'package:male_clothing_store/app/modules/admin/product-manager/widgets/product_dialog.dart';
import 'package:male_clothing_store/core/extension/build_context_extension.dart';

class ProductManagerPage extends StatelessWidget {
  const ProductManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductManagerController>();

    return GestureDetector(
      onTap: context.unfocus, // Dismiss keyboard on tap outside
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: AdminAppBar(title: 'Quản lý sản phẩm'),
        drawer: CustomSidebar(currentTitle: 'Sản phẩm'),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    onPressed: () => _showAddDialog(context, controller),
                    icon: const Icon(Icons.add, color: Colors.white, size: 20),
                    label: const CustomText(
                      'Thêm sản phẩm',
                      style: AppStyle.buttonPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => DropdownButtonFormField<String>(
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
                        ...controller.categories.map(
                          (cat) => DropdownMenuItem(
                            value: cat.name,
                            child: Text(cat.name),
                          ),
                        ),
                      ],
                      onChanged: controller.onCategoryChanged,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    hintText: 'Nhập tên hoặc danh mục...',
                    onChanged: controller.onSearchChanged,
                  ),
                  const SizedBox(height: 24),
                  Obx(
                    () => controller.products.isEmpty
                        ? const Center(
                            child: CustomText('Chưa có sản phẩm nào'),
                          )
                        : Column(
                            children: controller.products.map((prod) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _buildProductCard(
                                  context,
                                  controller,
                                  prod,
                                ),
                              );
                            }).toList(),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    ProductManagerController controller,
    ProductModel prod,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColor.grey2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: prod.imageUrl == null
                ? const Icon(Icons.image, size: 24, color: Colors.grey)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      prod.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image, size: 24, color: Colors.grey),
                    ),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  prod.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                CustomText(
                  'Giá: ${prod.price} ₫',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF888888),
                  ),
                ),
                const SizedBox(height: 4),
                CustomText(
                  'Danh mục: ${prod.category}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF888888),
                  ),
                ),
                if (prod.sizes != null && prod.sizes!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  CustomText(
                    'Size: ${prod.sizes!.join(', ')}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF888888),
                    ),
                  ),
                ],
                if (prod.colors != null && prod.colors!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  CustomText(
                    'Màu: ${prod.colors!.join(', ')}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF888888),
                    ),
                  ),
                ],
                if (prod.quantity > 0) ...[
                  const SizedBox(height: 4),
                  CustomText(
                    'Số lượng: ${prod.quantity}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF888888),
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                        color: AppColor.blue,
                      ),
                      tooltip: 'Sửa',
                      onPressed: () =>
                          _showEditDialog(context, controller, prod),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        size: 20,
                        color: AppColor.error,
                      ),
                      tooltip: 'Xoá',
                      onPressed: () =>
                          _showDeleteDialog(context, controller, prod),
                    ),
                  ],
                ),
              ],
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

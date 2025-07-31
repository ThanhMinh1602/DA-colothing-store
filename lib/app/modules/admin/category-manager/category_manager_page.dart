import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/components/app-bar/admin_app_bar.dart';
import 'package:male_clothing_store/core/components/dialog/custom_dialog.dart';
import 'package:male_clothing_store/core/components/side-bar/custom_sidebar.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/app/modules/admin/category-manager/category_manager_controller.dart';
import 'package:male_clothing_store/app/model/category_model.dart';
import 'package:male_clothing_store/app/modules/admin/category-manager/widgets/category_dialog.dart';

class CategoryManagerPage extends StatelessWidget {
  const CategoryManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryManagerController>();

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AdminAppBar(title: 'Quản lý danh mục'),
      drawer: CustomSidebar(currentTitle: 'Danh mục'),
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
                    'Thêm danh mục',
                    style: AppStyle.buttonPrimary,
                  ),
                ),
                const SizedBox(height: 24),
                Obx(
                  () => controller.categories.isEmpty
                      ? const Center(child: CustomText('Chưa có danh mục nào'))
                      : Column(
                          children: controller.categories.map((cat) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _buildCategoryCard(
                                context,
                                controller,
                                cat,
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
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    CategoryManagerController controller,
    CategoryModel cat,
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
        children: [
          Expanded(
            child: CustomText(
              cat.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, size: 20, color: AppColor.blue),
                tooltip: 'Sửa',
                onPressed: () => _showEditDialog(context, controller, cat),
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 20, color: AppColor.error),
                tooltip: 'Xoá',
                onPressed: () => _showDeleteDialog(context, controller, cat),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddDialog(
    BuildContext context,
    CategoryManagerController controller,
  ) {
    showDialog(
      context: context,
      builder: (_) => CategoryDialog(
        title: "Thêm danh mục mới",
        onSubmit: (name) => controller.addCategory(name),
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    CategoryManagerController controller,
    CategoryModel category,
  ) {
    showDialog(
      context: context,
      builder: (_) => CategoryDialog(
        title: "Sửa danh mục",
        initialName: category.name,
        onSubmit: (name) => controller.updateCategory(category.id, name),
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    CategoryManagerController controller,
    CategoryModel category,
  ) async {
    final confirm = await CustomDialog.showDeleteConfirmDialog(
      context,
      title: "Xoá danh mục",
      message: 'Bạn chắc chắn muốn xoá danh mục "${category.name}"?',
    );
    if (confirm == true) {
      controller.deleteCategory(category.id);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/components/dialog/custom_dialog.dart';
import 'package:male_clothing_store/core/components/side-bar/custom_sidebar.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/components/text-field/custom_text_field.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/core/utils/validate_utils.dart';
import 'package:male_clothing_store/modules/web-admin/category-manager/category_manager_controller.dart';
import 'package:male_clothing_store/app/model/category_model.dart';
import 'package:male_clothing_store/modules/web-admin/category-manager/widgets/category_dialog.dart';
import 'package:male_clothing_store/core/components/dialog/delete_confirm_dialog.dart';

class CategoryManagerPage extends StatelessWidget {
  const CategoryManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryManagerController>();

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Row(
        children: [
          const CustomSidebar(currentTitle: 'Danh mục'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề & nút thêm
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        "Quản lý danh mục",
                        style: AppStyle.loginTitle.copyWith(fontSize: 28),
                      ),
                      Obx(
                        () => ElevatedButton.icon(
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
                          onPressed: controller.isLoading.value
                              ? null
                              : () => _showAddDialog(context, controller),
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: controller.isLoading.value
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const CustomText(
                                  'Thêm danh mục',
                                  style: AppStyle.buttonPrimary,
                                ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  // Table custom
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
                          final categories = controller.categories;
                          if (controller.isLoading.value) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (categories.isEmpty) {
                            return const Center(
                              child: CustomText('Chưa có danh mục nào'),
                            );
                          }
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                // Header table
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
                                          'ID',
                                          style: AppStyle.semiBold14,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: CustomText(
                                          'Tên danh mục',
                                          style: AppStyle.semiBold14,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
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
                                ...categories.map((cat) {
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
                                          child: CustomText(
                                            cat.id,
                                            style: AppStyle.semiBold14,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: CustomText(
                                            cat.name,
                                            style: AppStyle.productCardTitle,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: AppColor.blue,
                                                ),
                                                tooltip: 'Sửa',
                                                onPressed: () =>
                                                    _showEditDialog(
                                                      context,
                                                      controller,
                                                      cat,
                                                    ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: AppColor.error,
                                                ),
                                                tooltip: 'Xoá',
                                                onPressed: () =>
                                                    _showDeleteDialog(
                                                      context,
                                                      controller,
                                                      cat,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
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

  // === DIALOG THÊM DANH MỤC ===
  void _showAddDialog(
    BuildContext context,
    CategoryManagerController controller,
  ) {
    showDialog(
      context: context,
      builder: (_) => CategoryDialog(
        title: "Thêm danh mục mới",
        onSubmit: (name) => controller.addCategory(name),
        isLoading: controller.isLoading.value,
      ),
    );
  }

  // === DIALOG SỬA DANH MỤC ===
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
        isLoading: controller.isLoading.value,
      ),
    );
  }

  // === DIALOG XOÁ DANH MỤC ===
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';
import 'package:male_clothing_store/core/components/app-bar/custom_app_bar.dart';
import 'package:male_clothing_store/core/components/app-bar/custom_small_app_bar.dart';
import 'package:male_clothing_store/core/components/bottom-bar/custom_bottom_bar.dart';
import 'package:male_clothing_store/core/components/button/custom_button.dart';
import 'package:male_clothing_store/core/components/common/product_cart_item.dart';
import 'package:male_clothing_store/core/components/dialog/custom_dialog.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/core/extension/build_context_extension.dart';
import 'cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSmallAppBar(title: 'Giỏ hàng'),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(
            child: CustomText('Giỏ hàng trống', style: AppStyle.semiBold14),
          );
        }
        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          itemCount: controller.cartItems.length,
          separatorBuilder: (_, __) =>
              Divider(height: 24.0, thickness: 1, color: AppColor.grey6),
          itemBuilder: (context, index) {
            final item = controller.cartItems[index];
            return Dismissible(
              key: ValueKey('${item.title}_${item.category}_$index'),
              direction: DismissDirection.endToStart,
              confirmDismiss: (_) => CustomDialog.showConfirmDialog(
                context: context,
                message: 'Bạn có chắc muốn xoá sản phẩm này không?',
              ),
              onDismissed: (_) {
                controller.removeItem(index);
                Get.snackbar(
                  'Đã xoá',
                  '"${item.title}" đã được xoá khỏi giỏ hàng',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red.shade100,
                  colorText: Colors.black,
                  duration: const Duration(seconds: 2),
                );
              },
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white, size: 32),
              ),
              child: ProductCartItem(
                imageUrl: item.imageUrl,
                title: item.title,
                category: item.category,
                price: _formatPrice(item.price),
                quantity: item.quantity,
                onQuantityChanged: (val) {},
                onMenuTap: () {},
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(
        () => CustomBottomBar(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
            decoration: BoxDecoration(
              color: AppColor.backgroundColor,
              border: Border(top: BorderSide(color: AppColor.grey6, width: 1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  // Tổng tiền
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText('Thành tiền', style: AppStyle.regular14),
                        const SizedBox(height: 2),
                        CustomText(
                          _formatPrice(controller.total),
                          style: AppStyle.semiBold14,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Nút Thanh toán
                  Expanded(
                    flex: 3,
                    child: CustomButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.checkout);
                      }, // Xử lý sang màn Checkout
                      btnText: 'Thanh toán',
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

  String _formatPrice(int price) {
    return '${price.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}₫';
  }
}

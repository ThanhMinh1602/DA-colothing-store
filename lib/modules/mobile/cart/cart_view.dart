import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/app/model/bank_card_model.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';
import 'package:male_clothing_store/core/components/app-bar/custom_small_app_bar.dart';
import 'package:male_clothing_store/core/components/bottom-bar/custom_bottom_bar.dart';
import 'package:male_clothing_store/core/components/button/custom_button.dart';
import 'package:male_clothing_store/core/components/common/product_cart_item.dart';
import 'package:male_clothing_store/core/components/dialog/custom_dialog.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          itemCount: controller.cartItems.length,
          separatorBuilder: (_, __) =>
              Divider(height: 24.0, thickness: 1, color: AppColor.grey6),
          itemBuilder: (context, index) {
            final item = controller.cartItems[index];
            return Dismissible(
              key: ValueKey(item.id),
              direction: DismissDirection.endToStart,
              confirmDismiss: (_) => CustomDialog.showConfirmDialog(
                context: context,
                message: 'Bạn có chắc muốn xoá sản phẩm này không?',
              ),
              onDismissed: (_) async {
                await controller.removeItemById(item.id);
              },
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white, size: 32),
              ),
              child: ProductCartItem(
                imageUrl: item.productImage,
                title: item.productName,
                category: item.size,
                price: _formatPrice(item.price.toInt()),
                quantity: item.quantity,
                onQuantityChanged: (val) {
                  controller.updateQuantity(item.id, val);
                },
                onMenuTap: () {},
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(
        () => CustomBottomBar(
          padding: EdgeInsets.all(24.0).copyWith(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                'Thông tin giao hàng',
                style: AppStyle.productCardTitle,
              ),
              const SizedBox(height: 12.0),
              _buildBankCardDropdown(),
              const SizedBox(height: 24.0),
              _buildTextRowSpace(
                leftText: 'Tổng cộng (${controller.totalQuantity} sản phẩm)',
                rightText: _formatPrice(controller.total),
              ),
              const SizedBox(height: 12.0),
              _buildTextRowSpace(
                leftText: 'Phí vận chuyển',
                rightText: 'Miễn phí',
              ),
              const SizedBox(height: 12.0),
              _buildTextRowSpace(leftText: 'Giảm giá', rightText: '0₫'),
              Divider(height: 32.0, color: AppColor.grey6),
              _buildTextRowSpace(
                leftText: 'Thành tiền',
                rightText: _formatPrice(controller.total),
              ),
              _buildUserInfoSection(),
              const SizedBox(height: 44.0),
              _buildCheckoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextRowSpace({
    required String leftText,
    required String rightText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: CustomText(leftText, style: AppStyle.regular14)),
        const SizedBox(width: 12),
        CustomText(rightText, style: AppStyle.semiBold14),
      ],
    );
  }

  Widget _buildBankCardDropdown() {
    return DropdownButtonFormField<BankCardModel>(
      value: bankCards.first,
      items: bankCards.map((bank) {
        return DropdownMenuItem<BankCardModel>(
          value: bank,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  bank.bankIcon,
                  width: 45,
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Text(bank.bankNumber, style: AppStyle.semiBold14),
            ],
          ),
        );
      }).toList(),
      onChanged: (BankCardModel? value) {
        print('Đã chọn bank: ${value?.bankNumber}');
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.grey6,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  Widget _buildUserInfoSection() {
    final user = controller.currentUser.value;

    if (user == null ||
        user.phone == null ||
        user.address == null ||
        user.address!.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () => Get.toNamed(AppRoutes.profileEdit, arguments: user),
            child: CustomText(
              'Thêm thông tin thanh toán →',
              style: AppStyle.semiBold14.copyWith(color: AppColor.blue),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.0),
        CustomText(user.name, style: AppStyle.semiBold14),
        SizedBox(height: 10.0),
        CustomText(user.phone!, style: AppStyle.semiBold14),
        SizedBox(height: 10.0),
        CustomText(user.address!, style: AppStyle.semiBold14),
        SizedBox(height: 10.0),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () => Get.toNamed(AppRoutes.profileEdit, arguments: user),
            child: CustomText(
              'Thay đổi thông tin →',
              style: AppStyle.semiBold14.copyWith(color: AppColor.blue),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return CustomButton(
      onPressed: () async {
        final ok = await CustomDialog.showConfirmDialog(
          context: context,
          message:
              'Bạn có chắc chắn muốn thanh toán tất cả sản phẩm này không?',
        );
        if (ok == true) {
          await controller.checkout();
        }
      },
      btnText: 'Thanh toán',
    );
  }

  String _formatPrice(int price) {
    return '${price.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}₫';
  }
}

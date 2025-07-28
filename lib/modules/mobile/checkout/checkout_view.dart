import 'package:flutter/material.dart';
import 'package:male_clothing_store/app/model/bank_card_model.dart';
import 'package:male_clothing_store/core/components/app-bar/custom_app_bar.dart';
import 'package:male_clothing_store/core/components/app-bar/custom_small_app_bar.dart';
import 'package:male_clothing_store/core/components/bottom-bar/custom_bottom_bar.dart';
import 'package:male_clothing_store/core/components/button/custom_button.dart';
import 'package:male_clothing_store/core/components/common/product_cart_item.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSmallAppBar(),
      body: ListView.separated(
        padding: const EdgeInsets.all(24.0),
        itemCount: 10,
        separatorBuilder: (_, __) =>
            Divider(height: 40.0, color: AppColor.grey6),
        itemBuilder: (context, index) {
          return ProductCartItem(
            imageUrl:
                'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/b510594c-e6a0-4992-85a2-c97f9142f0d5/AS+M+NK+DF+FORM+JKT+GFX.png',
            title: 'Áo khoác thời trang hiện đại',
            category: 'Áo khoác nam',
            price: '1.290.000₫',
            quantity: 2,
            onQuantityChanged: (val) {},
            onMenuTap: () {},
          );
        },
      ),
      bottomNavigationBar: CustomBottomBar(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText('Thông tin giao hàng', style: AppStyle.productCardTitle),
            const SizedBox(height: 12.0),
            DropdownButtonFormField<BankCardModel>(
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
            ),

            const SizedBox(height: 24.0),
            _buildTextRowSpace(
              leftText: 'Tổng cộng (9 sản phẩm)',
              rightText: '10.149.500₫',
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
              rightText: '10.149.500₫',
            ),
            const SizedBox(height: 44.0),
            CustomButton(onPressed: () {}, btnText: 'Thanh toán'),
          ],
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
}

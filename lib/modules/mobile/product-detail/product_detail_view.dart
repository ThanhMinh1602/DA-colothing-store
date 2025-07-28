import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/components/bottom-bar/custom_bottom_bar.dart';
import 'package:male_clothing_store/core/components/button/custom_button.dart';
import 'package:male_clothing_store/core/components/button/custom_outline_circle_button.dart';
import 'package:male_clothing_store/core/components/common/quantity_stepper.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_assets.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/core/extension/build_context_extension.dart';
import 'product_detail_controller.dart';

class ProductDetailView extends StatelessWidget {
  ProductDetailView({super.key});
  final controller = Get.find<ProductDetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: ListView(
        padding: EdgeInsets.all(24.0).copyWith(top: context.paddingTop + 24.0),
        children: [
          _buildImageSection(),
          const SizedBox(height: 24),
          _buildTitleAndRating(),
          const SizedBox(height: 12),
          _buildDescription(),
          Divider(height: 32.0, color: AppColor.grey6),
          _buildOptionRow(),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: CustomButton(
            onPressed: controller.addToCart,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.shoppingCart,
                  color: AppColor.kFDFDFD,
                ),
                const SizedBox(width: 8.0),
                CustomText(
                  'Add to Cart | \$162.99',
                  style: AppStyle.buttonText,
                ),
                const SizedBox(width: 4.0),
                CustomText(
                  '\$190.99',
                  style: AppStyle.bodySmall10.copyWith(
                    color: AppColor.kFDFDFD,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Top image + back & favorite
  Widget _buildImageSection() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.network(
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            width: double.infinity,
            'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco,u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/76daef16-430b-45f7-be38-b6efd69c419c/M+J+BRK+POLO+TOP.png',
          ),
        ),
        Positioned(
          top: 16.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCircleIcon(
                icon: AppAssets.arrowLeft,
                onTap: () => Get.back(),
              ),
              _buildCircleIcon(icon: AppAssets.heart, onTap: () {}),
            ],
          ),
        ),
      ],
    );
  }

  // Title, rating, quantity control
  Widget _buildTitleAndRating() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText('Light Dress Bless', style: AppStyle.headingLarge),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  SvgPicture.asset(AppAssets.star),
                  const SizedBox(width: 8.0),
                  RichText(
                    text: TextSpan(
                      text: '5.0',
                      style: AppStyle.bodySmall12,
                      children: [
                        TextSpan(
                          text: ' (7.932 reviews)',
                          style: AppStyle.bodySmall12.copyWith(
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Obx(
          () => QuantityStepper(
            value: controller.quantity.value,
            onChanged: (val) => controller.quantity.value = val,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return CustomText(
      'Its simple and elegant shape makes it perfect for those of you who like you who want minimalist clothes. Read More...',
    );
  }

  Widget _buildOptionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSizeSelector(),
        const SizedBox(width: 10),
        _buildColorSelector(),
      ],
    );
  }

  Widget _buildSizeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText('Chọn Size', style: AppStyle.bodySmallBold),
        const SizedBox(height: 8.0),
        Obx(
          () => Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(controller.sizes.length, (i) {
              final bool isActive = controller.selectedSize.value == i;
              return GestureDetector(
                onTap: () => controller.selectSize(i),
                child: Container(
                  width: 26,
                  height: 26,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isActive ? AppColor.k292526 : Colors.transparent,
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: const Color(0xFFDFDEDE),
                      width: 1,
                    ),
                  ),
                  child: CustomText(
                    controller.sizes[i],
                    style: AppStyle.bodySmall12.copyWith(
                      color: isActive ? AppColor.kFDFDFD : AppColor.k292526,
                      fontWeight: isActive
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText('Màu', style: AppStyle.bodySmallBold),
        const SizedBox(height: 8.0),
        Obx(
          () => Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(controller.colors.length, (i) {
              final bool isActive = controller.selectedColor.value == i;
              return GestureDetector(
                onTap: () => controller.selectColor(i),
                child: Container(
                  width: 26,
                  height: 26,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: controller.colors[i],
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: isActive
                          ? Colors.blueAccent
                          : const Color(0xFFDFDEDE),
                      width: 2,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  // Nút icon tròn (back/favorite)
  Widget _buildCircleIcon({
    required String icon,
    VoidCallback? onTap,
    bool isActive = false,
    Color? activeColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColor.kFDFDFD,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: const Color(0x1A292526),
              offset: const Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: SvgPicture.asset(
          icon,
          color: isActive ? (activeColor ?? Colors.red) : AppColor.k292526,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/app/model/product_model.dart';
import 'package:male_clothing_store/core/components/bottom-bar/custom_bottom_bar.dart';
import 'package:male_clothing_store/core/components/button/custom_button.dart';
import 'package:male_clothing_store/core/components/common/quantity_stepper.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_assets.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/core/extension/build_context_extension.dart';
import 'package:male_clothing_store/core/extension/string_extension.dart';
import 'product_detail_controller.dart';

class ProductDetailView extends StatelessWidget {
  ProductDetailView({super.key});
  final controller = Get.find<ProductDetailController>();

  @override
  Widget build(BuildContext context) {
    final ProductModel product = Get.arguments as ProductModel;

    return Scaffold(
      backgroundColor: AppColor.white,
      body: ListView(
        padding: EdgeInsets.all(24.0).copyWith(top: context.paddingTop + 24.0),
        children: [
          _buildImageSection(product.imageUrl),
          const SizedBox(height: 24),
          _buildTitleAndRating(product),
          const SizedBox(height: 12),
          _buildDescription(product.description),
          Divider(height: 32.0, color: AppColor.grey6),
          _buildOptionRow(),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: CustomButton(
            onPressed: () => controller.addToCart(product),
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
                  'Add to Cart | ${product.price.toString().formatAsVND()}',
                  style: AppStyle.buttonText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(String? imageUrl) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.network(
            imageUrl ?? "",
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            width: double.infinity,
            height: 300,
            errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.broken_image)),
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
              _buildCircleIcon(
                icon: AppAssets.heart,
                isActive: controller.isFavorite.value,
                onTap: controller.toggleFavorite,
                activeColor: Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTitleAndRating(ProductModel product) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(product.name, style: AppStyle.headingLarge),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  SvgPicture.asset(AppAssets.star),
                  const SizedBox(width: 8.0),
                  RichText(
                    text: TextSpan(
                      text: ("5.0 "),
                      style: AppStyle.bodySmall12,
                      children: [
                        TextSpan(
                          text: '100 reviews)',
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

  Widget _buildDescription(String? description) {
    return CustomText(
      description ??
          'Its simple and elegant shape makes it perfect for those of you who like minimalist clothes.',
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

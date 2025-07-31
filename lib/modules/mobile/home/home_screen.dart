import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/app/model/product_model.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';
import 'package:male_clothing_store/core/components/app-bar/custom_app_bar.dart';
import 'package:male_clothing_store/core/components/text-field/custom_text_field.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_assets.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/core/extension/build_context_extension.dart';
import 'package:male_clothing_store/core/extension/string_extension.dart';
import 'package:male_clothing_store/modules/mobile/home/widgets/product_item.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.unfocus,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Obx(() {
            final user = controller.currentUser.value;
            return CustomAppBar(userModel: user);
          }),
        ),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ).copyWith(top: 14.0),
          children: [
            _buildSearchBar(),
            const SizedBox(height: 32.0),
            Obx(() => _buildCategoryList()),
            Obx(() => _buildProductGrid(controller.products)),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid(List<ProductModel> products) {
    if (products.isEmpty) {
      return const Center(child: CustomText('Không có sản phẩm nào'));
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 24.0, bottom: 120),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 17,
        mainAxisSpacing: 16,
        childAspectRatio: 0.56,
      ),
      itemBuilder: (context, index) {
        final p = products[index];
        return GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.productDetail, arguments: p);
          },
          child: ProductItem(
            imageUrl: p.imageUrl ?? "",
            name: p.name,
            category: p.category,
            price: p.price.toString().formatAsVND(),
            rating: 5.0,
            onFavoriteTap: () {},
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            hintText: 'Tìm kiếm sản phẩm...',
            isSearch: true,
            controller: controller.searchController,
            onChanged: (val) {
              controller.setKeyword(val);
            },
          ),
        ),
        const SizedBox(width: 16.0),
        _buildFilterButton(),
      ],
    );
  }

  Widget _buildFilterButton() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColor.k292526,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SvgPicture.asset(
        AppAssets.setting4,
        color: AppColor.backgroundColor,
      ), // đổi thành Icon nếu không có SVG
    );
  }

  Widget _buildCategoryList() {
    final cats = controller.categories;
    final selCat = controller.selectedCategory.value;
    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: cats.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16.0),
        itemBuilder: (context, index) {
          final cat = cats[index];
          final selected = selCat == cat.name;
          return GestureDetector(
            onTap: () => controller.setCategory(cat.name),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: selected ? AppColor.primary : AppColor.k292526,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: CustomText(
                cat.name,
                style: AppStyle.bodySmall12.copyWith(
                  color: selected ? AppColor.white : AppColor.grey3,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

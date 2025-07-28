import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/app/router/app_routes.dart';
import 'package:male_clothing_store/core/components/app-bar/custom_app_bar.dart';
import 'package:male_clothing_store/core/components/text-field/custom_text_field.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_assets.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/core/extension/build_context_extension.dart';
import 'package:male_clothing_store/modules/mobile/home/widgets/product_item.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final items = List.generate(8, (index) => 'Sản phẩm $index');
    return GestureDetector(
      onTap: context.unfocus,
      child: Scaffold(
        appBar: CustomAppBar(),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            _buildSearchBar(),
            const SizedBox(height: 32.0),
            _buildCategoryList(),
            _buildProductGrid(items),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid(List<String> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 24.0, bottom: 120),
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 17,
        mainAxisSpacing: 16,
        childAspectRatio: 0.56,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.productDetail);
          },
          child: ProductItem(
            imageUrl:
                'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco,u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/76daef16-430b-45f7-be38-b6efd69c419c/M+J+BRK+POLO+TOP.png',
            name: 'Áo Polo Jordan Brooklyn',
            category: 'Áo thun',
            price: '1.290.000₫',
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
          ),
        ),
        const SizedBox(width: 16.0),
        _buildFilterButton(),
      ],
    );
  }

  /// Nút filter với icon svg
  Widget _buildFilterButton() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColor.k292526,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SvgPicture.asset(AppAssets.setting4, color: AppColor.kFDFDFD),
    );
  }

  /// Danh sách category ngang
  Widget _buildCategoryList() {
    final categories = ['Tất cả', 'Áo thun', 'Quần dài'];
    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16.0),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: AppColor.k292526,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: CustomText(
              categories[index],
              style: AppStyle.bodySmall12.copyWith(color: AppColor.white),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:male_clothing_store/core/components/app-bar/custom_small_app_bar.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/core/components/common/product_cart_item.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dữ liệu mẫu: Sản phẩm yêu thích
    final List<Map<String, dynamic>> favItems = [
      {
        'imageUrl':
            'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/b510594c-e6a0-4992-85a2-c97f9142f0d5/AS+M+NK+DF+FORM+JKT+GFX.png',
        'name': 'Áo khoác Nike thời trang',
        'category': 'Áo khoác',
        'price': '1.190.000₫',
      },
      {
        'imageUrl':
            'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco,u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/76daef16-430b-45f7-be38-b6efd69c419c/M+J+BRK+POLO+TOP.png',
        'name': 'Áo Polo Jordan Brooklyn',
        'category': 'Áo thun',
        'price': '1.290.000₫',
      },
    ];

    return Scaffold(
      appBar: CustomSmallAppBar(title: 'Yêu thích'),
      body: favItems.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite_border, size: 54, color: AppColor.grey4),
                  const SizedBox(height: 16),
                  CustomText(
                    'Danh sách yêu thích trống',
                    style: AppStyle.semiBold14,
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    'Hãy thêm sản phẩm bạn yêu thích nhé!',
                    style: AppStyle.regular14.copyWith(color: AppColor.grey4),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(24),
              itemCount: favItems.length,
              separatorBuilder: (_, __) =>
                  Divider(color: AppColor.grey6, height: 28),
              itemBuilder: (context, index) {
                final item = favItems[index];
                return ProductCartItem(
                  imageUrl: item['imageUrl'],
                  title: item['name'],
                  category: item['category'],
                  price: item['price'],
                  isFavourite:
                      true, // Quan trọng: Chuyển sang chế độ "yêu thích"
                  onFavouriteTap: () {
                    // TODO: Xử lý bỏ khỏi yêu thích (xóa khỏi danh sách)
                  },
                  // Không truyền quantity/onQuantityChanged, sẽ không hiển thị stepper
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:male_clothing_store/app/model/order_model.dart';
import 'package:male_clothing_store/core/components/app-bar/custom_small_app_bar.dart';
import 'package:male_clothing_store/core/components/common/product_cart_item.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/core/extension/string_extension.dart';
import 'package:male_clothing_store/app/modules/mobile/order/order_controller.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController controller = Get.find();

    return Scaffold(
      appBar: CustomSmallAppBar(title: 'Đơn hàng'),
      body: Obx(() {
        if (controller.orders.isEmpty) {
          return const Center(
            child: CustomText(
              'Không có đơn hàng nào',
              style: AppStyle.semiBold14,
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.orders.length,
          itemBuilder: (context, index) {
            final order = controller.orders[index];
            return OrderItem(order: order, controller: controller);
          },
        );
      }),
    );
  }
}

class OrderItem extends StatelessWidget {
  final OrderModel order;
  final OrderController controller;

  const OrderItem({super.key, required this.order, required this.controller});

  @override
  Widget build(BuildContext context) {
    String formattedDate = _formatDate(order.createdAt);

    return Card(
      margin: const EdgeInsets.all(8),
      color: AppColor.white,
      child: ExpansionTile(
        title: Text('Order #${order.id}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              'Total: ${order.total.toString().formatAsVND()}',
              style: AppStyle.semiBold14,
            ),
            const SizedBox(height: 4),
            CustomText('Status: ${order.status}', style: AppStyle.regular14),
            const SizedBox(height: 4),
            CustomText('Ngày đặt: $formattedDate', style: AppStyle.regular14),
          ],
        ),
        childrenPadding: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        children: [
          Column(
            spacing: 8.0,
            children: order.items.map((item) {
              return ProductCartItem(
                imageUrl: item.productImage,
                title: item.productName,
                category: item.size,
                price: item.price.toString().formatAsVND(),
                quantity: item.quantity,
                isFavourite: false,
                onMenuTap: () {},
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }
}

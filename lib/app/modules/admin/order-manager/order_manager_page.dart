import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/app/model/order_model.dart';
import 'package:male_clothing_store/app/modules/admin/order-manager/order_manager_controller.dart';
import 'package:male_clothing_store/core/components/app-bar/admin_app_bar.dart';
import 'package:male_clothing_store/core/components/side-bar/custom_sidebar.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';

class OrderManagerPage extends StatelessWidget {
  const OrderManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderManagerController>();
    final formatter = NumberFormat.currency(locale: "vi_VN", symbol: "₫");

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AdminAppBar(title: 'Quản lý đơn hàng'),
      drawer: CustomSidebar(currentTitle: 'Đơn hàng'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => DropdownButtonFormField<String>(
                    value: controller.selectedStatus.value,
                    hint: const CustomText(
                      'Lọc theo trạng thái',
                      style: AppStyle.bodySmall12,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    icon: const Icon(
                      Icons.filter_list,
                      color: AppColor.primary,
                    ),
                    dropdownColor: AppColor.dialogBg,
                    onChanged: (String? newValue) {
                      controller.filterByStatus(newValue);
                    },
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: CustomText(
                          'Tất cả trạng thái',
                          style: AppStyle.bodySmall12,
                        ),
                      ),
                      ...OrderStatus.values.map(
                        (status) => DropdownMenuItem<String>(
                          value: status.value,

                          child: CustomText(
                            status.title,
                            style: AppStyle.caption.copyWith(
                              color: status.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  spacing: 10.0,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final DateTimeRange? picked =
                              await showDateRangePicker(
                                context: context,
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now(),
                                initialEntryMode:
                                    DatePickerEntryMode.calendarOnly,
                                builder: (context, child) {
                                  return Center(
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxWidth: 400,
                                        maxHeight: 500,
                                      ),
                                      child: child,
                                    ),
                                  );
                                },
                              );
                          if (picked != null) {
                            controller.filterByDateRange(picked);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        child: CustomText(
                          'Lọc theo ngày',
                          style: AppStyle.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.clearDateRangeFilter();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        child: CustomText(
                          'Xem tất cả ngày',
                          style: AppStyle.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                Obx(
                  () => controller.filteredOrders.isEmpty
                      ? const Center(child: CustomText('Chưa có đơn hàng nào'))
                      : Column(
                          children: controller.filteredOrders
                              .asMap()
                              .entries
                              .map((entry) {
                                final index = entry.key;
                                final order = entry.value;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _buildOrderCard(
                                    context,
                                    controller,
                                    formatter,
                                    index,
                                    order,
                                  ),
                                );
                              })
                              .toList(),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(
    BuildContext context,
    OrderManagerController controller,
    NumberFormat formatter,
    int index,
    OrderModel order,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomText(
                  '#${order.id}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              DropdownButton<String>(
                value: order.status,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: AppColor.primary,
                  size: 20,
                ),
                dropdownColor: AppColor.dialogBg,
                underline: const SizedBox(),
                onChanged: (String? newValue) async {
                  if (newValue != null) {
                    await controller.updateOrderStatus(
                      order.id,
                      OrderStatus.fromValue(newValue),
                    );
                  }
                },
                items: OrderStatus.values
                    .map(
                      (status) => DropdownMenuItem<String>(
                        value: status.value,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: status.bgColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CustomText(
                            status.title,
                            style: AppStyle.caption.copyWith(
                              color: status.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          CustomText(
            'Ngày đặt: ${DateFormat('dd/MM/yyyy').format(order.createdAt)}',
            style: const TextStyle(fontSize: 12, color: Color(0xFF888888)),
          ),
          const SizedBox(height: 4),
          CustomText(
            'Tên người đặt: ${order.receiverName}',
            style: const TextStyle(fontSize: 12, color: Color(0xFF888888)),
          ),
          const SizedBox(height: 4),
          CustomText(
            'SĐT: ${order.receiverPhone}',
            style: const TextStyle(fontSize: 12, color: Color(0xFF888888)),
          ),
          const SizedBox(height: 4),
          CustomText(
            'Địa chỉ: ${order.shippingAddress}',
            style: const TextStyle(fontSize: 12, color: Color(0xFF888888)),
          ),
          const SizedBox(height: 8),
          CustomText(
            'Thành tiền: ${formatter.format(order.total)}',
            style: const TextStyle(fontSize: 12, color: Color(0xFF888888)),
          ),
          const SizedBox(height: 8),
          CustomText(
            'Sản phẩm:',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 4),
          ...order.items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColor.grey2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        item.productImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.image,
                              size: 24,
                              color: Colors.grey,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          '${item.productName} (${item.size})',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF888888),
                          ),
                        ),
                        CustomText(
                          'x${item.quantity}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF888888),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

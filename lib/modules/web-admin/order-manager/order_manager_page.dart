import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/app/model/order_model.dart';
import 'package:male_clothing_store/modules/web-admin/order-manager/order_manager_controller.dart';
import 'package:male_clothing_store/core/components/side-bar/custom_sidebar.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';

class OrderManagerPage extends StatefulWidget {
  const OrderManagerPage({super.key});

  @override
  State<OrderManagerPage> createState() => _OrderManagerPageState();
}

class _OrderManagerPageState extends State<OrderManagerPage> {
  final OrderManagerController controller = Get.find<OrderManagerController>();
  final formatter = NumberFormat.currency(locale: "vi_VN", symbol: "₫");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Row(
        children: [
          const CustomSidebar(currentTitle: 'Đơn hàng'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "Quản lý đơn hàng",
                    style: AppStyle.loginTitle.copyWith(fontSize: 28),
                  ),
                  const SizedBox(height: 28),

                  Row(
                    children: [
                      Obx(
                        () => DropdownButton<String>(
                          value: controller.selectedStatus.value,
                          hint: const CustomText(
                            'Lọc theo trạng thái',
                            style: AppStyle.bodySmall12,
                          ),
                          isExpanded: false,
                          icon: const Icon(
                            Icons.filter_list,
                            color: AppColor.primary,
                          ),
                          dropdownColor: AppColor.dialogBg,
                          underline: const SizedBox(),
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
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),

                      ElevatedButton(
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
                                    child: SizedBox(
                                      width: 500,
                                      height: 550,
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
                        ),
                        child: CustomText(
                          'Lọc theo ngày',
                          style: AppStyle.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          controller.clearDateRangeFilter();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
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
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Card(
                      color: AppColor.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: SingleChildScrollView(
                          child: Obx(
                            () => Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.grey2,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    spacing: 10,
                                    children: const [
                                      Expanded(
                                        flex: 1,
                                        child: CustomText(
                                          'STT',
                                          style: AppStyle.semiBold14,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: CustomText(
                                          'Mã đơn hàng & Thông tin người nhận',
                                          style: AppStyle.semiBold14,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: CustomText(
                                          'Thành tiền',
                                          style: AppStyle.semiBold14,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: CustomText(
                                          'Sản phẩm',
                                          style: AppStyle.semiBold14,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: CustomText(
                                          'Trạng thái',
                                          style: AppStyle.semiBold14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                  color: AppColor.borderLight,
                                ),
                                ...controller.filteredOrders.asMap().map((
                                  index,
                                  order,
                                ) {
                                  return MapEntry(
                                    index,
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 4,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.kFDFDFD,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        spacing: 10,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: CustomText(
                                              '${index + 1}',
                                              style: AppStyle.semiBold14,
                                            ),
                                          ),

                                          Expanded(
                                            flex: 4,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  '#${order.id}',
                                                  style: AppStyle.semiBold14,
                                                ),
                                                CustomText(
                                                  'Ngày đặt: ${DateFormat('dd/MM/yyyy').format(order.createdAt)}',
                                                  style: AppStyle.bodySmall12,
                                                ),
                                                CustomText(
                                                  'Tên người đặt: ${order.receiverName}',
                                                  style: AppStyle.bodySmall12,
                                                ),
                                                CustomText(
                                                  'SĐT: ${order.receiverPhone}',
                                                  style: AppStyle.bodySmall12,
                                                ),
                                                CustomText(
                                                  'Địa chỉ: ${order.shippingAddress}',
                                                  style: AppStyle.bodySmall12,
                                                ),
                                              ],
                                            ),
                                          ),

                                          Expanded(
                                            flex: 2,
                                            child: CustomText(
                                              formatter.format(order.total),
                                              style: AppStyle.priceBig.copyWith(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),

                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: order.items.map((item) {
                                                return Row(
                                                  children: [
                                                    Image.network(
                                                      item.productImage,
                                                      width: 30,
                                                      height: 30,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    CustomText(
                                                      '${item.productName} (${item.size})',
                                                      style:
                                                          AppStyle.bodySmall12,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    CustomText(
                                                      'x${item.quantity}',
                                                      style:
                                                          AppStyle.bodySmall12,
                                                    ),
                                                  ],
                                                );
                                              }).toList(),
                                            ),
                                          ),

                                          Expanded(
                                            flex: 2,
                                            child: DropdownButton<String>(
                                              value: order.status,
                                              isExpanded: true,
                                              icon: const Icon(
                                                Icons.arrow_drop_down,
                                                color: AppColor.primary,
                                              ),
                                              dropdownColor: AppColor.dialogBg,
                                              underline: const SizedBox(),
                                              onChanged:
                                                  (String? newValue) async {
                                                    if (newValue != null) {
                                                      await controller
                                                          .updateOrderStatus(
                                                            order.id,
                                                            OrderStatus.fromValue(
                                                              newValue,
                                                            ),
                                                          );
                                                    }
                                                  },
                                              items: OrderStatus.values
                                                  .map(
                                                    (
                                                      status,
                                                    ) => DropdownMenuItem<String>(
                                                      value: status.value,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              8,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: status.bgColor,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10,
                                                              ),
                                                        ),
                                                        child: CustomText(
                                                          status.title,
                                                          style: AppStyle
                                                              .caption
                                                              .copyWith(
                                                                color: status
                                                                    .textColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).values,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

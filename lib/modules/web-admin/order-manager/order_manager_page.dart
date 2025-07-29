import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/app/model/order_model.dart';
import 'package:male_clothing_store/modules/web-admin/order-manager/order_manager_controller.dart';
import 'package:male_clothing_store/core/components/side-bar/custom_sidebar.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';

const allStatus = [
  'Chờ xử lý',
  'Đã xác nhận',
  'Đang giao',
  'Đã giao',
  'Đã huỷ',
];

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
                                // Header table
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
                                    children: const [
                                      Expanded(
                                        flex: 2,
                                        child: CustomText(
                                          'Mã đơn',
                                          style: AppStyle.semiBold14,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: CustomText(
                                          'Khách hàng',
                                          style: AppStyle.semiBold14,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: CustomText(
                                          'Tổng tiền',
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
                                      Expanded(
                                        flex: 2,
                                        child: CustomText(
                                          'Ngày đặt',
                                          style: AppStyle.semiBold14,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: CustomText(
                                          'Thao tác',
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
                                ...controller.orders.map((order) {
                                  return Container(
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
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: CustomText(
                                            order.id,
                                            style: AppStyle.semiBold14,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: CustomText(
                                            order.userId ?? '-',
                                            style: AppStyle.productCardTitle,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: CustomText(
                                            formatter.format(order.total),
                                            style: AppStyle.priceBig,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4,
                                              horizontal: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _statusBgColor(
                                                order.status,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: CustomText(
                                              order.status,
                                              style: AppStyle.caption.copyWith(
                                                color: _statusTextColor(
                                                  order.status,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: CustomText(
                                            DateFormat(
                                              'dd/MM/yyyy HH:mm',
                                            ).format(order.createdAt),
                                            style: AppStyle.bodySmall12,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.visibility,
                                                  color: AppColor.primary,
                                                ),
                                                tooltip: 'Xem chi tiết',
                                                onPressed: () =>
                                                    _showDetailDialog(
                                                      context,
                                                      order,
                                                    ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: AppColor.blue,
                                                ),
                                                tooltip: 'Đổi trạng thái',
                                                onPressed: () =>
                                                    _showChangeStatusDialog(
                                                      context,
                                                      order,
                                                    ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: AppColor.error,
                                                ),
                                                tooltip: 'Xoá',
                                                onPressed: () =>
                                                    _showDeleteDialog(
                                                      context,
                                                      order,
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

  // Dialog đổi trạng thái
  void _showChangeStatusDialog(BuildContext context, OrderModel order) {
    String selectedStatus = order.status;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColor.dialogBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const CustomText(
          'Đổi trạng thái đơn hàng',
          style: AppStyle.bottomSheetTitle,
        ),
        content: DropdownButtonFormField<String>(
          value: selectedStatus,
          decoration: InputDecoration(
            labelText: 'Trạng thái',
            labelStyle: AppStyle.labelSmall,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          items: allStatus
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
          onChanged: (value) {
            if (value != null) selectedStatus = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const CustomText('Huỷ', style: AppStyle.hintAction),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              await controller.updateOrderStatus(order.id, selectedStatus);
              Navigator.pop(ctx);
            },
            child: const CustomText('Lưu', style: AppStyle.buttonPrimary),
          ),
        ],
      ),
    );
  }

  // Dialog xác nhận xoá
  void _showDeleteDialog(BuildContext context, OrderModel order) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColor.dialogBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const CustomText(
          'Xoá đơn hàng',
          style: AppStyle.bottomSheetTitle,
        ),
        content: CustomText(
          'Bạn chắc chắn muốn xoá đơn hàng #${order.id} của ${order.userId ?? "-"}?',
          style: AppStyle.dialogMessage,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const CustomText('Huỷ', style: AppStyle.hintAction),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              await controller.deleteOrder(order.id);
              Navigator.pop(ctx);
            },
            child: const CustomText('Xoá', style: AppStyle.buttonPrimary),
          ),
        ],
      ),
    );
  }

  // Dialog xem chi tiết (demo)
  void _showDetailDialog(BuildContext context, OrderModel order) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColor.dialogBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: CustomText(
          'Chi tiết đơn hàng #${order.id}',
          style: AppStyle.bottomSheetTitle,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                'Khách: ${order.userId ?? "-"}',
                style: AppStyle.bodySmall12,
              ),
              CustomText(
                'Tổng tiền: ${formatter.format(order.total)}',
                style: AppStyle.bodySmall12,
              ),
              CustomText(
                'Trạng thái: ${order.status}',
                style: AppStyle.bodySmall12,
              ),
              CustomText(
                'Ngày đặt: ${DateFormat('dd/MM/yyyy HH:mm').format(order.createdAt)}',
                style: AppStyle.bodySmall12,
              ),
              const SizedBox(height: 16),
              const CustomText(
                '(Có thể show thêm sản phẩm trong đơn, địa chỉ giao hàng...)',
                style: AppStyle.caption,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => Navigator.pop(ctx),
            child: const CustomText('Đóng', style: AppStyle.buttonPrimary),
          ),
        ],
      ),
    );
  }

  // Màu trạng thái
  Color _statusBgColor(String status) {
    switch (status) {
      case 'Chờ xử lý':
        return AppColor.lightYellow;
      case 'Đã xác nhận':
        return AppColor.lightBlue;
      case 'Đang giao':
        return AppColor.lightGreen;
      case 'Đã giao':
        return AppColor.lightGreen;
      case 'Đã huỷ':
        return AppColor.saleBg;
      default:
        return AppColor.grey2;
    }
  }

  Color _statusTextColor(String status) {
    switch (status) {
      case 'Chờ xử lý':
        return AppColor.warning;
      case 'Đã xác nhận':
        return AppColor.blue;
      case 'Đang giao':
        return AppColor.green;
      case 'Đã giao':
        return AppColor.success;
      case 'Đã huỷ':
        return AppColor.error;
      default:
        return AppColor.textSecondary;
    }
  }
}

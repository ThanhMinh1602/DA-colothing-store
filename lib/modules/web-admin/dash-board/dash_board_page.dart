import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:male_clothing_store/app/model/product_model.dart';
import 'package:male_clothing_store/core/components/side-bar/custom_sidebar.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';
import 'package:male_clothing_store/modules/web-admin/dash-board/dash_board_controller.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DashBoardController controller = Get.find<DashBoardController>();

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Row(
        children: [
          CustomSidebar(currentTitle: 'Trang chủ'),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        'Dashboard',
                        style: AppStyle.loginTitle.copyWith(fontSize: 32),
                      ),
                      const SizedBox(height: 32),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStatCard(
                              icon: Icons.shopping_bag,
                              label: 'Tổng đơn hàng',
                              value: controller.totalOrders.value.toString(),
                              color: AppColor.primary,
                            ),
                            _buildStatCard(
                              icon: Icons.attach_money,
                              label: 'Doanh thu tháng',
                              value: NumberFormat.currency(
                                locale: 'vi_VN',
                                symbol: '₫',
                              ).format(controller.monthlyRevenue.value),
                              color: AppColor.green,
                            ),
                            _buildStatCard(
                              icon: Icons.people,
                              label: 'Khách hàng mới',
                              value: controller.newCustomers.value.toString(),
                              color: AppColor.blue,
                            ),
                            _buildStatCard(
                              icon: Icons.star,
                              label: 'Đánh giá 5★',
                              value: '${controller.rating.value}%',
                              color: AppColor.yellow,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 2, child: _buildBestSellerSection()),
                          const SizedBox(width: 24),
                          Expanded(flex: 3, child: _buildActivitySection()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColor.shadow,
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.12),
              child: Icon(icon, color: color, size: 28),
              radius: 28,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 4),
                CustomText(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF888888),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBestSellerSection() {
    final DashBoardController controller = Get.find<DashBoardController>();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadow,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            'Sản phẩm bán chạy',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 14),
          Obx(
            () => Column(
              children: controller.bestSellers.map((item) {
                ProductModel product = item['product'] as ProductModel;
                int quantitySold = item['quantitySold'] as int;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: AppColor.grey2,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: product.imageUrl == null
                            ? const Icon(
                                Icons.image,
                                size: 30,
                                color: Colors.grey,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  product.imageUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.image,
                                        size: 30,
                                        color: Colors.grey,
                                      ),
                                ),
                              ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 2),
                            CustomText(
                              'Đã bán: $quantitySold',
                              style: const TextStyle(
                                fontSize: 13,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySection() {
    final DashBoardController controller = Get.find<DashBoardController>();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadow,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            'Hoạt động gần đây',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 14),
          Obx(
            () => Column(
              children: controller.recentActivities.map((order) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColor.primary.withOpacity(0.13),
                        child: Icon(
                          _getActivityIcon(order.status),
                          color: AppColor.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              'Đơn hàng #${order.id} - ${order.status}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            CustomText(
                              _formatTime(order.createdAt),
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
            ),
          ),
        ],
      ),
    );
  }

  IconData _getActivityIcon(String? status) {
    switch (status) {
      case 'completed':
        return Icons.check_circle;
      case 'pending':
        return Icons.add_shopping_cart;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else {
      return '${difference.inDays} ngày trước';
    }
  }
}

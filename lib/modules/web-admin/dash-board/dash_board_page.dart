import 'package:flutter/material.dart';
import 'package:male_clothing_store/core/components/side-bar/custom_sidebar.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      {
        'icon': Icons.shopping_bag,
        'label': 'Tổng đơn hàng',
        'value': '1,248',
        'color': AppColor.primary,
      },
      {
        'icon': Icons.attach_money,
        'label': 'Doanh thu tháng',
        'value': '₫ 98,500,000',
        'color': AppColor.green,
      },
      {
        'icon': Icons.people,
        'label': 'Khách hàng mới',
        'value': '384',
        'color': AppColor.blue,
      },
      {
        'icon': Icons.star,
        'label': 'Đánh giá 5★',
        'value': '92%',
        'color': AppColor.yellow,
      },
    ];

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
                      // Tiêu đề
                      CustomText(
                        'Dashboard',
                        style: AppStyle.loginTitle.copyWith(fontSize: 32),
                      ),
                      const SizedBox(height: 32),
                      // Stats cards (4 cột đẹp đều nhau)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: stats
                            .map(
                              (e) => _buildStatCard(
                                icon: e['icon'] as IconData,
                                label: e['label'] as String,
                                value: e['value'] as String,
                                color: e['color'] as Color,
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 40),
                      // 2 section chia đôi
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Sản phẩm bán chạy
                          Expanded(flex: 2, child: _buildBestSellerSection()),
                          const SizedBox(width: 24),
                          // Hoạt động gần đây
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

  // Card thống kê
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
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
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

  // Section sản phẩm bán chạy
  Widget _buildBestSellerSection() {
    final demoProducts = [
      {
        "name": "Áo thun Basic",
        "sold": "500+",
        "img": null, // Thay ảnh thật nếu có
      },
      {"name": "Sơ mi Linen", "sold": "320+", "img": null},
      {"name": "Quần jeans slim", "sold": "275+", "img": null},
    ];

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
          const Text(
            'Sản phẩm bán chạy',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 14),
          ...demoProducts.map((p) {
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
                    child: p["img"] == null
                        ? const Icon(Icons.image, size: 30, color: Colors.grey)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              p["img"] as String,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p["name"] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Đã bán: ${p['sold']}",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF888888),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // Section hoạt động gần đây
  Widget _buildActivitySection() {
    final demoActivities = [
      {
        "icon": Icons.add_shopping_cart,
        "content": "Khách hàng vừa đặt đơn mới #1241",
        "time": "2 phút trước",
        "color": AppColor.primary,
      },
      {
        "icon": Icons.check_circle,
        "content": "Đơn hàng #1239 đã giao thành công",
        "time": "1 giờ trước",
        "color": AppColor.green,
      },
      {
        "icon": Icons.person_add,
        "content": "Khách hàng mới đăng ký tài khoản",
        "time": "3 giờ trước",
        "color": AppColor.blue,
      },
    ];

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
          const Text(
            'Hoạt động gần đây',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 14),
          ...demoActivities.map((a) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: (a['color'] as Color).withOpacity(0.13),
                    child: Icon(
                      a['icon'] as IconData,
                      color: a['color'] as Color,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          a['content'] as String,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          a['time'] as String,
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

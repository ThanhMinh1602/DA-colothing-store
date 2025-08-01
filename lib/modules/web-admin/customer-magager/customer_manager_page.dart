import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/core/components/text-field/custom_text_field.dart';
import 'package:male_clothing_store/modules/web-admin/customer-magager/customer_manager_controller.dart';
import 'package:male_clothing_store/core/components/side-bar/custom_sidebar.dart';
import 'package:male_clothing_store/core/components/text/custom_text.dart';
import 'package:male_clothing_store/core/constants/app_color.dart';
import 'package:male_clothing_store/core/constants/app_style.dart';

class CustomerManagerPage extends StatefulWidget {
  const CustomerManagerPage({super.key});

  @override
  State<CustomerManagerPage> createState() => _CustomerManagerPageState();
}

class _CustomerManagerPageState extends State<CustomerManagerPage> {
  final CustomerManagerController controller =
      Get.find<CustomerManagerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Row(
        children: [
          const CustomSidebar(currentTitle: 'Khách hàng'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "Quản lý khách hàng",
                    style: AppStyle.loginTitle.copyWith(fontSize: 28),
                  ),
                  const SizedBox(height: 28),
                  IntrinsicWidth(
                    child: CustomTextField(
                      hintText: 'Tìm kiếm theo tên khách hàng',
                      onChanged: (value) {
                        controller.updateSearchQuery(value);
                      },
                    ),
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
                                          'Thông tin khách hàng',
                                          style: AppStyle.semiBold14,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: CustomText(
                                          'SĐT',
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
                                ...controller.filteredCustomers.asMap().map((
                                  index,
                                  customer,
                                ) {
                                  if (customer.role != 'customer') {
                                    return MapEntry(index, const SizedBox());
                                  }
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
                                                  'Tên: ${customer.name}',
                                                  style: AppStyle.semiBold14,
                                                ),
                                                CustomText(
                                                  'Email: ${customer.email}',
                                                  style: AppStyle.bodySmall12,
                                                ),
                                                CustomText(
                                                  'Địa chỉ: ${customer.address}',
                                                  style: AppStyle.bodySmall12,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: CustomText(
                                              customer.phone ??
                                                  'Chưa có số điện thoại',
                                              style: AppStyle.bodySmall12,
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

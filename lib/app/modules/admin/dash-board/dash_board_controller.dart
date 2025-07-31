import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:male_clothing_store/app/model/order_model.dart';
import 'package:male_clothing_store/app/model/product_model.dart';
import 'package:male_clothing_store/app/model/user_model.dart';
import 'package:male_clothing_store/app/services/category_service.dart';
import 'package:male_clothing_store/app/services/order_service.dart';
import 'package:male_clothing_store/app/services/product_service.dart';
import 'package:male_clothing_store/app/services/user_service.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';

class DashBoardController extends BaseController {
  final OrderService _orderService = OrderService();
  final ProductService _productService = ProductService();
  final UserService _userService = UserService();
  final CategoryService _categoryService = CategoryService();

  // Dữ liệu cho các thẻ thống kê
  final RxInt totalOrders = 0.obs;
  final RxDouble monthlyRevenue = 0.0.obs;
  final RxInt newCustomers = 0.obs;
  final RxDouble rating = 0.0.obs;

  // Dữ liệu cho danh sách sản phẩm bán chạy
  final RxList<Map<String, dynamic>> bestSellers = <Map<String, dynamic>>[].obs;

  // Dữ liệu cho hoạt động gần đây
  final RxList<OrderModel> recentActivities = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchDashboardData();
  }

  Future<void> _fetchDashboardData() async {
    // Lấy tổng số đơn hàng và hoạt động gần đây
    _orderService.getAllOrders().listen((orders) {
      totalOrders.value = orders.length;

      // Tính doanh thu tháng
      final now = DateTime.now();
      monthlyRevenue.value = orders
          .where(
            (order) =>
                order.createdAt != null &&
                order.createdAt.year == now.year &&
                order.createdAt.month == now.month,
          )
          .fold(0.0, (sum, order) => sum + (order.total ?? 0));

      // Lấy các đơn hàng gần đây
      recentActivities.value = orders.take(3).toList();

      // Tính sản phẩm bán chạy
      _calculateBestSellers(orders);
    });

    // Lấy khách hàng mới
    _userService.getUsers().listen((users) {
      final now = DateTime.now();
      newCustomers.value = users
          .where(
            (user) =>
                user.createdAt != null &&
                user.createdAt!.year == now.year &&
                user.createdAt!.month == now.month,
          )
          .length;
    });

    // Giả lập đánh giá 5 sao
    rating.value = 92.0;
  }

  void _calculateBestSellers(List<OrderModel> orders) async {
    // Đếm số lượng bán của mỗi sản phẩm
    Map<String, int> productSales = {};
    for (var order in orders) {
      for (var item in order.items) {
        productSales[item.productId] =
            (productSales[item.productId] ?? 0) + item.quantity;
      }
    }

    // Lấy thông tin sản phẩm từ Firestore
    List<Map<String, dynamic>> bestSellersList = [];
    for (var entry in productSales.entries) {
      DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(entry.key)
          .get();
      if (productSnapshot.exists) {
        ProductModel product = ProductModel.fromJson(
          productSnapshot.data() as Map<String, dynamic>,
          entry.key,
        );
        bestSellersList.add({'product': product, 'quantitySold': entry.value});
      }
    }

    // Sắp xếp theo số lượng bán giảm dần và lấy top 3
    bestSellersList.sort(
      (a, b) => b['quantitySold'].compareTo(a['quantitySold']),
    );
    bestSellers.value = bestSellersList.take(3).toList();
  }
}

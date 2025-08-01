import 'package:get/get.dart';
import 'package:male_clothing_store/app/model/user_model.dart';
import 'package:male_clothing_store/app/services/user_service.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';

class CustomerManagerController extends BaseController {
  final UserService _userService = UserService();

  var allCustomers = <UserModel>[];

  var filteredCustomers = <UserModel>[].obs;

  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();

    fetchCustomers();
  }

  void fetchCustomers() async {
    try {
      var customers = await _userService.getUsers().first;
      allCustomers = customers;
      filterCustomers();
    } catch (e) {
      print('Error fetching customers: $e');
    }
  }

  void filterCustomers() {
    var filtered = allCustomers;

    if (searchQuery.value.isNotEmpty) {
      filtered = filtered
          .where(
            (customer) => customer.name.toLowerCase().contains(
              searchQuery.value.toLowerCase(),
            ),
          )
          .toList();
    }

    filteredCustomers.value = filtered;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterCustomers();
  }
}

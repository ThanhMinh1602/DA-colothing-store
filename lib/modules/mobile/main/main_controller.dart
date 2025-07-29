import 'package:get/get.dart';
import 'package:male_clothing_store/core/base/base_controller.dart';

class MainController extends BaseController {
  final RxInt tabIndex = 0.obs;

  void changeTab(int index) {
    tabIndex.value = index;
  }
}

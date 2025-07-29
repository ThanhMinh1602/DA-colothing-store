import 'package:get/get.dart';
import 'package:male_clothing_store/modules/web-admin/dash-board/dash_board_controller.dart';

class DashBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashBoardController());
  }
}

import 'package:get/get.dart';
import 'package:male_clothing_store/modules/mobile/product-detail/product_detail_controller.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailController>(() => ProductDetailController());
  }
}

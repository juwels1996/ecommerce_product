
import 'package:get/get.dart';
import '../controller/order_controller.dart';
import '../controller/product_controller.dart';

class ProductControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController(), fenix: true);
  }
}


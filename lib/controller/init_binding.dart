import 'package:arv/shared/availability_controller.dart';
import 'package:arv/shared/cart_service.dart';
import 'package:get/get.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainScreenController());
    Get.lazyPut(() => CartService());
  }
}

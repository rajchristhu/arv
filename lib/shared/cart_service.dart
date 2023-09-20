import 'package:arv/models/response_models/cart_items.dart';
import 'package:arv/models/response_models/cart_value.dart';
import 'package:arv/models/response_models/my_orders.dart';
import 'package:arv/utils/arv_api.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

// ignore: library_private_types_in_public_api

class CartService extends GetxController {
  CartItems items = CartItems(products: [], length: 0);
  CartTotal cartTotal = CartTotal(orderValue: 0);
  MyOrders myOrders =
      MyOrders(list: [], currentPage: 0, totalCount: 0, totalPages: 0);

  @override
  void onInit() {
    super.onInit();
    updateList();
  }

  updateMyOrdersList() async {
    myOrders = await arvApi.getAllOrders();
    update();
  }

  updateList() async {
    items = await arvApi.getCartItemsAndCounts();
    cartTotal = await arvApi.getCartValue();
    updateMyOrdersList();
    update();
  }

}

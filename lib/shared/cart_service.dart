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
  List<String> productIds = [];

  @override
  void onInit() {
    super.onInit();
    init();
  }

  init() async {
    updateList();
    await Future.delayed(const Duration(minutes: 1));
    init();
  }

  updateMyOrdersList() async {
    myOrders = await arvApi.getAllOrders();
    update();
  }

  updateList() async {
    items = await arvApi.getCartItemsAndCounts();
    cartTotal = await arvApi.getCartValue();
    productIds = items.products.map((e) => e.id).toList();
    updateMyOrdersList();
    update();
  }

  int isPresentInCart(String productId) {
    bool isContains = productIds.contains(productId);
    int cartCount = 0;
    if (isContains) {
      cartCount = items.products
          .where((element) => element.id == productId)
          .first
          .count;
    }

    return cartCount;
  }
}
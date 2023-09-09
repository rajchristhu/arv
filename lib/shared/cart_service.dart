import 'dart:developer';

import 'package:arv/models/response_models/cart_items.dart';
import 'package:arv/utils/arv_api.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

// ignore: library_private_types_in_public_api

class CartService extends GetxController {
  CartItems items = CartItems(products: [], length: 0);

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

  updateList() async {
    items = await arvApi.getCartItemsAndCounts();
    update();
  }

  int isPresentInCart(String productId) {
    bool isContains =
        items.products.where((element) => element.id == productId).isNotEmpty;
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

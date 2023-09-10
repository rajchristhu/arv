import 'package:arv/models/response_models/my_orders.dart';
import 'package:arv/shared/cart_service.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class MyOrderList extends StatelessWidget {
  const MyOrderList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartService>(
      init: Get.find<CartService>(),
      builder: (controller) {
        MyOrders myOrders = controller.myOrders;
        if (myOrders.list.isEmpty) {
          return const Center(
            child: Text("No orders to show"),
          );
        }

        return ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: myOrders.list.length,
          itemBuilder: (BuildContext context, int index) {
            OrderDetails order = myOrders.list[index];

            DeliveryAddress address = order.deliveryAddress;
            String addressLine1 =
                "${address.addressLine1}, ${address.addressLine2}";
            String addressLine2 =
                "${address.pinCode} - ${address.area}, ${address.nation}";
            return Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.id,
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "",
                                      style: TextStyle(
                                        color: black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "₹ ${order.totalAmount + 35.0}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  addressLine1,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  addressLine2,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  height: 1.6,
                                  color: gray50,
                                  padding: const EdgeInsets.only(
                                    right: 6,
                                    left: 6,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

import 'package:arv/models/response_models/my_orders.dart';
import 'package:arv/shared/cart_service.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:order_tracker_zen/order_tracker_zen.dart';

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
              return  Column(
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
                                      "₹ ${ 35.0}",
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
                                Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Add padding around the OrderTrackerZen widget for better presentation.
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                        // OrderTrackerZen is the main widget of the package which displays the order tracking information.
                                        child: OrderTrackerZen(
                                          success_color: pink,

                                          // Provide an array of TrackerData objects to display the order tracking information.
                                          tracker_data: [
                                            // TrackerData represents a single step in the order tracking process.
                                            TrackerData(
                                              title: "Order Placed",
                                              date: "Sat, 8 Apr '22",
                                              // Provide an array of TrackerDetails objects to display more details about this step.
                                              tracker_details: [
                                                // TrackerDetails contains detailed information about a specific event in the order tracking process.
                                                TrackerDetails(
                                                  title: "Your order was placed ",
                                                  datetime: "Sat, 8 Apr '22 - 17:17",
                                                ),
                                                TrackerDetails(
                                                  title: "Arv accept your order",
                                                  datetime: "Sat, 8 Apr '22 - 17:42",
                                                ),
                                              ],
                                            ),
                                            // yet another TrackerData object
                                            TrackerData(
                                              title: "Order On the way",
                                              date: "Sat, 8 Apr '22",


                                              tracker_details: [
                                                TrackerDetails(
                                                  title: "Your delivery partner on the way with you order",
                                                  datetime: "Sat, 8 Apr '22 - 17:50",
                                                ),
                                              ],
                                            ),
                                            // And yet another TrackerData object
                                            TrackerData(
                                              title: "Order Delivered",
                                              date: "Sat,8 Apr '22",
                                              tracker_details: [
                                                TrackerDetails(
                                                  title: "You received your order, by MailDeli",
                                                  datetime: "Sat, 8 Apr '22 - 17:51",
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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

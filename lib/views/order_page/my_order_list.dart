import 'package:arv/models/response_models/my_orders.dart';
import 'package:arv/shared/cart_service.dart';
import 'package:arv/shared/utils.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:order_tracker_zen/order_tracker_zen.dart';

class MyOrderList extends StatefulWidget {
  const MyOrderList({
    super.key,
  });

  @override
  State<MyOrderList> createState() => _MyOrderListState();
}

class _MyOrderListState extends State<MyOrderList> {
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
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: myOrders.list.length,
          itemBuilder: (BuildContext context, int index) {
            OrderDetails order = myOrders.list[index];
            return OrderProgress(order);
          },
        );
      },
    );
  }
}

class OrderProgress extends StatefulWidget {
  const OrderProgress(this.order, {super.key});

  final OrderDetails order;

  @override
  State<StatefulWidget> createState() => _OrderProgressState();
}

class _OrderProgressState extends State<OrderProgress> {
  late OrderDetails order;
  bool isExpanded = false;

  List<String> orderStatusList = [
    'WAITING',
    'ORDER_PLACED',
    'OUT_FOR_DELIVERY',
    'DELIVERED',
    'CANCELLED',
  ];

  @override
  void initState() {
    super.initState();
    order = widget.order;
  }

  @override
  Widget build(BuildContext context) {
    DeliveryAddress address = order.deliveryAddress;
    String addressLine1 = "${address.addressLine1}, ${address.addressLine2}";
    String addressLine2 =
        "${address.pinCode} - ${address.area}, ${address.nation}";
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child: InkWell(
            onTap: () {
              isExpanded = !isExpanded;
              setState(() {});
            },
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "",
                              style: TextStyle(
                                color: black,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "₹ ${order.finalPrice}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
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
                        order.orderStatus ==
                            orderStatusList[2]?   Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 30),
                                      child: OrderTrackerZen(
                                        success_color: pink,
                                        background_color: gray,
                                        tracker_data: [
                                          TrackerData(
                                            title: "Order Placed",
                                            date: utils.getDateString(
                                                order.orderedDate),
                                            tracker_details: [
                                              TrackerDetails(
                                                title: "Your order was placed ",
                                                datetime: utils.getDateString(
                                                    order.orderedDate),
                                              ),
                                              order.orderStatus ==
                                                      orderStatusList[1]
                                                  ? TrackerDetails(
                                                      title:
                                                          "ARV accepts your order",
                                                      datetime:
                                                          utils.getDateString(
                                                              order.placedDate),
                                                    )
                                                  : TrackerDetails(
                                                      title: "",
                                                      datetime: '',
                                                    ),
                                            ],
                                          ),
                                          // yet another TrackerData object
                                          order.orderStatus ==
                                                  orderStatusList[2]
                                              ? TrackerData(
                                                  title: "Order On the way",
                                                  date: utils.getDateString(order
                                                      .expectedDeliveryDate),
                                                  tracker_details: [
                                                    TrackerDetails(
                                                      title:
                                                          "Your delivery partner on the way with you order",
                                                      datetime: utils
                                                          .getDateString(order
                                                              .expectedDeliveryDate),
                                                    ),
                                                  ],
                                                )
                                              : TrackerData(
                                                  title: '',
                                                  date: '',
                                                  tracker_details: [],
                                                ),
                                          // yet another TrackerData object

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ):order.orderStatus ==
                            orderStatusList[3]?Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 30),
                                child: OrderTrackerZen(
                                  success_color: pink,
                                  background_color: gray,
                                  tracker_data: [
                                    TrackerData(
                                      title: "Order Placed",
                                      date: utils.getDateString(
                                          order.orderedDate),
                                      tracker_details: [
                                        TrackerDetails(
                                          title: "Your order was placed ",
                                          datetime: utils.getDateString(
                                              order.orderedDate),
                                        ),
                                        order.orderStatus ==
                                            orderStatusList[1]
                                            ? TrackerDetails(
                                          title:
                                          "ARV accepts your order",
                                          datetime:
                                          utils.getDateString(
                                              order.placedDate),
                                        )
                                            : TrackerDetails(
                                          title: "",
                                          datetime: '',
                                        ),
                                      ],
                                    ),
                                    // yet another TrackerData object
                                    order.orderStatus ==
                                        orderStatusList[2]
                                        ? TrackerData(
                                      title: "Order On the way",
                                      date: utils.getDateString(order
                                          .expectedDeliveryDate),
                                      tracker_details: [
                                        TrackerDetails(
                                          title:
                                          "Your delivery partner on the way with you order",
                                          datetime: utils
                                              .getDateString(order
                                              .expectedDeliveryDate),
                                        ),
                                      ],
                                    )
                                        : TrackerData(
                                      title: '',
                                      date: '',
                                      tracker_details: [],
                                    ),
                                    // yet another TrackerData object
                                    order.orderStatus ==
                                        orderStatusList[3]
                                        ? TrackerData(
                                      title: "Order Delivered",
                                      date: utils.getDateString(
                                          order.deliveredDate),
                                      tracker_details: [
                                        TrackerDetails(
                                          title:
                                          "You received your order",
                                          datetime: utils
                                              .getDateString(order
                                              .expectedDeliveryDate),
                                        ),
                                      ],
                                    )
                                        : TrackerData(
                                      title: '',
                                      date: '',
                                      tracker_details: [],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ):Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 30),
                                child: OrderTrackerZen(
                                  success_color: pink,
                                  background_color: gray,
                                  tracker_data: [
                                    TrackerData(
                                      title: "Order Placed",
                                      date: utils.getDateString(
                                          order.orderedDate),
                                      tracker_details: [
                                        TrackerDetails(
                                          title: "Your order was placed ",
                                          datetime: utils.getDateString(
                                              order.orderedDate),
                                        ),
                                        order.orderStatus ==
                                            orderStatusList[1]
                                            ? TrackerDetails(
                                          title:
                                          "ARV accepts your order",
                                          datetime:
                                          utils.getDateString(
                                              order.placedDate),
                                        )
                                            : TrackerDetails(
                                          title: "",
                                          datetime: '',
                                        ),
                                      ],
                                    ),
                                    TrackerData(
                                      title: '',
                                      date: '',
                                      tracker_details: [],
                                    )
                                    // yet another TrackerData object

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ) ,
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
  }
}

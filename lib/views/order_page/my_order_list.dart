import 'package:arv/models/response_models/my_orders.dart';
import 'package:arv/shared/cart_service.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:order_tracker_zen/order_tracker_zen.dart';
import 'package:cached_network_image/src/cached_image_widget.dart';

class MyOrderList extends StatefulWidget {
  const MyOrderList({
    super.key,
  });

  @override
  State<MyOrderList> createState() => _MyOrderListState();
}

late MyOrders myOrders;

class _MyOrderListState extends State<MyOrderList> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartService>(
      init: Get.find<CartService>(),
      builder: (controller) {
        myOrders = controller.myOrders;
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
            return OrderProgress(order, index);
          },
        );
      },
    );
  }
}

class OrderProgress extends StatefulWidget {
  const OrderProgress(this.order, this.ind, {super.key});

  final OrderDetails order;
  final int ind;

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
                        const SizedBox(height: 10),
                        Text(
                          "Order ${widget.ind+1}",
                          style: TextStyle(
                              color: black,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),

                        SizedBox(
                          height: order.orderItems.length * 40,
                          child: ListView.builder(
                            itemCount: order.orderItems.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [

                                        Container(
                                        height: 40,
                                          width: 10,

                                        ),

                                        const SizedBox(width: 15),
                                        SizedBox(
                                          width:
                                          MediaQuery.of(context).size.width * 0.6,
                                          child: Text(
                                            "${order.orderItems[index].itemName}",
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          " ( ${order.orderItems[index].qty} x ${order.orderItems[index].itemPrice} )",
                                        ),
                                      ],
                                    )
                                  ],
                                );
                            },
                          ),
                        ),
                        const SizedBox(height: 3),
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
                              style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800
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
                              fontSize: 14,
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          addressLine2 +"\n"+"payment mode:  "+(order.couponCode=="1"?"Online":"COD"),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: black,

                              fontSize: 14,
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 12),
                        order.orderStatus == orderStatusList[2]
                            ? Center(
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
                                            date: '',
                                            tracker_details: [
                                              TrackerDetails(
                                                title: "Your order was placed ",
                                                datetime: '',
                                              ),
                                              order.orderStatus ==
                                                      orderStatusList[1]
                                                  ? TrackerDetails(
                                                      title:
                                                          "ARV accepts your order",
                                                      datetime:
                                                          '${order.placedDate}',
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
                                                  date:
                                                      '${order.expectedDeliveryDate}',
                                                  tracker_details: [
                                                    TrackerDetails(
                                                      title:
                                                          "Your delivery partner on the way with you order",
                                                      datetime:
                                                          "${order.expectedDeliveryDate}",
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
                              )
                            : order.orderStatus == orderStatusList[3]
                                ?
                             Center(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
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
                                      date: '',
                                      tracker_details: [
                                        TrackerDetails(
                                          title:
                                          "Your order was placed ",
                                          datetime: '',
                                        ),
                                        order.orderStatus ==
                                            orderStatusList[1]
                                            ? TrackerDetails(
                                          title:
                                          "ARV accepts your order",
                                          datetime:
                                          order.placedDate,
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
                                      date: order
                                          .expectedDeliveryDate,
                                      tracker_details: [
                                        TrackerDetails(
                                          title:
                                          "Your delivery partner on the way with you order",
                                          datetime: order
                                              .expectedDeliveryDate,
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
                                      title: 'Order Delivery',
                                      date: '',
                                      tracker_details: [],
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
                        )
                            : Center(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 30),
                                child: OrderTrackerZen(
                                  success_color: pink,
                                  background_color: gray,
                                  tracker_data: [
                                    TrackerData(
                                      title: "Order Placed",
                                      date: '',
                                      tracker_details: [
                                        TrackerDetails(
                                          title:
                                          "Your order was placed ",
                                          datetime:'',
                                        ),
                                        order.orderStatus ==
                                            orderStatusList[1]
                                            ? TrackerDetails(
                                          title:
                                          "ARV accepts your order",
                                          datetime:
                                          'order.placedDate',
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
                        ),
                        Container(
                          height: 1.6,
                          color: gray50,
                          padding: const EdgeInsets.only(
                            right: 6,
                            left: 6,
                          ),
                        ),
                        myOrders.list.length - 1 == widget.ind
                            ? const SizedBox(
                                height: 200,
                              )
                            : Container()
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

import 'dart:convert';

class Order {
  List<OrderItem> orderItems;
  String paymentMode;
  String addressId;
  String accessToken;
  DateTime? orderedDate;

  Order({
    required this.orderItems,
    required this.paymentMode,
    required this.addressId,
    required this.accessToken,
    this.orderedDate,
  });

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromJson(x))),
        paymentMode: json["paymentMode"],
        addressId: json["addressId"],
        accessToken: json["accessToken"],
        orderedDate: DateTime.parse(json["orderedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "paymentMode": paymentMode,
        "addressId": addressId,
        "accessToken": accessToken,
      };
}

class OrderItem {
  String productId;
  String variant;
  int qty;

  OrderItem({
    required this.productId,
    required this.variant,
    required this.qty,
  });

  factory OrderItem.fromRawJson(String str) =>
      OrderItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        productId: json["productId"],
        variant: json["variant"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "variant": variant,
        "qty": qty,
      };
}

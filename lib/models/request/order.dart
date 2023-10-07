import 'dart:convert';

class Order {
  List<OrderItem> orderItems;
  String paymentMode;
  String addressId;
  String accessToken;
  DateTime? orderedDate;
  double deliveryCharge;
  double discountedPrice;
  double deliveryBoyTip;
  double couponDiscountPercentage;
  String couponCode;
  String returnStatus;
  String cancellationReason;
  String cancellationStatus;
  bool isReturnOrder;
  bool isCancelledOrder;

  Order({
    required this.orderItems,
    required this.paymentMode,
    required this.addressId,
    required this.accessToken,
    this.orderedDate,
    this.deliveryCharge = 0,
    this.discountedPrice = 0,
    this.deliveryBoyTip = 0,
    this.couponDiscountPercentage = 0,
    this.returnStatus = "NOT_APPLICABLE",
    this.cancellationStatus = "NOT_CANCELLED",
    this.couponCode = "",
    this.cancellationReason = "",
    this.isReturnOrder = false,
    this.isCancelledOrder = false,
  });

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromJson(x))),
        paymentMode: json["paymentMode"],
        addressId: json["addressId"],
        accessToken: json["accessToken"],
        deliveryCharge: json["deliveryCharge"],
        discountedPrice: json["discountedPrice"],
        returnStatus: json["returnStatus"],
        deliveryBoyTip: json["deliveryBoyTip"],
        couponDiscountPercentage: json["couponDiscountPercentage"],
        couponCode: json["couponCode"],
        isReturnOrder: json["isReturnOrder"],
        isCancelledOrder: json["isCancelledOrder"],
        cancellationReason: json["cancellationReason"],
        cancellationStatus: json["cancellationStatus"],
        orderedDate: DateTime.parse(
          json["orderedDate"],
        ),
      );

  Map<String, dynamic> toJson() =>
      {
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "paymentMode": paymentMode,
        "addressId": addressId,
        "accessToken": accessToken,
        "deliveryCharge": deliveryCharge,
        "discountedPrice": discountedPrice,
        "returnStatus": returnStatus,
        "deliveryBoyTip": deliveryBoyTip,
        "couponDiscountPercentage": couponDiscountPercentage,
        "couponCode": couponCode,
        "isReturnOrder": isReturnOrder,
        "isCancelledOrder": isCancelledOrder,
        "cancellationReason": cancellationReason,
        "cancellationStatus": cancellationStatus,
      };
}

class OrderItem {
  String productId;
  String variant;
  String? itemName;
  int qty;
  double? itemPrice;
  double itemTotalPrice;

  OrderItem({
    required this.productId,
    this.itemName = "",
    required this.variant,
    required this.qty,
    this.itemPrice = 0.0,
    required this.itemTotalPrice,
  });

  factory OrderItem.fromRawJson(String str) =>
      OrderItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        productId: json["productId"],
        itemName: json["itemName"],
        variant: json["variant"],
        qty: json["qty"],
        itemPrice: json["itemPrice"],
        itemTotalPrice: json["itemTotalPrice"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "itemName": itemName,
        "variant": variant,
        "qty": qty,
        "itemPrice": itemPrice,
        "itemTotalPrice": itemTotalPrice,
      };
}

import 'dart:convert';

class MyOrders {
  List<OrderDetails> list;
  int currentPage;
  int totalCount;
  int totalPages;

  MyOrders({
    required this.list,
    required this.currentPage,
    required this.totalCount,
    required this.totalPages,
  });

  factory MyOrders.fromRawJson(String str) =>
      MyOrders.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyOrders.fromJson(Map<String, dynamic> json) => MyOrders(
        list: List<OrderDetails>.from(
            json["list"].map((x) => OrderDetails.fromJson(x))),
        currentPage: json["currentPage"],
        totalCount: json["totalCount"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "currentPage": currentPage,
        "totalCount": totalCount,
        "totalPages": totalPages,
      };
}

class OrderDetails {
  String id;
  dynamic paymentId;
  String userId;
  List<OrderItem> orderItems;
  dynamic paymentStatus;
  String orderStatus;
  dynamic returnStatus;
  dynamic cancellationStatus;
  String paymentMode;
  dynamic cancellationReason;
  bool isCancelledOrder;
  bool isReturnOrder;
  dynamic orderedDate;
  dynamic placedDate;
  dynamic expectedDeliveryDate;
  dynamic deliveredDate;
  dynamic orderValue;
  dynamic deliveryCharge;
  dynamic taxPercentage;
  dynamic totalAmount;
  DeliveryAddress deliveryAddress;
  dynamic couponCode;
  dynamic discountedPrice;
  dynamic couponDiscountPercentage;
  dynamic finalPrice;

  OrderDetails({
    required this.id,
    required this.paymentId,
    required this.userId,
    required this.orderItems,
    required this.paymentStatus,
    required this.orderStatus,
    required this.returnStatus,
    required this.cancellationStatus,
    required this.paymentMode,
    required this.cancellationReason,
    required this.isCancelledOrder,
    required this.isReturnOrder,
    required this.orderedDate,
    required this.placedDate,
    required this.expectedDeliveryDate,
    required this.deliveredDate,
    required this.orderValue,
    required this.deliveryCharge,
    required this.taxPercentage,
    required this.totalAmount,
    required this.deliveryAddress,
    required this.couponCode,
    required this.discountedPrice,
    required this.couponDiscountPercentage,
    required this.finalPrice,
  });

  factory OrderDetails.fromRawJson(String str) =>
      OrderDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        id: json["id"],
        paymentId: json["paymentId"],
        userId: json["userId"],
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromJson(x))),
        paymentStatus: json["paymentStatus"],
        orderStatus: json["orderStatus"],
        returnStatus: json["returnStatus"],
        cancellationStatus: json["cancellationStatus"],
        paymentMode: json["paymentMode"],
        cancellationReason: json["cancellationReason"],
        isCancelledOrder: json["isCancelledOrder"],
        isReturnOrder: json["isReturnOrder"],
        orderedDate: json["orderedDate"],
        placedDate: json["placedDate"],
        expectedDeliveryDate: json["expectedDeliveryDate"],
        deliveredDate: json["deliveredDate"],
        orderValue: json["orderValue"],
        deliveryCharge: json["deliveryCharge"],
        taxPercentage: json["taxPercentage"],
        totalAmount: json["totalAmount"],
        deliveryAddress: DeliveryAddress.fromJson(json["deliveryAddress"]),
        couponCode: json["couponCode"],
        discountedPrice: json["discountedPrice"],
        couponDiscountPercentage: json["couponDiscountPercentage"],
        finalPrice: json["finalPrice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "paymentId": paymentId,
        "userId": userId,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "paymentStatus": paymentStatus,
        "orderStatus": orderStatus,
        "returnStatus": returnStatus,
        "cancellationStatus": cancellationStatus,
        "paymentMode": paymentMode,
        "cancellationReason": cancellationReason,
        "isCancelledOrder": isCancelledOrder,
        "isReturnOrder": isReturnOrder,
        "orderedDate": orderedDate,
        "placedDate": placedDate,
        "expectedDeliveryDate": expectedDeliveryDate,
        "deliveredDate": deliveredDate,
        "orderValue": orderValue,
        "deliveryCharge": deliveryCharge,
        "taxPercentage": taxPercentage,
        "totalAmount": totalAmount,
        "deliveryAddress": deliveryAddress.toJson(),
        "couponCode": couponCode,
        "discountedPrice": discountedPrice,
        "couponDiscountPercentage": couponDiscountPercentage,
        "finalPrice": finalPrice,
      };
}

class DeliveryAddress {
  String id;
  String name;
  String phone;
  String addressLine1;
  String addressLine2;
  String area;
  String pinCode;
  String state;
  String nation;
  String landMark;
  bool isDeliveryAddress;

  DeliveryAddress({
    required this.id,
    required this.name,
    required this.phone,
    required this.addressLine1,
    required this.addressLine2,
    required this.area,
    required this.pinCode,
    required this.state,
    required this.nation,
    required this.landMark,
    required this.isDeliveryAddress,
  });

  factory DeliveryAddress.fromRawJson(String str) =>
      DeliveryAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) =>
      DeliveryAddress(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        area: json["area"],
        pinCode: json["pinCode"],
        state: json["state"],
        nation: json["nation"],
        landMark: json["landMark"],
        isDeliveryAddress: json["isDeliveryAddress"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "area": area,
        "pinCode": pinCode,
        "state": state,
        "nation": nation,
        "landMark": landMark,
        "isDeliveryAddress": isDeliveryAddress,
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
        variant: json["variant"] ?? "",
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "variant": variant,
        "qty": qty,
      };
}

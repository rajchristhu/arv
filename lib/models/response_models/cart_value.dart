import 'dart:convert';

class CartTotal {
  double orderValue;

  CartTotal({
    required this.orderValue,
  });

  factory CartTotal.fromRawJson(String str) =>
      CartTotal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartTotal.fromJson(Map<String, dynamic> json) => CartTotal(
        orderValue: json["orderValue"],
      );

  Map<String, dynamic> toJson() => {
        "orderValue": orderValue,
      };
}

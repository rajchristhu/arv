import 'dart:convert';

class Cart {
  String productId;
  String variant;
  int qty;

  Cart({
    required this.productId,
    required this.variant,
    required this.qty,
  });

  factory Cart.fromRawJson(String str) => Cart.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
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

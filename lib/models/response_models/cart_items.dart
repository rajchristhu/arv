import 'dart:convert';

class CartItems {
  List<CartItem> products;
  int length;

  CartItems({
    required this.products,
    required this.length,
  });

  factory CartItems.fromRawJson(String str) =>
      CartItems.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartItems.fromJson(Map<String, dynamic> json) => CartItems(
        products: List<CartItem>.from(
            json["products"].map((x) => CartItem.fromJson(x))),
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "length": length,
      };
}

class CartItem {
  String id;
  int count;

  CartItem({
    required this.id,
    required this.count,
  });

  factory CartItem.fromRawJson(String str) =>
      CartItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "count": count,
      };
}

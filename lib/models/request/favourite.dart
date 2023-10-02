import 'dart:convert';

class Favourite {
    String productId;

    Favourite({
        required this.productId,
    });

    factory Favourite.fromRawJson(String str) => Favourite.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Favourite.fromJson(Map<String, dynamic> json) => Favourite(
        productId: json["productId"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
    };
}

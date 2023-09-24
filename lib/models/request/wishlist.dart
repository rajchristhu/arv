import 'package:meta/meta.dart';
import 'dart:convert';

class WishList {
    String productId;

    WishList({
        required this.productId,
    });

    factory WishList.fromRawJson(String str) => WishList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WishList.fromJson(Map<String, dynamic> json) => WishList(
        productId: json["productId"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
    };
}

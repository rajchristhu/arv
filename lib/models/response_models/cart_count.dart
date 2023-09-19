import 'dart:convert';

class CartCount {
    int count;

    CartCount({
        required this.count,
    });

    factory CartCount.fromRawJson(String str) => CartCount.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CartCount.fromJson(Map<String, dynamic> json) => CartCount(
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
    };
}

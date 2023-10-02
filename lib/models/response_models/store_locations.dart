import 'dart:convert';

class StoreLocation {
  List<Store> stores;
  int currentPage;
  int totalCount;
  int totalPages;

  StoreLocation({
    required this.stores,
    required this.currentPage,
    required this.totalCount,
    required this.totalPages,
  });

  factory StoreLocation.fromRawJson(String str) =>
      StoreLocation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreLocation.fromJson(Map<String, dynamic> json) => StoreLocation(
        stores: List<Store>.from(json["stores"].map((x) => Store.fromJson(x))),
        currentPage: json["currentPage"],
        totalCount: json["totalCount"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "stores": List<dynamic>.from(stores.map((x) => x.toJson())),
        "currentPage": currentPage,
        "totalCount": totalCount,
        "totalPages": totalPages,
      };
}

class Store {
  String id;
  String name;
  String latitude;
  String longitude;
  String locationLink;
  double minDeliveryPrice;
  String tags;

  Store({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.locationLink,
    required this.minDeliveryPrice,
    required this.tags,
  });

  factory Store.fromRawJson(String str) => Store.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        locationLink: json["locationLink"],
        minDeliveryPrice: json["minDeliveryPrice"],
        tags: json["tags"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "locationLink": locationLink,
        "minDeliveryPrice": minDeliveryPrice,
        "tags": tags,
      };
}

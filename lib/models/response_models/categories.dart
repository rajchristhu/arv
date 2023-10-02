import 'dart:convert';

class Categories {
  List<Category> list;
  int currentPage;
  int totalCount;
  int totalPages;

  Categories({
    required this.list,
    required this.currentPage,
    required this.totalCount,
    required this.totalPages,
  });

  factory Categories.fromRawJson(String str) =>
      Categories.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        list: List<Category>.from(
            json["categoryList"].map((x) => Category.fromJson(x))),
        currentPage: json["currentPage"],
        totalCount: json["totalCount"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "categoryList": List<dynamic>.from(list.map((x) => x.toJson())),
        "currentPage": currentPage,
        "totalCount": totalCount,
        "totalPages": totalPages,
      };
}

class Category {
  String id;
  String name;
  String majorCategory;
  dynamic image;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.majorCategory,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
        name: json["name"],
        image: json["image"],
        majorCategory: json["majorCategory"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "majorCategory": majorCategory,
        "image": image,
      };
}

import 'dart:convert';

class SubCategories {
    List<SubCategory> list;
    int currentPage;
    int totalCount;
    int totalPages;

    SubCategories({
        required this.list,
        required this.currentPage,
        required this.totalCount,
        required this.totalPages,
    });

    factory SubCategories.fromRawJson(String str) => SubCategories.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SubCategories.fromJson(Map<String, dynamic> json) => SubCategories(
        list: List<SubCategory>.from(json["subCategoryList"].map((x) => SubCategory.fromJson(x))),
        currentPage: json["currentPage"],
        totalCount: json["totalCount"],
        totalPages: json["totalPages"],
    );

    Map<String, dynamic> toJson() => {
        "subCategoryList": List<dynamic>.from(list.map((x) => x.toJson())),
        "currentPage": currentPage,
        "totalCount": totalCount,
        "totalPages": totalPages,
    };
}

class SubCategory {
    String id;
  String categoryId;
  String name;
  String majorCategory;
  dynamic image;

  SubCategory({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.majorCategory,
    required this.image,
  });

  factory SubCategory.fromRawJson(String str) =>
      SubCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        categoryId: json["categoryId"],
        name: json["name"],
        majorCategory: json["majorCategory"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId,
        "majorCategory": majorCategory,
        "name": name,
        "image": image,
      };
}

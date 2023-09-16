import 'dart:convert';

class HomeBanners {
  List<HomeBanner> list;
  int currentPage;
  int totalCount;
  int totalPages;

  HomeBanners({
    required this.list,
    required this.currentPage,
    required this.totalCount,
    required this.totalPages,
  });

  factory HomeBanners.fromRawJson(String str) =>
      HomeBanners.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeBanners.fromJson(Map<String, dynamic> json) => HomeBanners(
        list: List<HomeBanner>.from(
            json["list"].map((x) => HomeBanner.fromJson(x))),
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

class HomeBanner {
  String id;
  double percentage;
  String name;
  String imageUri;
  String? majorCategory;
  String? categoryId;
  String? subCategoryId;
  String homeBannerSection;

  HomeBanner({
    required this.id,
    required this.percentage,
    required this.name,
    required this.imageUri,
    required this.homeBannerSection,
    this.majorCategory,
    this.categoryId,
    this.subCategoryId,
  });

  factory HomeBanner.fromRawJson(String str) =>
      HomeBanner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeBanner.fromJson(Map<String, dynamic> json) => HomeBanner(
    id: json["id"],
        percentage: json["percentage"],
        name: json["name"],
        imageUri: json["imageUri"],
        homeBannerSection: json["homeBannerSection"],
        majorCategory: json["majorCategory"],
        categoryId: json["categoryId"],
        subCategoryId: json["subCategoryId"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "percentage": percentage,
        "name": name,
        "imageUri": imageUri,
        "homeBannerSection": homeBannerSection,
        "majorCategory": majorCategory,
        "categoryId": categoryId,
        "subCategoryId": subCategoryId,
      };
}

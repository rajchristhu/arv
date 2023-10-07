import 'dart:convert';

import 'package:arv/models/response_models/products.dart';

class CartList {
  List<Product> list;
  int currentPage;
  int totalCount;
  int totalPages;

  CartList({
    required this.list,
    required this.currentPage,
    required this.totalCount,
    required this.totalPages,
  });

  factory CartList.fromRawJson(String str) =>
      CartList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartList.fromJson(Map<String, dynamic> json) => CartList(
        list: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        currentPage: json["currentPage"],
        totalCount: json["totalCount"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(list.map((x) => x.toJson())),
        "currentPage": currentPage,
        "totalCount": totalCount,
        "totalPages": totalPages,
      };
}

class Product {
  String? id;
  String? storeId;
  String? majorCategoryId;
  String productName;
  String? description;
  String? scannerId;
  String? brand;
  String? categoryId;
  String? subCategoryId;
  ProductCategory? productCategory;
  String? subCategoryTags;
  ProductSubCategory productSubCategory;
  List<String>? productVariation;
  List<double>? mrpPrice;
  List<double>? sellingPrice;
  List<int>? quantity;
  List<int>? stock;
  double? discount;
  String? tags;
  String? imageUri;
  int? orderQty;
  String? orderProductVariation;
  double? orderPrice;

  Product({
    required this.id,
    required this.storeId,
    required this.majorCategoryId,
    required this.productName,
    required this.description,
    required this.scannerId,
    required this.brand,
    required this.categoryId,
    required this.subCategoryId,
    required this.productCategory,
    required this.subCategoryTags,
    required this.productSubCategory,
    required this.productVariation,
    required this.mrpPrice,
    required this.sellingPrice,
    required this.quantity,
    required this.stock,
    required this.discount,
    required this.tags,
    required this.imageUri,
    required this.orderQty,
    required this.orderProductVariation,
    this.orderPrice = 0.0,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        storeId: json["storeId"],
        majorCategoryId: json["majorCategoryId"],
        productName: json["productName"],
        description: json["description"],
        scannerId: json["scannerId"],
        brand: json["brand"],
        categoryId: json["categoryId"],
        subCategoryId: json["subCategoryId"],
        productCategory: ProductCategory.fromJson(json["productCategory"]),
        subCategoryTags: json["subCategoryTags"],
        productSubCategory:
            ProductSubCategory.fromJson(json["productSubCategory"]),
        productVariation:
            List<String>.from(json["productVariation"].map((x) => x)),
        mrpPrice: json["mrpPrice"] == null
            ? []
            : List<double>.from(json["mrpPrice"].map((x) => x)),
        sellingPrice: json["sellingPrice"] == null
            ? []
            : List<double>.from(json["sellingPrice"].map((x) => x)),
        quantity: json["quantity"] == null
            ? []
            : List<int>.from(json["quantity"].map((x) => x)),
        stock: json["stock"] == null
            ? []
            : List<int>.from(json["stock"].map((x) => x)),
        discount: json["discount"],
        tags: json["tags"],
        imageUri: json["imageUri"],
        orderQty: json["orderQty"],
        orderProductVariation: json["orderProductVariation"],
        orderPrice: json["orderPrice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "storeId": storeId,
        "majorCategoryId": majorCategoryId,
        "productName": productName,
        "description": description,
        "scannerId": scannerId,
        "brand": brand,
        "categoryId": categoryId,
        "subCategoryId": subCategoryId,
        "productCategory": productCategory?.toJson(),
        "subCategoryTags": subCategoryTags,
        "productSubCategory": productSubCategory.toJson(),
        "productVariation": productVariation == null
            ? []
            : List<double>.from(productVariation!.map((x) => x)),
        "mrpPrice":
            mrpPrice == null ? [] : List<double>.from(mrpPrice!.map((x) => x)),
        "sellingPrice": sellingPrice == null
            ? []
            : List<dynamic>.from(sellingPrice!.map((x) => x)),
        "quantity":
            quantity == null ? [] : List<dynamic>.from(quantity!.map((x) => x)),
        "stock": stock == null ? [] : List<dynamic>.from(stock!.map((x) => x)),
        "discount": discount,
        "tags": tags,
        "imageUri": imageUri,
        "orderQty": orderQty,
        "orderProductVariation": orderProductVariation,
        "orderPrice": orderPrice,
      };
}

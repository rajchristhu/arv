import 'dart:convert';

class Products {
  List<ProductDto> list;
  int currentPage;
  int totalCount;
  int totalPages;

  Products({
    required this.list,
    required this.currentPage,
    required this.totalCount,
    required this.totalPages,
  });

  factory Products.fromRawJson(String str) =>
      Products.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        list: List<ProductDto>.from(
            json["products"].map((x) => ProductDto.fromJson(x))),
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

class ProductDto {
  String id;
  String? storeId;
  String? majorCategoryId;
  String? productName;
  String? description;
  String? scannerId;
  String? brand;
  String? categoryId;
  String? subCategoryId;
  ProductCategory? productCategory;
  String? subCategoryTags;
  ProductSubCategory productSubCategory;
  List<String>? productVariation;
  List<ProductVariant> productVariants;
  List<double>? mrpPrice;
  List<double>? sellingPrice;
  List<int>? quantity;
  List<int>? stock;
  double? discount;
  String? tags;
  String? imageUri;
  bool isEnabled;
  List<double> vdiscount;

  ProductDto({
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
    required this.productVariants,
    required this.mrpPrice,
    required this.sellingPrice,
    required this.quantity,
    required this.stock,
    required this.discount,
    required this.tags,
    required this.imageUri,
    required this.isEnabled,
    required this.vdiscount,
  });

  factory ProductDto.fromRawJson(String str) =>
      ProductDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
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
      productVariation: json["productVariation"] == null
          ? []
          : List<String>.from(json["productVariation"].map((x) => x)),
      mrpPrice: List<double>.from(json["mrpPrice"].map((x) => x)),
      sellingPrice: List<double>.from(json["sellingPrice"].map((x) => x)),
      quantity: json["quantity"] == null
          ? []
          : List<int>.from(json["quantity"].map((x) => x)),
      stock: List<int>.from(json["stock"].map((x) => x)),
      productVariants: json["productVariants"] == null
          ? []
          : List<ProductVariant>.from(
              json["productVariants"].map((x) => ProductVariant.fromJson(x))),
      discount: json["discount"]?.toDouble(),
      tags: json["tags"],
      imageUri: json["imageUri"],
      isEnabled: json["isEnabled"],
      vdiscount: json["vdiscount"] == null
          ? []
          : List<double>.from(json["vdiscount"].map((x) => x)),
    );
  }

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
        "productVariation": productVariation,
        "mrpPrice":
            mrpPrice != null ? List<double>.from(mrpPrice!.map((x) => x)) : [],
        "sellingPrice": sellingPrice != null
            ? List<double>.from(sellingPrice!.map((x) => x))
            : [],
        "quantity":
            quantity != null ? List<int>.from(quantity!.map((x) => x)) : [],
        "stock": stock != null ? List<int>.from(stock!.map((x) => x)) : [],
        "discount": discount,
        "tags": tags,
        "imageUri": imageUri,
        "isEnabled": isEnabled,
        "vdiscount": vdiscount,
      };
}

class ProductCategory {
  String id;
  String name;
  dynamic image;

  ProductCategory({
    required this.id,
    required this.name,
    required this.image,
  });

  factory ProductCategory.fromRawJson(String str) =>
      ProductCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}

class ProductSubCategory {
  String id;
  String categoryId;
  String name;

  ProductSubCategory({
    required this.id,
    required this.categoryId,
    required this.name,
  });

  factory ProductSubCategory.fromRawJson(String str) =>
      ProductSubCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductSubCategory.fromJson(Map<String, dynamic> json) =>
      ProductSubCategory(
        id: json["id"],
        categoryId: json["categoryId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId,
        "name": name,
      };
}

class ProductVariant {
  String productVariant;
  dynamic color;
  dynamic size;
  String unit;
  double price;
  int qty;

  ProductVariant({
    required this.productVariant,
    required this.color,
    required this.size,
    required this.unit,
    required this.price,
    required this.qty,
  });

  factory ProductVariant.fromRawJson(String str) =>
      ProductVariant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
        productVariant: json["productVariant"],
        color: json["color"],
        size: json["size"],
        unit: json["unit"],
        price: json["price"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "productVariant": productVariant,
        "color": color,
        "size": size,
        "unit": unit,
        "price": price,
        "qty": qty,
      };
}

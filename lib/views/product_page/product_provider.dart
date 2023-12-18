import 'dart:convert';
import 'dart:developer';

import 'package:arv/models/response_models/products.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../shared/app_const.dart';

class NewsProvider with ChangeNotifier {
  Products? newsResponse;
  String? majorCategory;
  String? categoryId;
  String? subCategoryId;

  Products get getNewsArticles => newsResponse!;

  final String hostUrl = "http://34.93.69.101:8090";

  void setParams(
    String? majorCategory,
    String? categoryId,
    String? subCategoryId,
  ) {
    log("Param Set");
    this.majorCategory = majorCategory;
    this.categoryId = categoryId;
    this.subCategoryId = subCategoryId;
  }

  Future<Products> fetchNews(int pageNo) async {
    var client = http.Client();
    try {
      String location = AppConstantsUtils.location;

      var response = await client.get(Uri.parse(
        "$hostUrl/public/products?majorCategoryId=${majorCategory ?? 'Groceries'}${categoryId != null ? "&categoryId=$categoryId" : ""}${subCategoryId != null ? "&subCategoryId=$subCategoryId" : ""}&priceFrom=0&priceTo=0&page=$pageNo&storeId=$location",
      ));
      log('$hostUrl/public/products?majorCategoryId=${majorCategory ?? 'Groceries'}${categoryId != null ? "&categoryId=$categoryId" : ""}${subCategoryId != null ? "&subCategoryId=$subCategoryId" : ""}&priceFrom=0&priceTo=0&page=$pageNo&storeId=$location');

      if (response.statusCode == 200) {
        newsResponse = Products.fromJson(jsonDecode(response.body));
        notifyListeners();
        return getNewsArticles;
      } else {}
    } catch (e) {
      return Products(
        list: [],
        currentPage: 0,
        totalCount: 0,
        totalPages: 0,
      );
    } finally {
      client.close();
    }
    notifyListeners();
    return Products(
      list: [],
      currentPage: 0,
      totalCount: 0,
      totalPages: 0,
    );
  }
}

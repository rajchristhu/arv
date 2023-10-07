import 'dart:convert';

import 'package:arv/models/response_models/products.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../utils/secure_storage.dart';

class NewsProvider with ChangeNotifier {
  Products? newsResponse;

  Products get getNewsArticles => newsResponse!;

  var API_KEY = "";
  final String hostUrl = "http://34.93.69.101:8090";

  Future<Products> fetchNews(int pageNo,
      String? majorCategory,
      String? categoryId,
      String? subCategoryId,) async {
    print("PageNo : $pageNo");
    var client = http.Client();
print('afsfsfsaf');
var test="";
    try {
      String location = await secureStorage.get("location");

      var response = await client.get(Uri.parse(
        "$hostUrl/public/products?majorCategoryId=${majorCategory ?? 'Groceries'}${categoryId != null ? "&categoryId=$categoryId" : ""}${subCategoryId != null ? "&subCategoryId=$subCategoryId" : ""}&priceFrom=0&priceTo=0&page=$pageNo&storeId=$location",
      ));
      print("object");
      print(('$hostUrl/public/products?majorCategoryId=${majorCategory ?? 'Groceries'}${categoryId != null ? "&categoryId=$categoryId" : ""}&priceFrom=0&priceTo=0&page=$pageNo&storeId=$location'));

      if (response.statusCode == 200) {
        newsResponse = Products.fromJson(jsonDecode(response.body));
        notifyListeners();
        return getNewsArticles;
      } else {}
    } catch (e) {
      print("e");
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

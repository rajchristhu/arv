// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';

import 'package:arv/models/response_models/access_token.dart';
import 'package:arv/models/response_models/categories.dart';
import 'package:arv/models/response_models/home_banner.dart';
import 'package:arv/models/response_models/products.dart';
import 'package:arv/utils/secure_storage.dart';
import 'package:http/http.dart' as http;

_ArvApi arvApi = _ArvApi.instance;

class _ArvApi {
  _ArvApi._();

  static final _ArvApi instance = _ArvApi._();

  final String hostUrl = "http://35.244.31.172:8090";

  // Image Uri : /public/products/image

  String getMediaUri(String mediaId) {
    return "$hostUrl/public/products/image/$mediaId";
  }

  login() async {
    String username, password;
    String? token = await secureStorage.get("access-token");
    if (token != null) return;
    var url = Uri.parse("$hostUrl/auth/login");

    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({"phone": "9385875094", "uid": "12345"}),
    );

    AccessToken accessToken = AccessToken.fromRawJson(response.body);
    await secureStorage.add("access-token", accessToken.token);
  }

  Future<HomeBanners> getAllHomeBanners() async {
    var url = Uri.parse("$hostUrl/api/homeBanners?page=0");

    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
    };

    var response = await http.get(url, headers: headers);
    HomeBanners homeBanners;
    if (response.statusCode == 200) {
      homeBanners = HomeBanners.fromRawJson(response.body);
    } else {
      homeBanners =
          HomeBanners(currentPage: 0, list: [], totalCount: 0, totalPages: 0);
    }
    return homeBanners;
  }

  Future<Categories> getAllCategories() async {
    var url = Uri.parse("$hostUrl/productCategories?pageNumber=0");

    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
    };

    var response = await http.get(url, headers: headers);
    Categories categories;
    log(response.body);
    if (response.statusCode == 200) {
      categories = Categories.fromRawJson(response.body);
    } else {
      categories =
          Categories(currentPage: 0, list: [], totalCount: 0, totalPages: 0);
    }
    return categories;
  }

  Future<Products> getAllProducts(int pageNumber) async {
    var url =
        Uri.parse("$hostUrl/public/products?priceFrom=0&priceTo=0&page=$pageNumber");

    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
    };

    var response = await http.get(url, headers: headers);
    Products products =
        Products(currentPage: 0, list: [], totalCount: 0, totalPages: 0);
    if (response.statusCode == 200) {
      try {
        products = Products.fromRawJson(response.body);
      } catch (e) {
        log("Exception : $e");
      }
    }
    log('product list = ${products.list.length}');
    return products;
  }
}

// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';

import 'package:arv/models/request/cart.dart';
import 'package:arv/models/request/user.dart';
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
  static const int cacheDurationInDays = 7;

  final String hostUrl = "http://35.244.33.213:8090";

  // Image Uri : /public/products/image

  String getMediaUri(String mediaId) {
    return "$hostUrl/public/products/image/$mediaId";
  }

  Future<bool> _isValidCacheData(String cacheKey) async {
    final cachedTimestamp = await secureStorage.get(cacheKey);

    if (cachedTimestamp.isNotEmpty) {
      final currentTime = DateTime.now();
      final cachedTime = DateTime.parse(cachedTimestamp);
      return currentTime.difference(cachedTime).inDays <= cacheDurationInDays;
    }
    return false;
  }

  Future<bool> get validateLogin async {
    String token = await secureStorage.get("access-token");
    return await _isValidCacheData("loginTime") && token != "";
  }

  Future<String> login(String username, String uid) async {
    var url = Uri.parse("$hostUrl/auth/login");
    if (await validateLogin) return await secureStorage.get("access-token");

    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
    };
    try {
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({"phone": "9385875094", "uid": "12345"}),
      );

      AccessToken accessToken = AccessToken.fromRawJson(response.body);
      await secureStorage.add("access-token", accessToken.token);
      await secureStorage.add('loginTime', DateTime.now().toIso8601String());
      return accessToken.token;
    } catch (e) {
      log("Login Exception : $e");
    }

    return "";
  }

  Future<String> register(ArvUser user) async {
    var url = Uri.parse("$hostUrl/auth/register");

    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
    };
    try {
      var response = await http.post(
        url,
        headers: headers,
        body: user.toRawJson(),
      );

      if (response.statusCode == 201) {
        return await login(user.phone, user.uid);
      }
    } catch (e) {
      log("Exception : $e");
    }
    return "";
  }

  Future<HomeBanners> getAllHomeBanners(String section) async {
    var url =
        Uri.parse("$hostUrl/api/homeBanners?page=0&homeBannerSection=$section");

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
        Uri.parse("$hostUrl/public/products?majorCategoryId=Groceries&priceFrom=0&priceTo=0&page=$pageNumber");

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
    return products;
  }

  Future<void> addToCart(Cart cart) async {
    var url = Uri.parse("$hostUrl/cart");

    var headers = await _getHeaders();

    var response = await http.post(
      url,
      headers: headers,
      body: cart.toRawJson(),
    );

    if (response.statusCode == 200) {
      //
    }
  }

  Future<void> getCartItems(int pageNumber) async {
    var url = Uri.parse("$hostUrl/cart");

    var headers = await _getHeaders();

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      //
    }
  }

  Future<void> deleteCartItem(String productId) async {
    var url = Uri.parse("$hostUrl/cart?id=$productId");

    var headers = await _getHeaders();

    var response = await http.delete(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      //
    }
  }

  Future<void> deleteAllCartItems() async {
    var url = Uri.parse("$hostUrl/cart/deleteAll");

    var headers = await _getHeaders();

    var response = await http.delete(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      //
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    log("Access token : ${await secureStorage.get('access-token')}");
    return {
      "content-type": "application/json",
      "Authorization": "Bearer ${await secureStorage.get('access-token')}"
    };
  }
}

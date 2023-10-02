// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';

import 'package:arv/models/request/cart.dart';
import 'package:arv/models/request/favourite.dart';
import 'package:arv/models/request/order.dart';
import 'package:arv/models/request/user.dart';
import 'package:arv/models/response_models/access_token.dart';
import 'package:arv/models/response_models/addresses.dart';
import 'package:arv/models/response_models/cart_count.dart';
import 'package:arv/models/response_models/cart_items.dart';
import 'package:arv/models/response_models/cart_list.dart';
import 'package:arv/models/response_models/cart_value.dart';
import 'package:arv/models/response_models/categories.dart';
import 'package:arv/models/response_models/home_banner.dart';
import 'package:arv/models/response_models/my_orders.dart';
import 'package:arv/models/response_models/products.dart';
import 'package:arv/models/response_models/profile.dart';
import 'package:arv/models/response_models/store_locations.dart';
import 'package:arv/models/response_models/sub_categories.dart';
import 'package:arv/utils/secure_storage.dart';
import 'package:http/http.dart' as http;

_ArvApi arvApi = _ArvApi.instance;

class _ArvApi {
  _ArvApi._();

  static final _ArvApi instance = _ArvApi._();
  static const int cacheDurationInDays = 7;

  final String hostUrl = "http://34.93.69.101:8090";

  // Image Uri : /public/products/image

  String getMediaUri(String? mediaId) {
    if (mediaId == null) return "";
    return "$hostUrl/public/products/image/${Uri.encodeComponent(mediaId)}";
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

  Future<void> clearUser() async {
    await secureStorage.delete("location");
    await secureStorage.delete("loginTime");
    await secureStorage.delete("access-token");
    await secureStorage.delete("username");
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
        body: jsonEncode({"phone": username, "uid": uid}),
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

  Future<Profile> getProfile() async {
    var url = Uri.parse("$hostUrl/auth/myProfile");
    String phone = await secureStorage.get("username");
    Profile profile = Profile(
      id: "",
      phone: "+91 $phone",
      email: "",
      profileName: "",
      profileImage: null,
    );

    try {
      var response = await http.get(
        url,
        headers: await _getHeaders(),
      );

      profile = Profile.fromRawJson(response.body);
    } catch (e) {
      log("Profile get Exception : $e");
    }
    return profile;
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
      log("Register Exception : $e");
    }
    return "";
  }

  Future<void> updateProfile(String name) async {
    Profile profile = await getProfile();
    profile.profileName = name;

    var url = Uri.parse("$hostUrl/auth");
    try {
      http.Response response = await http.put(
        url,
        headers: await _getHeaders(),
        body: profile.toRawJson(),
      );
      log("Update Response ${response.body}");
    } catch (e) {
      log("Profile Update Exception : $e");
    }
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
    Categories categories =
        Categories(currentPage: 0, list: [], totalCount: 0, totalPages: 0);
    ;
    var url = Uri.parse("$hostUrl/productCategories?pageNumber=0");

    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
    };

    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      categories = Categories.fromRawJson(response.body);
    }
    return categories;
  }

  Future<Categories> getAllCategoriesList() async {
    Categories categories =
        Categories(currentPage: 0, list: [], totalCount: 0, totalPages: 0);
    ;
    var url = Uri.parse("$hostUrl/productCategories/all");

    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
    };

    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      categories = Categories.fromRawJson(response.body);
    }
    return categories;
  }

  Future<SubCategories> getAllSubCategoriesById(String categoryId) async {
    SubCategories categories =
        SubCategories(currentPage: 0, list: [], totalCount: 0, totalPages: 0);
    ;
    var url =
        Uri.parse("$hostUrl/productSubCategories/all?categoryId=$categoryId");

    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
    };

    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      categories = SubCategories.fromRawJson(response.body);
    }
    return categories;
  }

  Future<Products> getAllProducts(
    int pageNumber,
    String? majorCategory,
    String? categoryId,
    String? subCategoryId,
  ) async {
    String location = await secureStorage.get("location");
    var url = Uri.parse(
      "$hostUrl/public/products?majorCategoryId=${majorCategory ?? 'Groceries'}${categoryId != null ? "&categoryId=$categoryId" : ""}${subCategoryId != null ? "&subCategoryId=$subCategoryId" : ""}&priceFrom=0&priceTo=0&page=$pageNumber&storeId=$location",
    );

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

  Future<Products> getRecentViews(bool isRecentViews) async {
    var url = Uri.parse(
        "$hostUrl/features/recent?isRecentViews=$isRecentViews"
    );

    var response = await http.get(url, headers: await _getHeaders(),);
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

  Future<void> addFavourite(String productId) async {
    var url = Uri.parse(
        "$hostUrl/wishlist"
    );

    Favourite favourite = Favourite(productId: productId);

    await http.post(
      url, headers: await _getHeaders(), body: favourite.toRawJson(),);
  }

  Future<void> checkFavourite(String productId) async {
    var url = Uri.parse(
        "$hostUrl/wishlist/$productId"
    );

    Favourite favourite = Favourite(productId: productId);

    await http.post(
      url, headers: await _getHeaders(), body: favourite.toRawJson(),);
  }

  Future<ProductDto?> getProductById(String? productId) async {
    var url = Uri.parse(
      "$hostUrl/products/$productId",
    );

    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
    };

    var response = await http.get(url, headers: headers);
    ProductDto? product;
    if (response.statusCode == 200) {
      try {
        product = ProductDto.fromRawJson(response.body);
      } catch (e) {
        log("Exception : $e");
      }
    }
    return product;
  }

  Future<Products> getAllProductsByCategory(
    String category,
    String subCategory,
    int pageNumber,
  ) async {
    var url = Uri.parse(
        "$hostUrl/public/products?majorCategoryId=Groceries&categoryId=$category&subCategoryId=$subCategory&priceFrom=0&priceTo=0&page=$pageNumber");

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
    log("Cart Response : ${response.statusCode}");
    if (response.statusCode == 200) {
      log("Add to cart : ${response.body}");
    }
  }

  Future<CartList> getCartItems(int pageNumber) async {
    CartList cartList =
        CartList(list: [], currentPage: 0, totalCount: 0, totalPages: 0);

    try {
      var url = Uri.parse("$hostUrl/cart");

      var headers = await _getHeaders();

      var response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        cartList = CartList.fromRawJson(response.body);
      }
    } catch (e) {
      log("Cart get error : $e");
    }
    return cartList;
  }

  Future<CartItems> getCartItemsAndCounts() async {
    CartItems items = CartItems(products: [], length: 0);

    var url = Uri.parse("$hostUrl/cart/idAndCount");

    var headers = await _getHeaders();

    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      items = CartItems.fromRawJson(response.body);
    }

    return items;
  }

  Future<CartTotal> getCartValue() async {
    CartTotal items = CartTotal(orderValue: 0);

    var url = Uri.parse("$hostUrl/cart/cartValue");

    var headers = await _getHeaders();

    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      items = CartTotal.fromRawJson(response.body);
    }

    return items;
  }

  Future<int> getCartCountById(String? id) async {
    CartCount items = CartCount(count: 0);

    var url = Uri.parse("$hostUrl/cart/cartCount?productId=$id");

    var headers = await _getHeaders();

    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      items = CartCount.fromRawJson(response.body);
    }

    return items.count;
  }

  Future<void> deleteCartItem(String? productId) async {
    var url = Uri.parse("$hostUrl/cart?id=$productId");

    var headers = await _getHeaders();

    var response = await http.delete(
      url,
      headers: headers,
    );

    log(response.body);

    if (response.statusCode == 200) {
      log("Cart removed : ${response.body}");
    }
  }

  Future<void> deleteAllCartItems() async {
    try {
      var url = Uri.parse("$hostUrl/cart/deleteAll");

      var headers = await _getHeaders();

      var response = await http.delete(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        //
      }
    } catch (e) {
      log("Exception while clear cart");
    }
  }

  Future<void> viewUpdate(String productId) async {
    var url = Uri.parse("$hostUrl/features/view/$productId");

    var headers = await _getHeaders();

    var response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      //
    }
  }

  Future<Addresses> getAddresses() async {
    Addresses addresses = Addresses(addresses: []);
    var url = Uri.parse("$hostUrl/address");
    var headers = await _getHeaders();
    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        addresses = Addresses.fromRawJson('{ "Addresses" :${response.body} }');
      }
    } catch (e) {
      log("Exception : $e");
    }
    return addresses;
  }

  Future<void> addAddresses(Address address) async {
    var url = Uri.parse("$hostUrl/address");
    var headers = await _getHeaders();
    try {
      var response = await http.post(
        url,
        headers: headers,
        body: address.toRawJson(),
      );

      if (response.statusCode == 200) {
        //
      }
    } catch (e) {
      log("Exception : $e");
    }
  }

  Future<void> placeOrder(Order order) async {
    var url = Uri.parse("$hostUrl/orders");
    var headers = await _getHeaders();
    try {
      var response = await http.post(
        url,
        headers: headers,
        body: order.toRawJson(),
      );

      if (response.statusCode == 200) {
        //
      }
    } catch (e) {
      log("Exception : $e");
    }
  }

  Future<MyOrders> getAllOrders() async {
    MyOrders myOrders =
        MyOrders(list: [], currentPage: 0, totalCount: 0, totalPages: 0);
    var url = Uri.parse("$hostUrl/orders");
    var headers = await _getHeaders();
    try {
      var response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        myOrders = MyOrders.fromRawJson(response.body);
      }
    } catch (e) {
      log("Exception : $e");
    }

    return myOrders;
  }

  Future<List<Store>> getAvailableLocations() async {
    StoreLocation stores =
        StoreLocation(stores: [], currentPage: 0, totalCount: 0, totalPages: 0);
    var url = Uri.parse("$hostUrl/store?page=0");
    var headers = await _getHeaders();
    try {
      var response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        stores = StoreLocation.fromRawJson(response.body);
      }
    } catch (e) {
      log("Location Exception : $e");
    }

    return stores.stores;
  }

  Future<void> productView(String id) async {
    var url = Uri.parse("$hostUrl/features/view/$id");
    var headers = await _getHeaders();
    try {
      await http.post(url, headers: headers);
    } catch (e) {
      log("Location Exception : $e");
    }
  }

  Future<double> getDeliveryCharge() async {
    String id = await secureStorage.get("location");
    double deliveryCharge = 0.0;
    var url = Uri.parse("$hostUrl/store/$id");
    var headers = await _getHeaders();
    try {
      var response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        Store store = Store.fromRawJson(response.body);
        deliveryCharge = store.minDeliveryPrice;
      }
    } catch (e) {
      log("Location Exception : $e");
    }

    return deliveryCharge;
  }

  Future<Map<String, String>> _getHeaders() async {
    return {
      "content-type": "application/json",
      "Authorization": "Bearer ${await secureStorage.get('access-token')}"
    };
  }
}

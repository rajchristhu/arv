// ignore_for_file: depend_on_referenced_packages, import_of_legacy_library_into_null_safe

import 'package:arv/utils/distance-calculator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';

import '../utils/secure_storage.dart';
import 'app_const.dart';
import 'dart:math';

import 'package:arv/models/response_models/store_locations.dart';
import 'package:arv/shared/app_const.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/utils/secure_storage.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: library_private_types_in_public_api

class MainScreenController extends GetxController {
  final Geolocator geoLocator = Geolocator();
  Position? _currentPosition;
  String _currentAddress = "";
  String _storeName = "";
  bool _isLocationAvailable = false;

  String get currentAddress => _currentAddress;

  String get storeName => _storeName;

  bool get isLocationAvailable => _isLocationAvailable;
  String nae = '';

  @override
  Future<void> onInit() async {
    super.onInit();

    nae = AppConstantsUtils.loc;
    if (nae == "") {
      _getCurrentLocation();
    } else {
      setLatitude(AppConstantsUtils.lat);
      setLongitude(AppConstantsUtils.long);
      await findNearByStore();
      _currentAddress = nae;
    }
  }

  late double _currentLatitude;
  late double _currentLongitude;

  setLatitude(double latitude) => _currentLatitude = latitude;

  setLongitude(double longitude) => _currentLongitude = longitude;

  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyCRW-f7wM1mFtMvsrX8oNZ7_yhUv5Apkh8";

  Map<PolylineId, Polyline> polyLines = {};
  List<double> sd = [];
  Future<String> findNearByStore() async {
    int io = 0;

    double? minDistance = 0;
    List<Store> stores = await arvApi.getAvailableLocations();
    stores.forEach((store) async {
      List<LatLng> polylineCoordinates = [];

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(
            double.parse(store.latitude), double.parse(store.longitude)),
        PointLatLng(_currentLatitude, _currentLongitude),
        travelMode: TravelMode.driving,
      );

      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }

      double distanceBetweenUserAndStore = 0;
      // for (var i = 0; i < polylineCoordinates.length - 1; i++) {
      //   distanceBetweenUserAndStore += calculateDistance(
      //       polylineCoordinates[i].latitude,
      //       polylineCoordinates[i].longitude,
      //       polylineCoordinates[i + 1].latitude,
      //       polylineCoordinates[i + 1].longitude);
      //
      //
      // }
      distanceBetweenUserAndStore = distance(double.parse(store.latitude),
          double.parse(store.longitude), _currentLatitude, _currentLongitude);

      minDistance = distanceBetweenUserAndStore;
      print("object");
      print(minDistance);
      print(minDistance! < 17);
      if (minDistance! < 17) {
        io = 0;
        minDistance = distanceBetweenUserAndStore;
        AppConstantsUtils.location = store.id;
        AppConstantsUtils.storeName = store.name;
        secureStorage.add("location", store.id);
        secureStorage.add("storeName", store.name);
        print("fdfjdbfjbd f");
        print(AppConstantsUtils.location);
        print(AppConstantsUtils.storeName);
        print(minDistance);
        print(distanceBetweenUserAndStore);
        _isLocationAvailable = await secureStorage.get("location") != "";
        _storeName = await secureStorage.get("storeName");
        print("_storeName");

        print(_storeName);
        update();
      } else {
        io = io + 1;
        print("sd");
        print(stores.length);
        print(io);
        print(io == stores.length);
        if (io == stores.length) {
          secureStorage.add("location", "");
          secureStorage.add("storeName", "");
          AppConstantsUtils.location = "";
          AppConstantsUtils.storeName = "";
        }
      }
    });
    // sd.clear();
    // stores.forEach((store) {

    // });
    return AppConstantsUtils.location;
  }

  double distance(double lat1, double lon1, double lat2, double lon2) {
    const r = 6372.8; // Earth radius in kilometers

    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    final lat1Radians = _toRadians(lat1);
    final lat2Radians = _toRadians(lat2);

    final a =
        _haversin(dLat) + cos(lat1Radians) * cos(lat2Radians) * _haversin(dLon);
    final c = 2 * asin(sqrt(a));

    return r * c;
  }

  double _toRadians(double degrees) => degrees * pi / 180;

  num _haversin(double radians) => pow(sin(radians / 2), 2);

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  _getCurrentLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    _getAddressFromLatLng(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );
  }

  _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      Placemark place = p[0];
      setLatitude(latitude);
      setLongitude(longitude);
      AppConstantsUtils.lat = latitude;
      AppConstantsUtils.long = longitude;

      await findNearByStore();
      // _isLocationAvailable = AppConstantsUtils.location != "";
      // _storeName = AppConstantsUtils.storeName;
      // _isLocationAvailable = await secureStorage.get("location") != "";
      // _storeName = await secureStorage.get("storeName");
      // update();
      print("_isLocationAvailable");
      print(_isLocationAvailable);
      _currentAddress =
          "${place.name != null ? "${place.name} ," : ""}${place.subLocality != null ? "${place.subLocality} ," : ""}${place.locality} ${place.postalCode}, ${place.country}";
    } catch (e) {
      //
    }
    update();
  }
}

// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, import_of_legacy_library_into_null_safe

import 'dart:math';

import 'package:arv/models/response_models/store_locations.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/utils/secure_storage.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

_DistanceCalculator distanceCalculator = _DistanceCalculator.instance;

class _DistanceCalculator {
  Geolocator geoLocator = Geolocator();

  _DistanceCalculator._();

  static final _DistanceCalculator instance = _DistanceCalculator._();

  late double _currentLatitude;
  late double _currentLongitude;

  setLatitude(double latitude) => _currentLatitude = latitude;

  setLongitude(double longitude) => _currentLongitude = longitude;

  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyCRW-f7wM1mFtMvsrX8oNZ7_yhUv5Apkh8";

  Map<PolylineId, Polyline> polyLines = {};

  Future<void> findNearByStore() async {
    print("fdf");
    print(_currentLatitude);
    print(_currentLongitude);
    double? minDistance;
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
      for (var i = 0; i < polylineCoordinates.length - 1; i++) {
        distanceBetweenUserAndStore += calculateDistance(
            polylineCoordinates[i].latitude,
            polylineCoordinates[i].longitude,
            polylineCoordinates[i + 1].latitude,
            polylineCoordinates[i + 1].longitude);
      }
      minDistance ??= distanceBetweenUserAndStore;

      if (minDistance! >= distanceBetweenUserAndStore &&
          distanceBetweenUserAndStore < 17) {
        minDistance = distanceBetweenUserAndStore;
        secureStorage.add("location", store.id);
        secureStorage.add("storeName", store.name);
      }
      print("fdfjdbfjbd f");
      print(minDistance);
      print(distanceBetweenUserAndStore);
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}

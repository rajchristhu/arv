// ignore_for_file: library_private_types_in_public_api

import 'package:arv/models/response_models/store_locations.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/utils/secure_storage.dart';
import 'package:geolocator/geolocator.dart';

_DistanceCalculator distanceCalculator = _DistanceCalculator.instance;

class _DistanceCalculator {
  Geolocator geoLocator = Geolocator();

  _DistanceCalculator._();

  static final _DistanceCalculator instance = _DistanceCalculator._();

  late double _currentLatitude;
  late double _currentLongitude;
  late double distance;

  setLatitude(double latitude) => _currentLatitude = latitude;

  setLongitude(double longitude) => _currentLongitude = longitude;

  Future<void> findNearByStore() async {
    double minDistance = 18;
    String minDistanceStoreId = "";
    List<Store> stores = await arvApi.getAvailableLocations();
    stores.forEach((store) async {
      double currentMin = await geoLocator.distanceBetween(
        double.parse(store.latitude),
        double.parse(store.longitude),
        _currentLatitude,
        _currentLongitude,
      );
      if (minDistance > (currentMin / 1000.0)) {
        minDistance = currentMin;
        minDistanceStoreId = store.id;
        distance = minDistance;
        secureStorage.add("location", minDistanceStoreId);
      }
    });
  }
}

// ignore_for_file: depend_on_referenced_packages, import_of_legacy_library_into_null_safe

import 'package:arv/utils/distance-calculator.dart';
import 'package:arv/utils/secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

// ignore: library_private_types_in_public_api

class MainScreenController extends GetxController {
  final Geolocator geoLocator = Geolocator()..forceAndroidLocationManager;
  Position? _currentPosition;
  String _currentAddress = "";
  String _storeName = "";
  bool _isLocationAvailable = false;

  String get currentAddress => _currentAddress;

  String get storeName => _storeName;

  bool get isLocationAvailable => _isLocationAvailable;

  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    _currentPosition = await geoLocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    _getAddressFromLatLng();
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geoLocator.placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      Placemark place = p[0];
      distanceCalculator.setLatitude(_currentPosition!.latitude);
      distanceCalculator.setLongitude(_currentPosition!.longitude);
      await distanceCalculator.findNearByStore();
      _isLocationAvailable = await secureStorage.get("location") != "";
      _storeName = await secureStorage.get("storeName");

      _currentAddress =
          "${place.name != null ? "${place.name} ," : ""}${place.subLocality != null ? "${place.subLocality} ," : ""}${place.locality} ${place.postalCode}, ${place.country}";
    } catch (e) {
      //
    }
    update();
  }
}

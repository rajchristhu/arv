// ignore_for_file: depend_on_referenced_packages, import_of_legacy_library_into_null_safe

import 'package:arv/utils/distance-calculator.dart';
import 'package:arv/utils/secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'app_const.dart';

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
  String nae = '';

  @override
  Future<void> onInit() async {
    super.onInit();
    nae=AppConstantsUtils.loc;
    print("nae");
    print(nae);
    if (nae == "") {
      _getCurrentLocation();
    } else {
      print("dfdfd");
      print(AppConstantsUtils.lat);
      print(AppConstantsUtils.long);
      distanceCalculator.setLatitude(AppConstantsUtils.lat);
      distanceCalculator.setLongitude(AppConstantsUtils.long);
      await distanceCalculator.findNearByStore();

      _currentAddress = nae;
    }
  }

  _getCurrentLocation() async {
    _currentPosition = await geoLocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    _getAddressFromLatLng(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );
  }

  _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> p = await geoLocator.placemarkFromCoordinates(
        latitude,
        longitude,
      );

      Placemark place = p[0];
      distanceCalculator.setLatitude(latitude);
      distanceCalculator.setLongitude(longitude);
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

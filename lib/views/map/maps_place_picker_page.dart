import 'package:arv/google_maps_place_picker/src/models/circle_area.dart';
import 'package:arv/google_maps_place_picker/src/models/pick_result.dart';
import 'package:arv/google_maps_place_picker/src/place_picker.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:io' show Platform;

import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';

import 'api_keys.dart';




class MapsPlacePicker extends StatefulWidget {
  MapsPlacePicker({Key? key}) : super(key: key);

  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;

  @override
  // ignore: library_private_types_in_public_api
  _MapsPlacePickerState createState() => _MapsPlacePickerState();
}

class _MapsPlacePickerState extends State<MapsPlacePicker> {
  PickResult? selectedPlace;

  bool _mapsInitialized = false;
  String _mapsRenderer = "auto";

  void initRenderer() {
    print("loading");
    if (_mapsInitialized) return;
    if (widget.mapsImplementation is GoogleMapsFlutterAndroid) {
      switch (_mapsRenderer) {
        case "legacy":
          (widget.mapsImplementation as GoogleMapsFlutterAndroid)
              .initializeWithRenderer(AndroidMapRenderer.legacy);
          break;
        case "latest":
          (widget.mapsImplementation as GoogleMapsFlutterAndroid)
              .initializeWithRenderer(AndroidMapRenderer.latest);
          break;
      }
    }
    setState(() {
      _mapsInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      resizeToAvoidBottomInset: true,
      apiKey: Platform.isAndroid ? ApiKeys.androidApiKey : ApiKeys.iosApiKey,
      hintText: "Search Location ...",
      searchingText: "Please wait ...",
      selectText: "Select place",
      outsideOfPickAreaText: "Place not in area",
      initialPosition: MapsPlacePicker.kInitialPosition,
      useCurrentLocation: true,
      selectInitialPosition: true,
      usePinPointingSearch: true,
      usePlaceDetailSearch: true,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        print("Map created : ${selectedPlace?.name!}");
      },
      onPlacePicked: (PickResult result) {
        print("Place picked: ${result.formattedAddress}");
        setState(() {
          selectedPlace = result;
          Navigator.of(context).pop();
        });
      },
      onMapTypeChanged: (MapType mapType) {
        print("Map type changed to ${mapType.toString()}");
      },
      // #region additional stuff
      // forceSearchOnZoomChanged: true,
      // automaticallyImplyAppBarLeading: false,
      // autocompleteLanguage: "ko",
      // region: 'au',
      pickArea: CircleArea(
        center: MapsPlacePicker.kInitialPosition,
        radius: 300,
        fillColor: Colors.lightGreen.withGreen(255).withAlpha(32),
        strokeColor: Colors.lightGreen.withGreen(255).withAlpha(192),
        strokeWidth: 2,
      ),
    );
  }
}

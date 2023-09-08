import 'dart:ui';

import 'package:arv/utils/configs.dart';
import 'package:flutter/material.dart';


class ScreenSizeUtil {
  ///figma dimensions with respect to mdpi (values in dp)
  static Size refSize =
      Size(AppConfigs.figmaRefWidth, AppConfigs.figmaRefHeight);

  double screenHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  double screenWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  double getHeight(context, double refVal) {
    return _calculateRefValues(
        screenHeight(context),
        MediaQuery.of(context).orientation == Orientation.portrait
            ? refSize.height
            : refSize.width,
        refVal);
  }

  double getWidth(context, double refVal) {
    return _calculateRefValues(
        screenWidth(context),
        MediaQuery.of(context).orientation == Orientation.portrait
            ? refSize.width
            : refSize.height,
        refVal);
  }

  double _calculateRefValues(double numerator, double denom, double refVal) {
    return numerator / (denom / refVal);
  }
}

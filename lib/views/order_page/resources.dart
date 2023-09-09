import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Resources {
  BuildContext _context;

  Resources(this._context);

  Strings get strings {
    return StringsValue();
  }

  AppColors get color {
    return AppColors();
  }

  AppDimension get dimension {
    return AppDimension();
  }

  static Resources of(BuildContext context) {
    return Resources(context);
  }
}

class StringsValue extends Strings {
  @override
  String get homeScreen => "Decade of Movies";

  @override
  String get movieDetailScreen => "Movies Details";

  @override
  String get titleCast => "Cast";

  @override
  String get titleCategories => "Categories";
}

abstract class Strings {
  String get homeScreen;

  String get movieDetailScreen;

  String get titleCategories;

  String get titleCast;
}

class AppColors implements BaseColors {
  final Map<int, Color> _primary = {
    50: const Color.fromRGBO(22, 134, 206, 0.1),
    100: const Color.fromRGBO(22, 134, 206, 0.2),
    200: const Color.fromRGBO(22, 134, 206, 0.3),
    300: const Color.fromRGBO(22, 134, 206, 0.4),
    400: const Color.fromRGBO(22, 134, 206, 0.5),
    500: const Color.fromRGBO(22, 134, 206, 0.6),
    600: const Color.fromRGBO(22, 134, 206, 0.7),
    700: const Color.fromRGBO(22, 134, 206, 0.8),
    800: const Color.fromRGBO(22, 134, 206, 0.9),
    900: const Color.fromRGBO(22, 134, 206, 1.0),
  };

  @override
  MaterialColor get colorAccent => Colors.amber;

  @override
  Color get colorPrimary => HexColor("#F7692F");

  @override
  Color get colorPrimaryText => Color(0xff49ABFF);

  @override
  Color get colorSecondaryText => Color(0xff3593FF);

  @override
  Color get colorWhite => Color(0xffffffff);

  @override
  Color get colorBlack => HexColor("#686B78");

  @override
  Color get castChipColor => Colors.deepOrangeAccent;

  @override
  Color get catChipColor => Colors.indigoAccent;
}

abstract class BaseColors {
  //theme color
  Color get colorPrimary;

  MaterialColor get colorAccent;

  //text color
  Color get colorPrimaryText;

  Color get colorSecondaryText;

  //chips color
  Color get catChipColor;

  Color get castChipColor;

  //extra color
  Color get colorWhite;

  Color get colorBlack;
}

class AppDimension extends Dimensions {
  @override
  double get bigMargin => 20;

  @override
  double get defaultMargin => 16;

  @override
  double get mediumMargin => 12;

  @override
  double get smallMargin => 8;

  @override
  double get verySmallMargin => 4;

  @override
  double get highElevation => 16;

  @override
  double get mediumElevation => 8;

  @override
  double get lightElevation => 4;

  @override
  double get bigText => 22;

  @override
  double get defaultText => 18;

  @override
  double get mediumText => 16;

  @override
  double get smallText => 12;

  @override
  double get verySmallText => 8;

  @override
  double get listImageSize => 50;

  @override
  double get imageBorderRadius => 8;

  @override
  double get imageHeight => 450;
}

abstract class Dimensions {
  //define your text sizes
  double get verySmallText;

  double get smallText;

  double get mediumText;

  double get defaultText;

  double get bigText;

  //define padding-margin
  double get verySmallMargin;

  double get smallMargin;

  double get mediumMargin;

  double get defaultMargin;

  double get bigMargin;

  //elevation
  double get lightElevation;

  double get mediumElevation;

  double get highElevation;

  //border radius
  double get imageBorderRadius;

  //extra
  double get listImageSize;

  double get imageHeight;
}

import 'package:arv/utils/screen_size_util.dart';
import 'package:flutter/material.dart';

class SizeHelper extends ScreenSizeUtil {
  static final SizeHelper _instance = SizeHelper._privateConstructor();

  SizeHelper._privateConstructor();

  static SizeHelper getInstance() {
    return _instance;
  }

  final Size _splashLogoSize = Size(300, 300);
  final Size _clientLogoSize = Size(161, 44);
  final double _clientLogoBottomPadding = 61;
  final double _tagLineHorizontalMargin = 98;
  final double _tagLineVerticalMargin = 34;
  final double _dividerLineTopMargin = 40;
  final double _dividerWidth = 87;

  double tagLineHorizontalMargin(context) =>
      getWidth(context, _tagLineHorizontalMargin);
  final double _fontSize = 16;

  double fontSize(context) => getWidth(context, _fontSize);

  double clientLogoBottomPadding(context) =>
      getHeight(context, _clientLogoBottomPadding);

  Size logoSize(context) {
    return Size(getWidth(context, _splashLogoSize.width),
        getHeight(context, _splashLogoSize.height));
  }

  Size clientLogoSize(context) {
    return Size(getWidth(context, _clientLogoSize.width),
        getHeight(context, _clientLogoSize.height));
  }

  double tagLineVerticalMargin(context) =>
      getHeight(context, _tagLineVerticalMargin);

  double dividerLineTopMargin(context) =>
      getHeight(context, _dividerLineTopMargin);

  double dividerWidth(context) => getWidth(context, _dividerWidth);
}

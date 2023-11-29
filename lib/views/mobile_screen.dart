import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/app_colors.dart';
import 'splash_screen/splash_screen.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    changeStatusColor(primaryColor);

    return const SplashPage();
  }
}

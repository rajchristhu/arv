import 'package:arv/views/home_bottom_navigation_screen.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/app_colors.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    changeStatusColor(primaryColor);

    return const HomeBottomNavigationScreen();
  }
}

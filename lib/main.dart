import 'dart:developer';

import 'package:arv/controller/init_binding.dart';
import 'package:arv/firebase_options.dart';
import 'package:arv/responsive.dart';
import 'package:arv/shared/app_theme.dart';
import 'package:arv/utils/secure_storage.dart';
import 'package:arv/views/mobile_screen.dart';
import 'package:arv/views/product_page/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      name: "ARV Exclusive cloud console",
    );
  } catch (e) {
    log("Firebase init error");
  }

  await secureStorage.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black54,
    statusBarBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}
changeStatusColor(Color color) async {
  try {
    await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
    if (useWhiteForeground(color)) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    } else {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    }
  } on PlatformException catch (e) {
    debugPrint(e.toString());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // changeStatusColor(primaryColor);
    return MultiProvider(providers: [
      ChangeNotifierProvider<NewsProvider>(create: (_) => NewsProvider()),
    ], child: GetMaterialApp(
        title: 'ARV',
        debugShowCheckedModeBanner: false,
        theme: appPrimaryTheme(),
        initialBinding: InitBindings(),
        home: const Responsive(
          mobile: MobileScreen(),
          tablet: MobileScreen(),
          desktop: MobileScreen(),
        )))


      ;
  }
}



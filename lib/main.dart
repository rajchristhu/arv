import 'package:arv/firebase_options.dart';
import 'package:arv/responsive.dart';
import 'package:arv/shared/app_theme.dart';
import 'package:arv/utils/secure_storage.dart';
import 'package:arv/views/mobile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await secureStorage.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black54,
    statusBarBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'ARV',
        debugShowCheckedModeBanner: false,
        theme: appPrimaryTheme(),
        home: const Responsive(
          mobile: MobileScreen(),
          tablet: MobileScreen(),
          desktop: MobileScreen(),
        ));
  }
}



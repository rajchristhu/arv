// ignore_for_file: depend_on_referenced_packages

import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/utils/secure_storage.dart';
import 'package:arv/utils/size_helper.dart';
import 'package:arv/views/authentication/login_new.dart';
import 'package:arv/views/authentication/user_info_form.dart';
import 'package:arv/views/home_bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../onboard/onboard_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SizeHelper _sizeHelper = SizeHelper.getInstance();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _navigate());
  }

  ///Navigate to Login screen
  void _navigate() async {
    Future.delayed(const Duration(seconds: 4), () async {
      if (mounted) {
        Widget nextScreen = const LoginPage();
        bool validUser = await arvApi.validateLogin;
        if (validUser) {
          nextScreen =  HomeBottomNavigationScreen(checkVal:true);
        }
        secureStorage.get("isFirst").then((value) async => {
              if (value != "1")
                {
                  secureStorage.add("isFirst", "1"),
                  Get.offAll(const OnboardingScreen())
                }
              else if (validUser && await secureStorage.get("location") == "")
                {
                  // ignore: use_build_context_synchronously
                  // _showBottomSheet(context);
                  Get.offAll(() => nextScreen)
                }
              else
                {Get.offAll(() => nextScreen)}
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(),
              ],
            ),
          ),
          // _clientLogo(),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.only(top: _sizeHelper.dividerLineTopMargin(context)),
      width: _sizeHelper.dividerWidth(context),
      child: Divider(
        height: 1,
        color: brownBackGroundColor,
      ),
    );
  }

  Widget _buildTagLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 0,
      ),
      child: FadeIn(
        child: SizedBox(
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 42.0, fontWeight: FontWeight.w600),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText('ARV Exclusive',
                    speed: const Duration(milliseconds: 250)),
                // TypewriterAnimatedText('Design first, then code'),
              ],
              onTap: () {
                debugPrint("Tap Event");
              },
            ),
          ),
        ),
      ),
    );
  }

  ///build app logo at the center
  Widget _buildLogo() {
    return FadeInDownBig(
      from: 1,
      duration: const Duration(milliseconds: 500),
      delay: const Duration(milliseconds: 250),
      child: ArvLogo(),
    );
  }

}

class ArvLogo extends StatelessWidget {
  final SizeHelper _sizeHelper = SizeHelper.getInstance();

  ArvLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/splash.gif',
      width: MediaQuery.of(context).size.width,
      height:  MediaQuery.of(context).size.height,
    );
  }
}

// ignore_for_file: depend_on_referenced_packages

import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/utils/secure_storage.dart';
import 'package:arv/utils/size_helper.dart';
import 'package:arv/views/authentication/login_page.dart';
import 'package:arv/views/authentication/user_info_form.dart';
import 'package:arv/views/home_bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    Future.delayed(const Duration(seconds: 5), () async {
      if (mounted) {
        Widget nextScreen = const ContinueWithPhone();
        bool validUser = await arvApi.validateLogin;
        if (validUser) {
          nextScreen = const HomeBottomNavigationScreen();
        }
        if (validUser && await secureStorage.get("location") == "") {
          // ignore: use_build_context_synchronously
          _showBottomSheet(context);
        } else {
          Get.offAll(() => nextScreen);
        }
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
                _buildDivider(),
                _buildTagLine(),
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
      duration: const Duration(milliseconds: 1000),
      delay: const Duration(milliseconds: 500),
      child: ArvLogo(),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      isDismissible: false,
      enableDrag: false,
      useSafeArea: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      builder: (BuildContext context) {
        return const UserInfoForm();
      },
    );
  }
}

class ArvLogo extends StatelessWidget {
  final SizeHelper _sizeHelper = SizeHelper.getInstance();

  ArvLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: _sizeHelper.logoSize(context).width,
      height: _sizeHelper.logoSize(context).height,
    );
  }
}

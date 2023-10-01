import 'package:arv/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: whiteLightColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, whiteLightColor],
            )),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                height: 0,
                                constraints:
                                    const BoxConstraints(maxWidth: 500),
                                margin: const EdgeInsets.only(top: 100),
                                decoration: const BoxDecoration(
                                    color: Color(0xFFE1E0F5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                              ),
                            ),
                            Center(
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxHeight: 340),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: SvgPicture.asset(
                                  "assets/images/charactor.svg",
                                  semanticsLabel: 'Acme Logo',
                                  width: 340,
                                  height: 340,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Login Account',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor)),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Quickly Login Account',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: primaryLightColor)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 18, right: 16, left: 16),
                              height: 60,
                              constraints: const BoxConstraints(maxWidth: 500),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0))),
                              child: Text(
                                '+91',
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: primaryColor)),
                              ),
                            ),
                            Container(
                              height: 60,
                              constraints: const BoxConstraints(maxWidth: 300),
                              child: CupertinoTextField(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0))),
                                controller: phoneController,
                                clearButtonMode: OverlayVisibilityMode.editing,
                                keyboardType: TextInputType.phone,
                                maxLines: 1,
                                placeholder: 'Enter your number',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: ElevatedButton(
                            onPressed: () {
                              if (phoneController.text.isNotEmpty) {
                              } else {}
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    primaryColorLight),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14))))),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width,
                              color: primaryColorLight,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Get OTP',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )

                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

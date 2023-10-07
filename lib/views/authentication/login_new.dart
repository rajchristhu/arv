import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/custom_progress_bar.dart';
import 'package:arv/utils/secure_storage.dart';
import 'package:arv/views/authentication/otp_new.dart';
import 'package:arv/views/authentication/verify_phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  bool check = false;
  late FirebaseAuth auth;
  FocusNode myfocus = FocusNode(); //create focus node

  @override
  void initState() {
    super.initState();
    changeStatusColor(Colors.white);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark); // 2
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      auth = FirebaseAuth.instance;
    });
  }

  login() async {
    ArvProgressDialog.instance.showProgressDialog(context);

    await secureStorage.add("username", phoneController.text);
    String number = "+91 ${phoneController.text}";

    await auth.verifyPhoneNumber(
      phoneNumber: number,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {}
      },
      codeSent: (String verificationId, int? resendToken) async {
        ArvProgressDialog.instance.dismissDialog(context);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPNewPage(
              phoneNumber: number,
              verificationId: verificationId,
              resendToken: resendToken,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

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
                Column(
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
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.all(20),
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
                      const SizedBox(height: 6),
                      Text(
                        'Quickly Login Account',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: primaryLightColor)),
                      ),
                      const SizedBox(height: 20),
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
                              autofocus: true,
                              focusNode: myfocus,
                              onChanged: (content) {
                                if(content.length==10){
                                  myfocus.unfocus();
                                }
                              },
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(0))),
                              controller: phoneController,
                              clearButtonMode: OverlayVisibilityMode.editing,
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              maxLines: 1,
                              placeholder: 'Enter your number',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 10),
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: ElevatedButton(
                          onPressed: () {
                            if (phoneController.text.isNotEmpty) {
                              login();
                            } else {}
                          },
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(primaryColorLight),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(14),
                                ),
                              ),
                            ),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: primaryColorLight,
                            padding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Get OTP',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

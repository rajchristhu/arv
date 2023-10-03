import 'dart:math';

import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'numeric_pad.dart';
import 'verify_phone.dart';

class ContinueWithPhone extends StatefulWidget {
  const ContinueWithPhone({super.key});

  @override
  State createState() => _ContinueWithPhoneState();
}

class _ContinueWithPhoneState extends State<ContinueWithPhone> {
  String phoneNumber = "";
  String countryCode = "+91 ";
  bool check = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  login() async {
    print("ajhdf");
    await secureStorage.add("username", phoneNumber);
    print("ajhdfsdfsd");
    await auth.verifyPhoneNumber(
      phoneNumber: countryCode + phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {
        print("SMS Code ${credential.smsCode}");
      },
      verificationFailed: (FirebaseAuthException e) {
        print("e.code");
        print(e.code);
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyPhone(
              phoneNumber: phoneNumber,
              verificationId: verificationId,
              resendToken: resendToken,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    print("sropwpeo");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ARV Exclusive",
          style: GoogleFonts.ubuntu(
            textStyle: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white,
              Colors.white,
              swiggyOrange,
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFF7F7F7),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Lottie.asset(
                      "assets/json/phone.json",
                      key: Key('${Random().nextInt(999999999)}'),
                      height: 200,
                      alignment: Alignment.topCenter,
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 230,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Enter your phone number",
                            style: TextStyle(
                              fontSize: 15,
                              color: gray,
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Text(
                                countryCode,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: gray,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                phoneNumber,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          login();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: appColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(60),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Send OTP",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            NumericPad(
              onNumberSelected: (value) {
                setState(() {
                  check = true;
                  if (value == -1 && phoneNumber != "") {
                    phoneNumber =
                        phoneNumber.substring(0, phoneNumber.length - 1);
                  } else if (phoneNumber.length < 10 && value != -1) {
                    phoneNumber += value.toString();
                  }
                });
              },
            ),
          ],
        ),
      )),
    );
  }
}

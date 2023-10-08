import 'package:arv/models/request/user.dart';
import 'package:arv/shared/utils.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/utils/secure_storage.dart';
import 'package:arv/views/authentication/numeric_pad.dart';
import 'package:arv/views/home_bottom_navigation_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyPhone extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  final int? resendToken;

  const VerifyPhone({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
    required this.resendToken,
  });

  @override
  State createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  String code = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Verify phone",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      "We have sent an OTP to ${widget.phoneNumber}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF818181),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buildCodeNumberBox(
                            code.isNotEmpty ? code.substring(0, 1) : ""),
                        buildCodeNumberBox(
                            code.length > 1 ? code.substring(1, 2) : ""),
                        buildCodeNumberBox(
                            code.length > 2 ? code.substring(2, 3) : ""),
                        buildCodeNumberBox(
                            code.length > 3 ? code.substring(3, 4) : ""),
                        buildCodeNumberBox(
                            code.length > 4 ? code.substring(4, 5) : ""),
                        buildCodeNumberBox(
                            code.length > 5 ? code.substring(5, 6) : ""),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Didn't receive code? ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF818181),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            print("Resend the code to the user");
                          },
                          child: const Text(
                            "Request again",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.11,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(60),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        await secureStorage.add(
                          "location",
                          "651a665ede43800aa3bff961",
                        );
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: code,
                        );
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithCredential(credential);
                        String uid = userCredential.user?.uid ?? "";
                        await secureStorage.add("uid", uid);
                        String token =
                            await arvApi.login(widget.phoneNumber, uid);
                        bool isNewUser = token == "";
                        if (isNewUser) {
                          ArvUser user = ArvUser(
                            phone: widget.phoneNumber,
                            email: "",
                            uid: uid,
                            username: '',
                            userType: "CUSTOMER",
                          );

                          await arvApi.register(user);
                        }
                        utils.notify("Verification completed !");
                        await Future.delayed(const Duration(seconds: 2));
                        Get.offAll(() => const HomeBottomNavigationScreen());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: appColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(60),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 18,
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
                if (value != -1 && code.length < 6) {
                  code = code + value.toString();
                } else {
                  code = code.substring(0, code.length - 1);
                }
              });
            },
          ),
        ],
      )),
    );
  }

  Widget buildCodeNumberBox(String codeNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: SizedBox(
        width: 50,
        height: 50,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF6F5FA),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: gray,
                  blurRadius: 20.0,
                  spreadRadius: 1,
                  offset: const Offset(8.0, 4.2))
            ],
          ),
          child: Center(
            child: Text(
              codeNumber,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
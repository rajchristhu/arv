import 'package:arv/main.dart';
import 'package:arv/models/request/user.dart';
import 'package:arv/shared/utils.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/utils/custom_progress_bar.dart';
import 'package:arv/utils/secure_storage.dart';
import 'package:arv/views/authentication/user_info_form.dart';
import 'package:arv/views/home_bottom_navigation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPNewPage extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  final int? resendToken;

  const OTPNewPage({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
    required this.resendToken,
  });

  @override
  State createState() => _OTPNewPageState();
}

class _OTPNewPageState extends State<OTPNewPage> {
  TextEditingController phoneController = TextEditingController();
  bool check = false;
  late FirebaseAuth auth;
  String code = "";

  @override
  void initState() {
    super.initState();
    changeStatusColor(Colors.white);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark); // 2
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      auth = FirebaseAuth.instance;
    });
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
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        "assets/images/back.svg",
                        semanticsLabel: 'Acme Logo',
                        width: 10,
                        height: 15,
                      ),
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width) / 5,
                    ),
                    Center(
                      child: Text(
                        'Verify Number',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width / 4),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Verify your number',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor)),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Enter your OTP code below',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: primaryLightColor)),
                        ),
                        const SizedBox(height: 20),
                        OtpTextField(
                          numberOfFields: 6,
                          // focusedBorderColor: accentPurpleColor,
                          // styles: otpTextStyles,
                          showFieldAsBox: true,
                          borderWidth: 2.0,
                          fieldWidth: 50,

                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                          focusedBorderColor: pinkColor,
                          autoFocus: true,
                          cursorColor: pinkColor,
                          //runs when a code is typed in
                          onCodeChanged: (String code) {
                            code = "";
                          },
                          onSubmit: (String verificationCode) {
                            code = verificationCode;
                          },
                        ),
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (code.length == 6) {
                                ArvProgressDialog.instance
                                    .showProgressDialog(context);

                                PhoneAuthCredential credential =
                                    PhoneAuthProvider.credential(
                                  verificationId: widget.verificationId,
                                  smsCode: code,
                                );
                                UserCredential userCredential =
                                    await FirebaseAuth.instance
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
                                utils.notify("Validation Completed !");
                                // ignore: use_build_context_synchronously
                                ArvProgressDialog.instance
                                    .dismissDialog(context);

                                Get.offAll(
                                    () =>  HomeBottomNavigationScreen(checkVal:true));
                              } else {
                                utils.notify("OTP is 6 digit");
                              }
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
                                    'Login',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: Text(
                            'Did’nt receive the code ?',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: primaryLightColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Center(
                          child: Text(
                            'Resend a new code',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: pinkColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCodeNumberBox(String codeNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SizedBox(
        width: 50,
        height: 50,
        child: Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: gray50,
                  blurRadius: 0.0,
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

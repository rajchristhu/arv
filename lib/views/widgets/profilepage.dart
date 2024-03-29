import 'package:arv/utils/arv_api.dart';
import 'package:arv/views/authentication/login_new.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/secure_storage.dart';
import '../authentication/user_info_form.dart';

class ProfilePage extends StatefulWidget {
   String nameVal;
    String phoneVal;
   ProfilePage({ required this.nameVal, required this.phoneVal}) ;

  @override
  State createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  String profileName = "";
  String phone="";
  @override
  void initState() {
    super.initState();
    profileName = widget.nameVal.toString();
    phone =widget.phoneVal.toString();
    getProfile();

  }

  @override
  void dispose() {
    super.dispose();
  }

  getProfile() {
    arvApi.getNameApi().then((value) => {
          print("profile"),
          print(value.profileName),

        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // User card
            BigUserCard(
              userName: "Babacar Ndong",
              userProfilePic: AssetImage("assets/logo.png"),
              cardActionWidget: SettingsItem(
                icons: Icons.edit,
                iconStyle: IconStyle(
                  withBackground: true,
                  borderRadius: 50,
                  backgroundColor: Colors.yellow[600],
                ),
                title: profileName,
                subtitle: phone,
                onTap: () {
                  _showBottomSheet(context);
                },
              ),
            ),
            // SettingsGroup(
            //   items: [
            //     SettingsItem(
            //       onTap: () {},
            //       icons: CupertinoIcons.folder_fill,
            //       iconStyle: IconStyle(),
            //       title: 'Wallet',
            //       subtitle: "Coming soon",
            //     ),
            //     // SettingsItem(
            //     //   onTap: () {},
            //     //   icons: Icons.dark_mode_rounded,
            //     //   iconStyle: IconStyle(
            //     //     iconsColor: Colors.white,
            //     //     withBackground: true,
            //     //     backgroundColor: Colors.red,
            //     //   ),
            //     //   title: 'Dark mode',
            //     //   subtitle: "Automatic",
            //     //   trailing: Switch.adaptive(
            //     //     value: false,
            //     //     onChanged: (value) {},
            //     //   ),
            //     // ),
            //   ],
            // ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    _settingModalBottomSheet(context);
                  },
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'About',
                  subtitle: "All copy rights under ARV ",
                ),
              ],
            ),
            // You can add a settings title
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () async {
                    FlutterSecureStorage storage = FlutterSecureStorage();
                    secureStorage.add("access-token", "");
                    await storage
                        .deleteAll()
                        .then((value) => Get.offAll(() => const LoginPage()));
                  },
                  icons: Icons.exit_to_app_rounded,
                  title: "Sign Out",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.all(30),
            child: new Wrap(
              children: <Widget>[
                Text(
                  'ARV Shopping Mall, 39, TVR Road, Thruthuraipoondi, Tamil Nadu 614713',
                  style: GoogleFonts.poppins(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        });
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
        return  UserInfoForm(check: true,);
      },
    );
  }
}

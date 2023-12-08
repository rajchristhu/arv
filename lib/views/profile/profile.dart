import 'package:arv/models/response_models/profile.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/views/authentication/login_new.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import '../../utils/secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
            // BigUserCard(
            //   userName: "Babacar Ndong",
            //   userProfilePic: AssetImage("assets/logo.png"),
            //   cardActionWidget: SettingsItem(
            //     icons: Icons.edit,
            //     iconStyle: IconStyle(
            //       withBackground: true,
            //       borderRadius: 50,
            //       backgroundColor: Colors.yellow[600],
            //     ),
            //     title: "Modify",
            //     subtitle: "Tap to change your data",
            //     onTap: () {
            //       print("OK");
            //     },
            //   ),
            // ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.folder_fill,
                  iconStyle: IconStyle(),
                  title: 'Wallet',
                  subtitle: "Make Ziar'App yours",
                ),
                // SettingsItem(
                //   onTap: () {},
                //   icons: Icons.dark_mode_rounded,
                //   iconStyle: IconStyle(
                //     iconsColor: Colors.white,
                //     withBackground: true,
                //     backgroundColor: Colors.red,
                //   ),
                //   title: 'Dark mode',
                //   subtitle: "Automatic",
                //   trailing: Switch.adaptive(
                //     value: false,
                //     onChanged: (value) {},
                //   ),
                // ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'About',
                  subtitle: "Learn more about Ziar'App",
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
                    secureStorage.add("access-token","");
                    await storage.deleteAll().then(
                            (value) => Get.offAll(() => const LoginPage()));

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
}

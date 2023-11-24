import 'package:arv/views/profile/profilemenuwidget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(onPressed: () => Navi, icon: const Icon(Icons.co_present)),
        title: Text("tProfile", style: Theme.of(context).textTheme.headline4),
        // actions: [IconButton(onPressed: () {}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:  EdgeInsets.all(10),
          child: Column(
            children: [

              /// -- IMAGE
              Stack(
                children: [
                  // SizedBox(
                  //   width: 120,
                  //   height: 120,
                  //   child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(100), child:  Image(image: AssetImage(tProfileImage))),
                  // ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.black),
                      child: const Icon(
                        Icons.ac_unit_sharp,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text("tProfileHeading", style: Theme.of(context).textTheme.headline4),
              Text("tProfileSubHeading", style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () =>null,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, side: BorderSide.none, shape: const StadiumBorder()),
                  child: const Text("tEditProfile", style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(title: "Settings", icon: Icons.ac_unit_sharp, onPress: () {}),
              ProfileMenuWidget(title: "Billing Details", icon: Icons.wallet, onPress: () {}),
              ProfileMenuWidget(title: "User Management", icon:Icons.verified_user, onPress: () {}),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(title: "Information", icon: Icons.info, onPress: () {}),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: Icons.logout,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {

                  }),
            ],
          ),
        ),
      ),
    );
  }
}
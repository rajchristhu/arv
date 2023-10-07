import 'package:arv/models/response_models/profile.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/views/authentication/login_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: FutureBuilder<Profile>(
              future: arvApi.getProfile(),
              builder: (context, snapshot) {
                Profile? profile = snapshot.data;
                if (profile == null) return Container();
                nameController.text = profile.profileName ?? "";
                return Container(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 100, right: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        width: 100,
                        height: 100,
                        child: CircleAvatar(
                          radius: 30,
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage: AssetImage(
                              'assets/images/icon_User.png',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: const [
                          Text(
                            "Name",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.face,
                            color: Colors.grey,
                            size: 28.0,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            profile.profileName ?? "",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: const [
                          Text(
                            "This name visible only the Attendance contacts",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Text(
                            "Phone Number",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: Colors.grey,
                            size: 28.0,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            profile.phone,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          FlutterSecureStorage storage = FlutterSecureStorage();
                          await storage.deleteAll().then(
                              (value) => Get.offAll(() => const LoginPage()));
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.logout,
                              color: Colors.grey,
                              size: 28.0,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Logout",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

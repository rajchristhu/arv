import 'package:arv/models/response_models/store_locations.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/utils/secure_storage.dart';
import 'package:arv/views/home_bottom_navigation_screen.dart';
import 'package:arv/views/order_page/input_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/app_const.dart';

class UserInfoForm extends StatefulWidget {
  const UserInfoForm({
    super.key,
  });

  @override
  State<UserInfoForm> createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {
  String? location;
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Wrap(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Enter Name",
                  style: TextStyle(
                    color: appColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.95,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                InputBox(
                  hintText: "Name",
                  isUsername: false,
                  labelText: "Enter Name",
                  textController: name,
                  isEnabled: true,
                ),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: Text(
                //     "Nearby City",
                //     style: TextStyle(
                //       color: appColor,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 18,
                //     ),
                //   ),
                // ),
                // FutureBuilder<List<Store>>(
                //   future: arvApi.getAvailableLocations(),
                //   builder: (context, snapshot) {
                //     List<Store> locations = snapshot.data ?? [];
                //     return Container(
                //       height: MediaQuery.of(context).size.height * 0.05,
                //       width: 220,
                //       decoration: BoxDecoration(
                //         border: Border.all(
                //           color: appColor,
                //           width: 1,
                //         ),
                //         borderRadius: const BorderRadius.all(
                //           Radius.circular(2.5),
                //         ),
                //       ),
                //       padding: const EdgeInsets.all(5),
                //       margin: const EdgeInsets.all(17.5),
                //       child: DropdownButtonHideUnderline(
                //         child: DropdownButton(
                //           isDense: true,
                //           isExpanded: false,
                //           hint: const Text(
                //             "Select",
                //             style: TextStyle(fontSize: 15.0),
                //           ),
                //           items: locations.map((place) {
                //             return DropdownMenuItem(
                //               value: place.id,
                //               child: Padding(
                //                 padding: const EdgeInsets.only(left: 0.0),
                //                 child: Text(
                //                   place.name,
                //                   style: const TextStyle(fontSize: 15.0),
                //                 ),
                //               ),
                //             );
                //           }).toList(),
                //           value: location,
                //           onChanged: (value) => setState(
                //             () => location = value,
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
            child: ElevatedButton(
              onPressed: () async {
                print("efg");
                print(name.text);

                if (name.text.isNotEmpty) {
                  arvApi.updateProfile(name.text).then((value) => {
                    print("dfdff"),
                    Navigator.pop(context)
                  });
                } else {}
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.purple,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.065,
                child: const Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NameUpdate extends StatefulWidget {
  const NameUpdate({
    super.key,
  });

  @override
  State<UserInfoForm> createState() => _NameUpdateState();
}

class _NameUpdateState extends State<UserInfoForm> {
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Wrap(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Verification success",
                  style: TextStyle(
                    color: appColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Icon(
                  Icons.verified_user,
                  color: appColor,
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.175,
            width: MediaQuery.of(context).size.width * 0.95,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                InputBox(
                  hintText: "Name",
                  isUsername: false,
                  labelText: "Enter Name",
                  textController: name,
                  isEnabled: true,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            child: ElevatedButton(
              onPressed: () async {
                print("efg");
                print(name.text);

                if (name.text.isNotEmpty) {
                   arvApi.updateProfile(name.text).then((value) => {
                     print("dfdff"),
                     Navigator.pop(context)
                   });
                } else {}
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.purple,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.065,
                child: const Center(
                  child: Text(
                    "Explore",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

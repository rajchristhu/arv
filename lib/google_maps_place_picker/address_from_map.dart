import 'package:arv/google_maps_place_picker/src/models/pick_result.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/views/map/pick_location.dart';
import 'package:arv/views/order_page/resources.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared/app_const.dart';
import '../utils/secure_storage.dart';
import '../views/home_bottom_navigation_screen.dart';
import '../views/widget/custom_buttom.dart';
import 'package:get/get.dart';



class AddressSelect extends StatefulWidget {
  AddressSelect(this.location, {super.key});

  PickResult? location;

  @override
  State<AddressSelect> createState() => _AddressSelectState();
}

class _AddressSelectState extends State<AddressSelect> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: gray,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                width: 70,
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Complete address : ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 20),
                    SizedOverflowBox(
                      alignment: Alignment.centerLeft,
                      size: Size(MediaQuery.of(context).size.width, 20),
                      child: Text(
                        "${widget.location == null ? "Fetching current location .... " : widget.location?.formattedAddress}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    const SizedBox(height: 10),
                    lineSeparator(context),
                    const SizedBox(height: 20),
                    Text(
                      "Landmark / Flat No : ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        textAlign: TextAlign.start,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          alignLabelWithHint: true,
                          label: Text('Landmark (optional)'),
                        ),
                        onChanged: (value) {
                          SelectedLocation.instance.landMark = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 0, vertical: 0),
                constraints: const BoxConstraints(maxWidth: 500),
                child: ElevatedButton(
                  onPressed: () {
                    SelectedLocation.instance.locationInfo = widget.location;
                    AppConstantsUtils.loc=widget.location?.formattedAddress??"";


                    Get.offAll(() =>  HomeBottomNavigationScreen(checkVal:true));

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
                        vertical: 14, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Confirm Location ',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              )

              // Container(
              //   decoration: BoxDecoration(
              //       borderRadius: const BorderRadius.all(
              //         Radius.circular(60),
              //       ),
              //       color: Resources(context).color.colorPrimary),
              //   width: MediaQuery.of(context).size.width,
              //   height: 45,
              //   child: CustomButton(
              //     'Confirm Location ',
              //     () {
              //       SelectedLocation.instance.locationInfo = widget.location;
              //       Navigator.maybePop(context);
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget lineSeparator(context) {
    return Container(
      height: 1.6,
      width: MediaQuery.of(context).size.width,
      color: gray50,
      padding: const EdgeInsets.only(right: 6, left: 6),
    );
  }
}

// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'package:arv/main.dart';
import 'package:arv/shared/availability_controller.dart';
import 'package:arv/shared/cart_service.dart';
import 'package:arv/shared/navigation_service.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/views/home_page/home_page.dart';
import 'package:arv/views/order_page/cart.dart';
import 'package:arv/views/order_page/order_page.dart';
import 'package:arv/views/widgets/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeBottomNavigationScreen extends StatefulWidget {
  const HomeBottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State createState() => _HomeBottomNavigationScreenState();
}

class _HomeBottomNavigationScreenState
    extends State<HomeBottomNavigationScreen> {
  @override
  void initState() {
    changeStatusColor(primaryColor);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
    Get.lazyPut(() => CartService());
  }

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight) / 3;
    final double itemWidth = size.width / 2;
    return GetBuilder<MainScreenController>(
      init: Get.find<MainScreenController>(),
      builder: (controller) {
        return ValueListenableBuilder<int>(
          valueListenable: navigationService.navigationValue,
          builder: (context, value, child) {
            int currentTab = value;
            return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: [0, 1, 6].contains(currentTab)
                  ? PreferredSize(
                      preferredSize: const Size.fromHeight(170),
                      child: Container(
                        height: 180,
                        width: MediaQuery.of(context).size.width,
                        padding:
                            const EdgeInsets.only(top: 25, right: 16, left: 16),
                        color: appColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // const Icon(
                                    //   Icons.location_on_outlined,
                                    //   size: 30,
                                    //   color: Colors.white,
                                    // ),
                                    Center(
                                      child: SvgPicture.asset(
                                        "assets/images/location.svg",
                                        semanticsLabel: 'Acme Logo',
                                        width: 25,
                                        height: 25,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: Text(
                                        controller.currentAddress,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/notification.svg",
                                      semanticsLabel: 'Acme Logo',
                                      width: 25,
                                      height: 25,
                                    ),
                                    const SizedBox(width: 6),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 7),
                            controller.storeName != ""
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      'Nearby Branch : ${controller.storeName}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.amberAccent,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  )
                                : Container(),
                            const SizedBox(height: 10),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(width: 6),

                                  SvgPicture.asset(
                                    "assets/images/search.svg",
                                    semanticsLabel: 'Acme Logo',
                                    color: gray,
                                    width: 20,
                                    height: 20,
                                  ),
                                  const SizedBox(width: 6),

                                  Expanded(
                                    child: TextField(
                                      controller: searchController,
                                      onChanged: (value) async {
                                        await Future.delayed(
                                            const Duration(seconds: 3));
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        hintText:
                                            'Search for Products and food',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              color: gray,
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.filter_list,
                                      color: gray,
                                    ),
                                    onPressed: () {},
                                  ),
                                  // UIHelper.horizontalSpaceMedium(),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    )
                  : currentTab == 2
                      ? PreferredSize(
                          preferredSize: const Size.fromHeight(80),
                          child: Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(
                                top: 25, right: 16, left: 16),
                            color: appColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const SizedBox(width: 8),
                                        Text(
                                          "My Order",
                                          style: GoogleFonts.poppins(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        )
                      : currentTab == 4
                          ? PreferredSize(
                              preferredSize: const Size.fromHeight(80),
                              child: Container(
                                height: 80,
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.only(
                                    top: 25, right: 16, left: 16),
                                color: appColor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const SizedBox(width: 8),
                                            Text(
                                              "Cart Page",
                                              style: GoogleFonts.poppins(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            )
                          : PreferredSize(
                              preferredSize: const Size.fromHeight(80),
                              child: Container(
                                height: 80,
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.only(
                                    top: 25, right: 16, left: 16),
                                color: appColor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            // const Icon(
                                            //   Icons.location_on_outlined,
                                            //   size: 30,
                                            //   color: Colors.white,
                                            // ),

                                            const SizedBox(width: 8),
                                            Text(
                                              "Profile",
                                              style: GoogleFonts.poppins(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
              body: !controller.isLocationAvailable
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/service-not-availabe.jpg",
                            fit: BoxFit.contain,
                            height: 300,
                            width: 300,
                          ),
                        ),
                        const Center(
                          child: Text(
                            "Service Not Available at your location!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    )
                  : currentTab == 4
                      ? const CartPage()
                      : currentTab == 2
                          ? const MyOrders()
                          : currentTab == 3
                              ? const ProfilePage()
                              : Stack(
                                  children: [
                                    Positioned(
                                      top: 0,
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: HomePage(
                                        itemWidth: itemWidth,
                                        itemHeight: itemHeight,
                                      ),
                                    ),
                                    Positioned(
                                      top: MediaQuery.of(context).size.height -
                                          (MediaQuery.of(context).size.height *
                                              0.40),
                                      bottom: 35,
                                      left: 10,
                                      right: 10,
                                      child: GetBuilder<CartService>(
                                        init: Get.find<CartService>(),
                                        builder: (controller) {
                                          if (controller.items.length == 0) {
                                            return Container();
                                          }
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: appColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            margin: const EdgeInsets.all(5),
                                            height: 20,
                                            width: 600,
                                            child: Center(
                                              child: SizedBox(
                                                height: 20,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Item ${controller.items.length} | ₹ ${controller.cartTotal.orderValue}",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    InkWell(
                                                      onTap: () =>
                                                          navigationService
                                                              .setNavigation = 4,
                                                      child: const Text(
                                                        "View cart",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color:
                                                              Colors.pinkAccent,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 20),
                                                    InkWell(
                                                      onTap: () =>
                                                          navigationService
                                                              .setNavigation = 4,
                                                      child: const Icon(
                                                        Icons.shopping_bag,
                                                        color:
                                                            Colors.pinkAccent,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                backgroundColor: pink,
                onPressed: () => navigationService.setNavigation = 4,
                child: SvgPicture.asset(
                  "assets/images/bag.svg",
                  semanticsLabel: 'Acme Logo',
                  color: Colors.white,
                  width: 28,
                  height: 28,
                ),
              ),
              bottomNavigationBar: buildBottomBar(),
            );
          },
        );
      },
    );
  }
}

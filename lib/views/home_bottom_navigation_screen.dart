// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'package:arv/main.dart';
import 'package:arv/models/response_models/products.dart';
import 'package:arv/shared/availability_controller.dart';
import 'package:arv/shared/cart_service.dart';
import 'package:arv/shared/navigation_service.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/utils/custom_progress_bar.dart';
import 'package:arv/views/home_page/home_page.dart';
import 'package:arv/views/order_page/cart.dart';
import 'package:arv/views/order_page/order_page.dart';
import 'package:arv/views/product_detail/product_detail.dart';
import 'package:arv/views/widgets/profilepage.dart';
import 'package:cached_network_image/src/cached_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared/app_const.dart';
import 'authentication/user_info_form.dart';
import 'map/maps_place_picker_page.dart';

class HomeBottomNavigationScreen extends StatefulWidget {
  bool checkVal;

  HomeBottomNavigationScreen({required this.checkVal});

  @override
  State createState() => _HomeBottomNavigationScreenState();
}

class _HomeBottomNavigationScreenState
    extends State<HomeBottomNavigationScreen> {
  String nae = "";

  @override
  void initState() {
    changeStatusColor(primaryColor);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
    getProfile();
    Get.lazyPut(() => CartService());
    Get.lazyPut(() => MainScreenController());
    nae = AppConstantsUtils.loc;
    subscribeNotification();
  }

  subscribeNotification() async {
    await arvApi.subscribeNotification();
  }

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    final double itemHeight = (size.height - kToolbarHeight) / 3;
    final double itemWidth = size.width / 2;
    // ArvProgressDialog.instance
    //     .showProgressDialog(context);
    return GetBuilder<MainScreenController>(
      init: Get.find<MainScreenController>(),
      builder: (controller) {
        // ArvProgressDialog.instance
        //     .dismissDialog(context);

        return ValueListenableBuilder<int>(
          valueListenable: navigationService.navigationValue,
          builder: (context, value, child) {
            ArvProgressDialog.instance.dismissDialog(context);
            int currentTab = widget.checkVal ? value : 4;
            widget.checkVal = true;
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
                                    InkWell(
                                      onTap: () {
                                        AppConstantsUtils.loc = "";
                                        AppConstantsUtils.lat = 0;
                                        AppConstantsUtils.long = 0;

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MapsPlacePicker(),
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        child: Text(
                                          nae == ""
                                              ? controller.currentAddress
                                              : nae.toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
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
                                        fontSize: 12.0,
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
                                        hintText: 'Search for Products ',
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
                                  // IconButton(
                                  //   icon: Icon(
                                  //     Icons.filter_list,
                                  //     color: gray,
                                  //   ),
                                  //   onPressed: () {},
                                  // ),
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
                          child: SvgPicture.asset(
                            "assets/images/ser.svg",
                            semanticsLabel: 'Acme Logo',
                            width: 300,
                            height: 300,
                            fit: BoxFit.contain,
                          ),
                        ),
                        // Center(
                        //   child: Text(
                        //     "Service Not Available at your location!",
                        //     style: TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: 16,
                        //       color: Colors.black,
                        //     ),
                        //     maxLines: 2,
                        //   ),
                        // ),
                      ],
                    )
                  : searchController.text.isNotEmpty
                      ? WillPopScope(
                          child: FutureBuilder<Products>(
                            future:
                                arvApi.searchProducts(0, searchController.text),
                            builder: (context, snapshot) {
                              Products products = snapshot.data!;
                              return Container(
                                padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.025,
                                ),
                                child: ListView.builder(
                                  itemCount: products.list.length,
                                  itemBuilder: (context, index) {
                                    ProductDto productDto =
                                        products.list[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.to(() => ProductDetailPageView(
                                            productId: productDto.id,
                                            checks: false));
                                      },
                                      child: Row(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: arvApi.getMediaUri(
                                                productDto.imageUri),
                                            width: 100,
                                            height: 100,
                                            placeholder: (context, url) =>
                                                Container(
                                              width: 100,
                                              height: 100,
                                              padding: const EdgeInsets.all(10),
                                              child: Center(
                                                child: Text(
                                                  "Loading ...",
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    color: gray,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              width: 100,
                                              height: 100,
                                              padding: const EdgeInsets.all(10),
                                              child: Center(
                                                child: Text(
                                                  "No image",
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    color: gray,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.7,
                                                child: Text(
                                                  productDto.productName!,
                                                  style: TextStyle(
                                                    color: black,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          onWillPop: () async {
                            searchController.clear();
                            setState(() {});
                            return false;
                          },
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
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              (MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.40),
                                          bottom: 35,
                                          left: 10,
                                          right: 10,
                                          child: GetBuilder<CartService>(
                                            init: Get.find<CartService>(),
                                            builder: (controller) {
                                              if (controller.items.length ==
                                                  0) {
                                                return Container();
                                              }
                                              return Container();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: keyboardIsOpened
                  ? null
                  : Stack(children: [
                      FloatingActionButton(
                        heroTag: null,
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
                      Positioned(
                        top: 0,
                        left: 30,
                        child: GetBuilder<CartService>(
                          init: Get.find<CartService>(),
                          builder: (controller) {
                            if (controller.items.length == 0) {
                              return Container();
                            }
                            return Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.white
                                    .withOpacity(0.25), // border color
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(2), // border width
                                child: Container(
                                  // or ClipRRect if you need to clip the content
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColor, // inner circle color
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${controller.items.length}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ), // inner content
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ]),
              bottomNavigationBar: buildBottomBar(),
            );
          },
        );
      },
    );
  }

  getProfile() {
    arvApi.getNameApi().then((value) => {
          if (value.profileName == "") {_showBottomSheet(context)}
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
        return const UserInfoForm();
      },
    );
  }
}

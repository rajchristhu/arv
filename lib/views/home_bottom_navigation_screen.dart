import 'package:arv/main.dart';
import 'package:arv/models/response_models/categories.dart';
import 'package:arv/shared/cart_service.dart';
import 'package:arv/shared/navigation_service.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/utils/distance-calculator.dart';
import 'package:arv/views/order_page/cart.dart';
import 'package:arv/views/order_page/order_page.dart';
import 'package:arv/views/widgets/banner_carousel_section.dart';
import 'package:arv/views/widgets/carousel_one/carousel_section_one.dart';
import 'package:arv/views/widgets/category/fixed_category_section.dart';
import 'package:arv/views/widgets/category_collections.dart';
import 'package:arv/views/widgets/dual_card_section.dart';
import 'package:arv/views/widgets/fixed_dashboard_banner.dart';
import 'package:arv/views/widgets/mini_banner.dart';
import 'package:arv/views/widgets/offer_products.dart';
import 'package:arv/views/widgets/profilepage.dart';
import 'package:arv/views/widgets/single_scroll_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'product_page/product_page.dart';

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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light); // 2
    _getCurrentLocation();
    super.initState();
    Get.lazyPut(() => CartService());
  }

  final Geolocator geoLocator = Geolocator()..forceAndroidLocationManager;
  Position? _currentPosition;
  String? _currentAddress;

  _getCurrentLocation() {
    geoLocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      //
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geoLocator.placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      Placemark place = p[0];
      distanceCalculator.setLatitude(_currentPosition!.latitude);
      distanceCalculator.setLongitude(_currentPosition!.longitude);
      await distanceCalculator.findNearByStore();
      setState(() {
        _currentAddress =
            "${place.name != null ? "${place.name} ," : ""}${place.subLocality != null ? "${place.subLocality} ," : ""}${place.locality} ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight) / 3;
    final double itemWidth = size.width / 2;
    return ValueListenableBuilder<int>(
      valueListenable: navigationService.navigationValue,
      builder: (context, value, child) {
        int currentTab = value;
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: currentTab == 0 || currentTab == 1
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: Text(
                                    _currentAddress.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/notification.svg",
                                  semanticsLabel: 'Acme Logo',
                                  width: 25,
                                  height: 25,
                                ),
                                // Icon(
                                //   Icons.notifications_none_outlined,
                                //   size: 30,
                                //   color: pink,
                                // ),
                                const SizedBox(width: 6),
                                // const Icon(
                                //   Icons.person_2_outlined,
                                //   size: 30,
                                //   color: Colors.white,
                                // ),
                              ],
                            ),
                          ],
                        ),
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
                              // IconButton(
                              //   icon: Icon(
                              //     Icons.search_outlined,
                              //     color: gray,
                              //   ),
                              //   onPressed: () {},
                              // ),
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
                                  decoration: InputDecoration(
                                    hintText: 'Search for Products and food',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    // const Icon(
                                    //   Icons.location_on_outlined,
                                    //   size: 30,
                                    //   color: Colors.white,
                                    // ),

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
                                        // const Icon(
                                        //   Icons.location_on_outlined,
                                        //   size: 30,
                                        //   color: Colors.white,
                                        // ),

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
          body: currentTab == 4
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
                          ],
                        ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton:Stack(
            children: [
          FloatingActionButton(
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
                    return   Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25), // border color
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(2), // border width
                        child: Container( // or ClipRRect if you need to clip the content
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor, // inner circle color
                          ),
                          child:
                          Center(child: Text(
                            "${controller.items.length}",
                            style: TextStyle(
                              fontSize: 12,
                              color: white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),), // inner content
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
  }

  ValueListenableBuilder<int> buildBottomBar() {
    return ValueListenableBuilder(
      valueListenable: navigationService.navigationValue,
      builder: (context, value, child) {
        int currentTab = value;
        return BottomAppBar(
          color: appColor,
          shape: const CircularNotchedRectangle(),
          notchMargin: 12,
          child: Container(
            height: 65,
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Material(
                  color: appColor,
                  child: Center(
                    child: InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () => navigationService.setNavigation = 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/home.svg",
                            semanticsLabel: 'Acme Logo',
                            color: currentTab == 0 ? pink : Colors.white,
                            width: 28,
                            height: 28,
                          ),

                          // Text("Home",
                          // style:GoogleFonts.poppins(
                          //   fontSize: 12.0,
                          //   fontWeight: FontWeight.bold,
                          //   color:currentTab==0?pink: Colors.white,
                          // )
                          // ),
                          //const Padding(padding: EdgeInsets.all(10))
                        ],
                      ),
                    ),
                  ),
                ),
                Material(
                  color: appColor,
                  child: Center(
                    child: InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => navigationService.setNavigation = 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon(
                          //   CupertinoIcons.rectangle_grid_2x2,
                          //   size: 28,
                          //   color: currentTab == 1 ? pink : Colors.white,
                          // ),
                          SvgPicture.asset(
                            "assets/images/category.svg",
                            semanticsLabel: 'Acme Logo',
                            color: currentTab == 1 ? pink : Colors.white,
                            width: 28,
                            height: 28,
                          ),
                          // Text("Category",style:GoogleFonts.poppins(
                          //   fontSize: 12.0,
                          //   fontWeight: FontWeight.bold,
                          //   color: Colors.white,
                          // )),
                          //const Padding(padding: EdgeInsets.only(left: 10))
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(),
                Material(
                  color: appColor,
                  child: Center(
                    child: InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => navigationService.setNavigation = 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.history_sharp,
                              size: 30,
                              color: currentTab == 2 ? pink : Colors.white,
                            ),
                            // Text("Grocery",style:GoogleFonts.poppins(
                            //   fontSize: 12.0,
                            //   fontWeight: FontWeight.bold,
                            //   color: Colors.white,
                            // )),
                            //const Padding(padding: EdgeInsets.only(right: 10))
                          ],
                        )),
                  ),
                ),
                Material(
                  color: appColor,
                  child: Center(
                    child: InkWell(
                      focusColor: appColor,
                      hoverColor: appColor,
                      highlightColor: appColor,
                      onTap: () => navigationService.setNavigation = 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(height: 10,),
                          // Icon(
                          //   CupertinoIcons.person,
                          //   size: 28,
                          //   color: currentTab == 3 ? pink : Colors.white,
                          // ),
                          SvgPicture.asset(
                            "assets/images/profile.svg",
                            semanticsLabel: 'Acme Logo',
                            color: currentTab == 3 ? pink : Colors.white,
                            width: 28,
                            height: 28,
                          ),
                          // Text("Profile",style:GoogleFonts.poppins(
                          //   fontSize: 12.0,
                          //   fontWeight: FontWeight.bold,
                          //   color: Colors.white,
                          // ))
                          //const Padding(padding: EdgeInsets.only(left: 10))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.itemWidth,
    required this.itemHeight,
  });

  final double itemWidth;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: navigationService.navigationValue,
      builder: (context, value, child) {
        int currentTab = value;
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  children: [
                    currentTab == 1 ? Container() : const MiniBanner(),
                    const SizedBox(height: 12),
                    Column(
                      children: [
                        currentTab == 1
                            ? Container()
                            : const CarouselSectionOne(),
                        currentTab == 1
                            ? Container()
                            : const SingleScrollList(
                                title: "Your Favourite Picks",
                                majorCategory: "Groceries",
                                isViewAll: true,
                                myCollection: false,
                                isRecentViews: false,
                                pageNumber: 1,
                              ),
                        currentTab == 1
                            ? Container()
                            : const SizedBox(
                                height: 12,
                              ),
                        currentTab == 1
                            ? Container()
                            : const FixedDashboardBanner(),
                        currentTab == 1
                            ? Container()
                            : const SizedBox(
                                height: 12,
                              ),
                        currentTab == 1 ? Container() : const DualCardSection(),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16, right: 16, left: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Explore By Category",
                                style: GoogleFonts.poppins(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const ProductsPage(
                                        true,
                                        false,
                                        0,
                                        null,
                                        null,
                                      ));
                                },
                                child: Text(
                                  "See All",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    color: pink,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const FixedCategorySection(),
                        CategoryCollections(
                          isAllCategories: currentTab == 1,
                          itemWidth: itemWidth,
                          itemHeight: itemHeight,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16, right: 16, left: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Explore New Categories",
                                style: GoogleFonts.poppins(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child: FutureBuilder<Categories>(
                            future: arvApi.getAllCategories(),
                            builder: (context, snapshot) {
                              List<Category> newCategories =
                                  snapshot.data?.list ?? [];
                              int l = newCategories.length;
                              return ListView.builder(
                                itemCount: l >= 4 ? 4 : l,
                                primary: false,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => ProductsPage(
                                            false,
                                            true,
                                            0,
                                            newCategories[index].id,
                                            null,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: index == 0 ? 16 : 0, right: 12),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12.0)),
                                        child: Stack(
                                          children: <Widget>[
                                            Image(
                                              image: NetworkImage(
                                                '${newCategories[index].image}',
                                              ),
                                              fit: BoxFit.fill,
                                              width: 110,
                                              height: 150,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Container(
                                                  color: gray50,
                                                  width: 120,
                                                  child: Center(
                                                    child: Text(
                                                      newCategories[index].name,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: black,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        currentTab == 1
                            ? Container()
                            : const SizedBox(height: 12),
                        currentTab == 1 ? Container() : const OfferProducts(),
                        currentTab == 1
                            ? Container()
                            : const SizedBox(height: 12),
                        currentTab == 1
                            ? Container()
                            : const BannerCarouselSection(),
                        currentTab == 1
                            ? Container()
                            : const SingleScrollList(
                                title: "Your Pleasure Essentials",
                                majorCategory: "Groceries",
                                isViewAll: true,
                                myCollection: false,
                                isRecentViews: false,
                                pageNumber: 2,
                              ),
                        currentTab == 1
                            ? Container()
                            : const SingleScrollList(
                                title: "Fashion",
                                majorCategory: "Fashion",
                                isViewAll: false,
                                myCollection: false,
                                isRecentViews: false,
                                pageNumber: 0,
                              ),
                        currentTab == 1
                            ? Container()
                            : const SingleScrollList(
                                title: "Fruits & Veg",
                                majorCategory: 'Vegetables',
                                isViewAll: false,
                                myCollection: false,
                                isRecentViews: false,
                                pageNumber: 0,
                              ),
                        currentTab == 1
                            ? Container()
                            : const SingleScrollList(
                                title: "Accessories",
                                majorCategory: "Fancy",
                                isViewAll: false,
                                myCollection: false,
                                isRecentViews: false,
                                pageNumber: 0,
                              ),
                        currentTab == 1
                            ? Container()
                            : const SingleScrollList(
                                title: "Recent Views",
                                majorCategory: "Fancy",
                                isViewAll: false,
                                myCollection: true,
                                isRecentViews: true,
                                pageNumber: 0,
                              ),
                        currentTab == 1
                            ? Container()
                            : const SingleScrollList(
                                title: "Wishlist",
                                majorCategory: "Fancy",
                                isViewAll: false,
                                myCollection: true,
                                isRecentViews: false,
                                pageNumber: 0,
                              ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

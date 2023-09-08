import 'dart:developer';

import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/secure_storage.dart';
import 'package:arv/views/widgets/banner_carousel_section.dart';
import 'package:arv/views/widgets/carousel_one/carousel_section_one.dart';
import 'package:arv/views/widgets/category/fixed_category_section.dart';
import 'package:arv/views/widgets/category_collections.dart';
import 'package:arv/views/widgets/dual_card_section.dart';
import 'package:arv/views/widgets/favourite_picks.dart';
import 'package:arv/views/widgets/fixed_dashboard_banner.dart';
import 'package:arv/views/widgets/mini_banner.dart';
import 'package:arv/views/widgets/offer_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'product_page/product_page.dart';

final List<String> imgList = [
  'assets/images/pp1.png.webp',
  'assets/images/pp2.png.webp',
  'assets/images/pp3.png.webp'
];
final List<String> imgLists = [
  'assets/images/tr.webp',
  'assets/images/tr1.webp',
  'assets/images/tr3.webp',
  'assets/images/tr4.webp',
  'assets/images/tr5.webp',
  'assets/images/tr6.webp',
  'assets/images/tr7.webp',
  'assets/images/tr8.webp',
  'assets/images/tr9.webp',
  'assets/images/tr10.webp',
  'assets/images/tr11.webp',
  'assets/images/tr12.webp',
];
final List<String> imgListss = [
  'assets/images/qw1.webp',
  'assets/images/qw2.webp',
];

final List<String> bnrList = [
  'assets/images/q1.png',
  'assets/images/q2.png',
  'assets/images/q3.png',
  'assets/images/q2.png',
];

class HomeBottomNavigationScreen extends StatefulWidget {
  const HomeBottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State createState() => _HomeBottomNavigationScreenState();
}

var currentTab = 0;

class _HomeBottomNavigationScreenState extends State<HomeBottomNavigationScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Future.delayed(const Duration(seconds: 5));
    String accessToken = await secureStorage.get("access-token");
    log("Login Success ============= >>> $accessToken");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight) / 3;
    final double itemWidth = size.width / 2;
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.white,
    //   statusBarBrightness: Brightness.dark,
    // ));
    final labelTextStyle =
        Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 8.0);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160),
        child: Container(
          height: 160,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 25, right: 16, left: 16),
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
                      const Icon(
                        Icons.location_on_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "Address",
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_none_outlined,
                        size: 30,
                        color: pink,
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        Icons.person_2_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
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
                    IconButton(
                      icon: Icon(
                        Icons.search_outlined,
                        color: gray,
                      ),
                      onPressed: () {},
                    ),

                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for Products and food',
                          hintStyle:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
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
      ),
      body: SingleChildScrollView(
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
                    currentTab == 1 ? Container() : const CarouselSectionOne(),
                    currentTab == 1
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                                top: 16, right: 16, left: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Your Favourite Picks",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    )),
                                InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductPage(false)));

                                  },
                                  child: Text("See All",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                        color: pink,
                                      )),
                                )

                              ],
                            ),
                          ),
                        currentTab == 1
                        ? Container()
                        : const SizedBox(
                            height: 12,
                          ),
                    currentTab == 1
                        ? Container()
                        : const FavouritePicks(pageNumber: 0),
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
                      padding:
                          const EdgeInsets.only(top: 16, right: 16, left: 16),
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
                          Text(
                            "See All",
                            style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: pink,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const FixedCategorySection(),
                    CategoryCollections(
                      itemWidth: itemWidth,
                      itemHeight: itemHeight,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, right: 16, left: 16),
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
                      child: ListView.builder(
                        itemCount: bnrList.length,
                        primary: false,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductPage(true)));

                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: index == 0 ? 16 : 0, right: 12),
                              child: ClipRRect(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(12.0)),
                                child: Stack(
                                  children: <Widget>[
                                    Image(
                                      image: AssetImage(
                                        bnrList[index],
                                      ),
                                      fit: BoxFit.fill,
                                      width: 110,
                                      height: 150,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                            ;
                        },
                      ),
                    ),
                    currentTab == 1 ? Container() : const SizedBox(height: 12),
                    currentTab == 1 ? Container() : const OfferProducts(),
                    currentTab == 1 ? Container() : const SizedBox(height: 12),
                    currentTab == 1
                        ? Container()
                        : const BannerCarouselSection(),
                    currentTab == 1
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(
                              top: 16,
                              right: 16,
                              left: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Your Pleasure Essentials",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    )),
                                Text("See All",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w400,
                                      color: pink,
                                    ))
                              ],
                            ),
                          ),
                    currentTab == 1 ? Container() : const SizedBox(height: 12),
                    currentTab == 1
                        ? Container()
                        : const FavouritePicks(pageNumber: 0),
                  ],
                )
              ],
            ),
          ),
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: pink,
        onPressed: () {},
        child: Icon(
          CupertinoIcons.cart,
          size: 28,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: appColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 65,
          padding: const EdgeInsets.only(top: 20),
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
                    onTap: () {
                      setState(() {
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.home,
                          size: 28,
                          color: currentTab == 0 ? pink : Colors.white,
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
                    onTap: () {
                      setState(() {
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.rectangle_grid_2x2,
                          size: 28,
                          color: currentTab == 1 ? pink : Colors.white,
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
              SizedBox(), //to make space for the floating button
              Material(
                color: appColor,
                child: Center(
                  child: InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.tray_2,
                            size: 28,
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
                    onTap: () {
                      setState(() {
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(height: 10,),
                        Icon(
                          CupertinoIcons.person,
                          size: 28,
                          color: currentTab == 3 ? pink : Colors.white,
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
      ),
    );
  }
}

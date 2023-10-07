import 'package:arv/models/response_models/categories.dart';
import 'package:arv/shared/cart_service.dart';
import 'package:arv/shared/navigation_service.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/views/order_page/cart.dart';
import 'package:arv/views/order_page/order_page.dart';
import 'package:arv/views/widgets/banner_carousel_section.dart';
import 'package:arv/views/widgets/carousel_one/carousel_section_one.dart';
import 'package:arv/views/widgets/category/fixed_category_section.dart';
import 'package:arv/views/widgets/category_collections.dart';
import 'package:arv/views/widgets/dual_card_section.dart';
import 'package:arv/views/widgets/favourite_picks.dart';
import 'package:arv/views/widgets/fixed_dashboard_banner.dart';
import 'package:arv/views/widgets/mini_banner.dart';
import 'package:arv/views/widgets/offer_products.dart';
import 'package:arv/views/widgets/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'product_page/product_page.dart';


class HomeBottomNavigationScreen extends StatefulWidget {
  const HomeBottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State createState() => _HomeBottomNavigationScreenState();
}

class _HomeBottomNavigationScreenState extends State<HomeBottomNavigationScreen> {

  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => CartService());
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
                  preferredSize: const Size.fromHeight(160),
                  child: Container(
                    height: 160,
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
                                SvgPicture.asset(
                                  "assets/images/location.svg",
                                  semanticsLabel: 'Acme Logo',
                                  width: 25,
                                  height: 25,
                                ),
                                const SizedBox(width: 8),
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
                            Positioned(
                              top: MediaQuery.of(context).size.height -
                                  (MediaQuery.of(context).size.height * 0.35),
                              bottom: 35,
                              left: 10,
                              right: 10,
                              child: GetBuilder<CartService>(
                                init: Get.find<CartService>(),
                                builder: (controller) {
                                  if(controller.items.length == 0) return Container();
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: appColor,
                                      borderRadius: const BorderRadius.all(
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
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Spacer(),
                                            InkWell(
                                              onTap: () => navigationService
                                                  .setNavigation = 4,
                                              child: const Text(
                                                "View cart",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.pinkAccent,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            InkWell(
                                              onTap: () => navigationService
                                                  .setNavigation = 4,
                                              child: const Icon(
                                                Icons.shopping_bag,
                                                color: Colors.pinkAccent,
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
                            : Padding(
                                padding: const EdgeInsets.only(
                                    top: 16, right: 16, left: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Your Favourite Picks",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(
                                          () => const ProductsPage(
                                            true,
                                            false,
                                            0,
                                            null,
                                            null,
                                          ),
                                        );
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
                            : Padding(
                                padding: const EdgeInsets.only(
                                  top: 16,
                                  right: 16,
                                  left: 16,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Your Pleasure Essentials",
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
                                            '64ff716ec78bc62fc17ef206',
                                            null));
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
                        currentTab == 1
                            ? Container()
                            : const SizedBox(height: 12),
                        currentTab == 1
                            ? Container()
                            : const FavouritePicks(pageNumber: 1),
                        currentTab == 1
                            ? Container()
                            : const UserFavourites(isRecentViews: true),
                        currentTab == 1
                            ? Container()
                            : const UserFavourites(isRecentViews: false),
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

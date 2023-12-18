import 'package:arv/models/response_models/categories.dart';
import 'package:arv/shared/navigation_service.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/views/product_page/product_page.dart';
import 'package:arv/views/widgets/banner_carousel_section.dart';
import 'package:arv/views/widgets/carousel_one/carousel_section_one.dart';
import 'package:arv/views/widgets/category/fixed_category_section.dart';
import 'package:arv/views/widgets/category_collections.dart';
import 'package:arv/views/widgets/dual_card_section.dart';
import 'package:arv/views/widgets/fixed_dashboard_banner.dart';
import 'package:arv/views/widgets/mini_banner.dart';
import 'package:arv/views/widgets/offer_products.dart';
import 'package:arv/views/widgets/single_scroll_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
                              // InkWell(
                              //   onTap: () {
                              //     Get.to(() => const ProductsPage(
                              //           true,
                              //           false,
                              //           0,
                              //           null,
                              //           null,
                              //         ));
                              //   },
                              //   child: Text(
                              //     "See All",
                              //     style: GoogleFonts.poppins(
                              //       fontSize: 18.0,
                              //       fontWeight: FontWeight.w400,
                              //       color: pink,
                              //     ),
                              //   ),
                              // ),
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
                                                arvApi.getMediaUri(
                                                    newCategories[index].id),
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
          padding: const EdgeInsets.only(top: 0),
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

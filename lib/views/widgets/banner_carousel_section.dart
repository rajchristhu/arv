import 'package:arv/models/response_models/home_banner.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/views/product_page/product_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';
import 'package:cached_network_image/src/cached_image_widget.dart';

class BannerCarouselSection extends StatelessWidget {
  const BannerCarouselSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HomeBanners>(
        future: arvApi.getAllHomeBanners("SECTION_2"),
        builder: (context, snapshot) {
          List<HomeBanner> banners =
              snapshot.data?.list ?? [];
          if (banners.isEmpty) return Container();
          return CarouselSlider(
            options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 4,
            enlargeCenterPage: false,
            autoPlayAnimationDuration: const Duration(seconds: 1),
          ),
          items: banners.map(
            (banner) {
              return InkWell(
                onTap: () {
                  String? majorCategory = ["Select Category", null, ""]
                          .contains(banner.majorCategory)
                      ? null
                      : banner.majorCategory;
                  String? subCategory = ["Select Sub Category", null, ""]
                          .contains(banner.majorCategory)
                      ? null
                      : banner.categoryId;
                  String? subSubCategory = ["Select Sub-Sub Category", null, ""]
                          .contains(banner.majorCategory)
                      ? null
                      : banner.subCategoryId;
                  Get.to(
                    () => ProductsPage(
                      false,
                      subCategory != "",
                      0,
                      subCategory,
                      subSubCategory,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    child: Stack(
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: arvApi.getMediaUri(banner.imageUri),
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,

                          placeholder: (context, url) => Container(
                            width: MediaQuery.of(context).size.width,

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
                          errorWidget: (context, url, error) =>Container(
                            width: MediaQuery.of(context).size.width,

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

                      ],
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
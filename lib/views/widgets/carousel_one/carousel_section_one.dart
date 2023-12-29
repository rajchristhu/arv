// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:arv/models/response_models/home_banner.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/views/product_page/product_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarouselSectionOne extends StatelessWidget {
  const CarouselSectionOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HomeBanners>(
      future: arvApi.getAllHomeBanners("SECTION_1"),
      builder: (context, snapshot) {
        List<HomeBanner> homeBanners = snapshot.data?.list ?? [];
        print("ejfnjnfjnef");
        print(homeBanners.length);
        if (homeBanners.isEmpty) return Container();
        return CarouselSlider(
          options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.35,
              enlargeCenterPage: false,
              autoPlayAnimationDuration: const Duration(seconds: 3)),
          items: homeBanners.map(
            (banner) {
              return InkWell(
                child: CarouselWidget(
                  imageUri: arvApi.getMediaUri(banner.imageUri),
                  onTap: () {},
                ),
                onTap: () {
                  log("Banner Image Section Touch");
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
              );
            },
          ).toList(),
        );
      },
    );
  }
}

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    super.key,
    required this.imageUri,
    required this.onTap,
  });

  final String imageUri;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        child: Stack(
          children: <Widget>[
            Image.network(
              imageUri,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: const Text(
                  '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

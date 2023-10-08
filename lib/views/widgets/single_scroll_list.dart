import 'package:arv/models/response_models/products.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/views/product_page/product_page.dart';
import 'package:arv/views/widgets/product_item_in_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleScrollList extends StatelessWidget {
  const SingleScrollList({
    super.key,
    required this.title,
    required this.majorCategory,
    required this.isViewAll,
    required this.myCollection,
    required this.isRecentViews,
    required this.pageNumber,
  });

  final String title;
  final String? majorCategory;
  final bool isViewAll;
  final bool myCollection;
  final bool isRecentViews;
  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Products>(
      future: myCollection
          ? arvApi.getRecentViews(isRecentViews)
          : arvApi.getAllProducts(
              pageNumber,
              majorCategory,
              null,
              null,
            ),
      builder: (context, snapshot) {
        List<ProductDto> productList = snapshot.data?.list ?? [];
        if (productList.isEmpty) return Container();
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                right: 16,
                left: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  isViewAll
                      ? InkWell(
                          onTap: () {
                            Get.to(
                              () => ProductsPage(
                                true,
                                false,
                                pageNumber,
                                null,
                                null,
                              ),
                            );
                          },
                          child: Text(
                            "See All",
                            style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: pink,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: productList.length,
                primary: false,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ProductItemInList(
                    product: productList[index],
                    index: index,
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}

import 'package:arv/models/response_models/categories.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/views/product_page/product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/src/cached_image_widget.dart';

class CategoryCollections extends StatelessWidget {
  const CategoryCollections({
    super.key,
    required this.itemWidth,
    required this.itemHeight,
    required this.isAllCategories,
  });

  final double itemWidth;
  final double itemHeight;
  final bool isAllCategories;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Categories>(
      future: isAllCategories
          ? arvApi.getAllCategoriesList()
          : arvApi.getAllCategories(),
      builder: (context, snapshot) {
        List<Category> categories = snapshot.data?.list ?? [];
        if (categories.isEmpty) return Container();
        return Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
          child: GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 8.0,
            childAspectRatio: (itemWidth / itemHeight),
            mainAxisSpacing: 10.0,
            children: List.generate(
              categories.length,
              (index) {
                return InkWell(
                  onTap: () {
                    Get.to(
                      () => ProductsPage(
                        false,
                        true,
                        0,
                        categories[index].id,
                        null,
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    child: Stack(
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: arvApi.getMediaUri(categories[index].id),
                          fit: BoxFit.fill,
                          width: 110,
                          height: 150,

                          placeholder: (context, url) => Container(
                            width: 110,
                            height: 150,
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
                            width: 110,
                            height: 150,
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
                        )

                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

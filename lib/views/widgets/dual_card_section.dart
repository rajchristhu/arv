import 'package:arv/models/response_models/home_banner.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/views/product_page/product_page.dart';
import 'package:cached_network_image/src/cached_image_widget.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class DualCardSection extends StatelessWidget {
  const DualCardSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HomeBanners>(
      future: arvApi.getAllHomeBanners("DUAL_CARD"),
      builder: (context, snapshot) {
        List<HomeBanner> banners = snapshot.data?.list ?? [];
        int length = banners.length;
        String? imageUri1;
        String? imageUri2;
        String? category1;
        String? category2;
        imageUri1 = getValue(imageUri1, banners, 0, true);
        imageUri2 = getValue(imageUri1, banners, 1, true);
        category1 = getValue(imageUri1, banners, 0, false);
        category2 = getValue(imageUri1, banners, 1, false);
        try {
          imageUri2 = length == 1 ? null : snapshot.data?.list[1].imageUri;
        } catch (e) {}
        return Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Row(
            children: [
              imageUri1 != null
                  ? Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductsPage(
                                true,
                                false,
                                0,
                                category1,
                                null,
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: SizedBox(
                            height: 110,
                            width: MediaQuery.of(context).size.width,
                            child: CachedNetworkImage(
                              imageUrl: arvApi.getMediaUri(imageUri1),
                              placeholder: (context, url) => Container(
                                height: 110,
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
                              errorWidget: (context, url, error) => Container(
                                height: 110,
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
                          ),
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(
                width: 10,
              ),
              imageUri2 != null
                  ? Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductsPage(
                                true,
                                false,
                                0,
                                category2,
                                null,
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: SizedBox(
                              height: 110,
                              width: MediaQuery.of(context).size.width,
                              child: CachedNetworkImage(
                                imageUrl: arvApi.getMediaUri(imageUri2),
                                fit: BoxFit.fill,
                                placeholder: (context, url) => Container(
                                  height: 110,
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
                                errorWidget: (context, url, error) => Container(
                                  height: 110,
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
                              )),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }

  String? getValue(
      String? value, List<HomeBanner> banners, int index, bool isImage) {
    if (isImage) {
      try {
        value = banners[index].imageUri;
      } catch (e) {}
      return value;
    } else {
      try {
        value = banners[index].categoryId;
      } catch (e) {}
      return value;
    }
  }
}

import 'package:arv/models/response_models/home_banner.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/views/product_page/product_page.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/src/cached_image_widget.dart';

import '../../utils/app_colors.dart';

class FixedDashboardBanner extends StatelessWidget {
  const FixedDashboardBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HomeBanners>(
      // future: arvApi.getAllHomeBanners("OFFER_BACKGROUND_BANNER"),
      future: arvApi.getAllHomeBanners("DASHBOARD_FIXED_CARD"),
      builder: (context, snapshot) {
        int length = snapshot.data?.list.length ?? 0;
        String? imageUri = length == 0 ? null : snapshot.data?.list[0].imageUri;
        return imageUri != null
            ? InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProductsPage(
                        false,
                        true,
                        1,
                        '64ff716ec78bc62fc17ef206',
                        null,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: SizedBox(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      child:  CachedNetworkImage(
                        imageUrl:  arvApi.getMediaUri(imageUri),

                        fit: BoxFit.fill,

                        placeholder: (context, url) => Container(
                          height: 180,
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
                          height: 180,
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



                    ),
                  ),
                ),
              )
            : Container();
      },
    );
  }
}

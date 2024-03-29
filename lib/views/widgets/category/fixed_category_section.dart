import 'package:arv/models/response_models/home_banner.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:cached_network_image/src/cached_image_widget.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class FixedCategorySection extends StatelessWidget {
  const FixedCategorySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
      child: FutureBuilder(
        future: arvApi.getAllHomeBanners("SECTION_2"),
        builder: (context, snapshot) {
          List<HomeBanner> banners = snapshot.data?.list ?? [];
          print("ffsfsfsf");
          print(banners.length);
          if (banners.isEmpty) return Container();
          return Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SizedBox(
                      height: 130,
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        imageUrl: arvApi.getMediaUri(banners[0].imageUri),
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Container(
                          height: 130,
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
                          height: 130,
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
              const SizedBox(width: 10),
              banners.length != 1
                  ? Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: SizedBox(
                            height: 130,
                            width: MediaQuery.of(context).size.width,
                            child: CachedNetworkImage(
                              imageUrl: arvApi.getMediaUri(banners.length > 1
                                  ? banners[1].imageUri
                                  : banners[0].imageUri),
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Container(
                                height: 130,
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
                                height: 130,
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
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }
}

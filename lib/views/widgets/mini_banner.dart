import 'package:arv/models/response_models/home_banner.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/src/cached_image_widget.dart';

import '../../utils/app_colors.dart';

class MiniBanner extends StatelessWidget {
  const MiniBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HomeBanners>(
      future: arvApi.getAllHomeBanners("TOP_MINI_BANNER"),
      builder: (context, snapshot) {
        int length = snapshot.data?.list.length ?? 0;
        String? imageUri = length == 0 ? null : snapshot.data?.list[0].imageUri;
        return imageUri != null
            ? CachedNetworkImage(
          imageUrl:       arvApi.getMediaUri(imageUri),
          fit: BoxFit.fill,

          height: 70,
          width: MediaQuery.of(context).size.width,

          placeholder: (context, url) => Container(
            height: 70,
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
            height: 70,
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
        )


            : Container();
      },
    );
  }
}

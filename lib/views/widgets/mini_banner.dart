import 'package:arv/models/response_models/home_banner.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:flutter/material.dart';

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
        String? imageUri = length == 0
            ? "assets/images/rect1.jpg"
            : snapshot.data?.list[0].imageUri;
        return imageUri != null
            ? Image.network(
                arvApi.getMediaUri(imageUri),
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
              )
            : Image.asset("assets/images/rect1.jpg");
      },
    );
  }
}

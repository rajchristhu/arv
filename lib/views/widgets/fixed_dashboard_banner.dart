import 'package:arv/models/response_models/home_banner.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:flutter/material.dart';

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
        String? imageUri = length == 0
            ? "assets/images/rect1.jpg"
            : snapshot.data?.list[0].imageUri;
        return Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SizedBox(
              height: 180,
              width: MediaQuery.of(context).size.width,
              child: imageUri != null
                  ? Image.network(
                      arvApi.getMediaUri(imageUri),
                      fit: BoxFit.fill,
                    )
                  : const Image(
                      image: AssetImage("assets/images/rect2.png"),
                      fit: BoxFit.fill,
                    ),
            ),
          ),
        );
      },
    );
  }
}

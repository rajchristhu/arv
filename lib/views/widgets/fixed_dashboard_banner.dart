import 'package:arv/models/response_models/home_banner.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/views/product_page/product_page.dart';
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
        String? imageUri = length == 0 ? null : snapshot.data?.list[0].imageUri;
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProductsPage(
                      true,
                      1,
                      null,
                      '64ff716ec78bc62fc17ef206',
                      null,
                    )));
          },
          child: Padding(
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
          ),
        );
      },
    );
  }
}

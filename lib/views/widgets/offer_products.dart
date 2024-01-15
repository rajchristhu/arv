import 'package:arv/models/response_models/home_banner.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/views/widgets/products_in_offer_section.dart';
import 'package:flutter/material.dart';

class OfferProducts extends StatelessWidget {
  const OfferProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HomeBanners>(
      future: arvApi.getAllHomeBanners("OFFER_BACKGROUND_BANNER"),
      builder: (context, snapshot) {
        return Container(
          height: 220,
          color:appColor,
          child: Row(
            children: const [
              Center(
                child: ProductsInOfferSection(),
              )
            ],
          ),
        );
      },
    );
  }
}

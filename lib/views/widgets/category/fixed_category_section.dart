import 'package:arv/models/response_models/home_banner.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:flutter/material.dart';

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
          if (banners.isEmpty) return Container();
          return Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SizedBox(
                    height: 130,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      arvApi.getMediaUri(banners[0].imageUri),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SizedBox(
                    height: 130,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      arvApi.getMediaUri(banners[1].imageUri),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

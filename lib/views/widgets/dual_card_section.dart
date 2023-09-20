import 'package:arv/models/response_models/home_banner.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/views/product_page/product_page.dart';
import 'package:flutter/material.dart';

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
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductsPage(
                          true,
                          0,
                          null,
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
                      child: imageUri1 != null
                          ? Image.network(
                              arvApi.getMediaUri(imageUri1),
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
                              "assets/images/rect3.png",
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductsPage(
                          true,
                          0,
                          null,
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
                      child: imageUri2 != null
                          ? Image.network(
                              arvApi.getMediaUri(imageUri2),
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
                              "assets/images/rect3.png",
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                ),
              ),
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

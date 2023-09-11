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
        int length = snapshot.data?.list.length ?? 0;
        String? imageUri1 =
            length == 0 ? null : snapshot.data?.list[0].imageUri;
        String? imageUri2 =
            length == 1 ? null : snapshot.data?.list[1].imageUri;
        return Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProductsPage(
                            true, '64ff7289c78bc62fc17ef212', 0),
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
                        builder: (context) => const ProductsPage(
                            true, '64ff72cbc78bc62fc17ef216', 0),
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
}

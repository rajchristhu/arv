import 'package:arv/models/response_models/home_banner.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:flutter/material.dart';

class CategoryCollections extends StatelessWidget {
  const CategoryCollections({
    super.key,
    required this.itemWidth,
    required this.itemHeight,
  });

  final double itemWidth;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HomeBanners>(
      future: arvApi.getAllHomeBanners("SECTION_3"),
      builder: (context, snapshot) {
        List<HomeBanner> banners = snapshot.data?.list ?? [];
        if (banners.isEmpty) return Container();
        return Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
          child: GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 8.0,
            childAspectRatio: (itemWidth / itemHeight),
            mainAxisSpacing: 10.0,
            children: List.generate(
              banners.length,
              (index) {
                return ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        arvApi.getMediaUri(banners[index].imageUri),
                        fit: BoxFit.fill,
                        width: 110,
                        height: 150,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/images/no-image.png");
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

import 'package:arv/models/response_models/products.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/views/widgets/product_item_in_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouritePicks extends StatelessWidget {
  const FavouritePicks({
    super.key,
    required this.pageNumber,
  });

  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Products>(
      future: arvApi.getAllProducts(pageNumber, null, null, null),
      builder: (context, snapshot) {
        List<ProductDto> productList = snapshot.data?.list ?? [];
        if (productList.isEmpty) return Container();
        return SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: productList.length,
            primary: false,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ProductItemInList(
                product: productList[index],
                index: index,
              );
            },
          ),
        );
      },
    );
  }
}

class UserFavourites extends StatelessWidget {
  const UserFavourites({
    super.key,
    required this.isRecentViews,
  });

  final bool isRecentViews;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Products>(
      future: arvApi.getRecentViews(isRecentViews),
      builder: (context, snapshot) {
        List<ProductDto> productList = snapshot.data?.list ?? [];
        if (productList.isEmpty) return Container();
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                right: 16,
                left: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isRecentViews ? "Recent Views" : "Favourites",
                    style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: productList.length,
                primary: false,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ProductItemInList(
                    product: productList[index],
                    index: index,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

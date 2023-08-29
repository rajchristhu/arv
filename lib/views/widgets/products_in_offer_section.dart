import 'package:arv/models/response_models/products.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductsInOfferSection extends StatelessWidget {
  const ProductsInOfferSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Products>(
      future: arvApi.getAllProducts(1),
      builder: (context, snapshot) {
        List<Product> products = snapshot.data?.list ?? [];
        return SizedBox(
          height: 180,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: products.length,
            primary: false,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? 100 : 0, right: 12),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  child: Container(
                    width: 125,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          arvApi.getMediaUri(products[index].imageUri ?? ""),
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Text(
                          "   ${products[index].productName}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "   ${products[index].productVariation!.isEmpty ? "" : products[index].productVariation![0]}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "   ${products[index].mrpPrice![0]}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "   ${products[index].sellingPrice![0]}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(width: 1.0, color: pink!),
                                ),
                                child: Text(
                                  'Add',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300,
                                    color: pink,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

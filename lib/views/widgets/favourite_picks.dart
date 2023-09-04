import 'package:arv/models/response_models/products.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
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
      future: arvApi.getAllProducts(pageNumber),
      builder: (context, snapshot) {
        List<Product> productList = snapshot.data?.list ?? [];
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
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: lightpink),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin: EdgeInsets.only(left: index == 0 ? 16 : 0, right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  child: Container(
                    width: 140,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          arvApi.getMediaUri(productList[index].imageUri ?? ""),
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "   ${productList[index].productName ?? ""}",
                          style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                            "   ${productList[index].productVariation!.isEmpty ? "" : productList[index].productVariation![0]}",
                            style: GoogleFonts.poppins(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("   ${productList[index].mrpPrice!.isEmpty ? "" : productList[index].mrpPrice![0]}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                    )),
                                Text("   100rs",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: OutlinedButton(
                                onPressed: () {},
                                child: Text('Add',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                      color: pink,
                                    )),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(width: 1.0, color: pink!),
                                ),
                              ),
                            )
                          ],
                        ),
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

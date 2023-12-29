import 'dart:developer';

import 'package:arv/models/request/cart.dart';
import 'package:arv/models/response_models/products.dart';
import 'package:arv/shared/cart_service.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/utils/custom_progress_bar.dart';
import 'package:arv/views/product_detail/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductGridCard extends StatefulWidget {
  const ProductGridCard({super.key, required this.product});

  final ProductDto product;

  @override
  State<StatefulWidget> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGridCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      initialData: 0,
      future: arvApi.getCartCountById(
          widget.product.id, widget.product.productVariation![0]),
      builder: (context, snapshot) {
        int count = snapshot.data ?? 0;
        int quantity =
            widget.product.stock!.isNotEmpty ? widget.product.stock![0] : 0;
        String productId = widget.product.id;
        String productVariant = widget.product.productVariation![0];
        double price = widget.product.sellingPrice![0];

        return InkWell(
          onTap: () {
            Get.to(() => ProductDetailPageView(productId: productId));
          },
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: lightpink),
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  width: 140,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                          child: Image.network(
                        arvApi.getMediaUri(widget.product.imageUri ?? ""),
                        height: 50,
                        width: double.infinity,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 50,
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                "No image",
                                style: TextStyle(
                                  fontSize: 8,
                                  color: gray,
                                ),
                              ),
                            ),
                          );
                        },
                      )),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0),
                              // Add padding to text
                              child: Text(
                                widget.product.productName ?? "",
                                style: GoogleFonts.poppins(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0, top: 0),
                              // Add padding
                              child: Text(
                                widget.product.productSubCategory.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 8.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${widget.product.mrpPrice!.isNotEmpty ? widget.product.mrpPrice![0].toInt() : ""} ₹",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14.0,
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "${widget.product.sellingPrice!.isNotEmpty ? widget.product.sellingPrice![0].toInt() : ""} ₹",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            widget.product.isEnabled
                                ? Container(
                                    width: 1000000,
                                    height: 32,
                                    padding:
                                        const EdgeInsets.only(right: 0, top: 5),
                                    child: count == 0
                                        ? OutlinedButton(
                                            onPressed: () async {
                                              await performCartOperation(
                                                true,
                                                quantity,
                                                count,
                                                productId,
                                                productVariant,
                                                price,
                                              );
                                            },
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                  width: 1.0, color: pink),
                                            ),
                                            child: Text(
                                              'Add',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w300,
                                                color: pink,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            width: 10000,
                                            height: 32,
                                            margin: const EdgeInsets.only(
                                                right: 0, top: 5),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1.0,
                                                color: pink,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                    child: Icon(
                                                      Icons.remove,
                                                      size: 16,
                                                      color: gray,
                                                    ),
                                                    onTap: () async {
                                                      await performCartOperation(
                                                        false,
                                                        quantity,
                                                        count,
                                                        productId,
                                                        productVariant,
                                                        price,
                                                      );
                                                    }),
                                                Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(
                                                    '$count',
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 16,
                                                    color: gray,
                                                  ),
                                                  onTap: () async {
                                                    await performCartOperation(
                                                      true,
                                                      quantity,
                                                      count,
                                                      productId,
                                                      productVariant,
                                                      price,
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> performCartOperation(bool isInc, int quantity, int count,
      String productId, String productVariant, double price) async {
    ArvProgressDialog.instance.showProgressDialog(context);

    log("Cart Added");
    if (quantity == 0 ||
        (count == 0 && !isInc) ||
        (count == quantity && isInc)) {
      return;
    }
    count = (count < quantity && isInc) ? count + 1 : count - 1;
    if (count == 0) {
      arvApi.deleteCartItem(productId, productVariant);
    } else {
      await arvApi.addToCart(
        Cart(
          productId: productId,
          variant: productVariant,
          qty: count,
          orderPrice: price,
        ),
      );
    }

    await Get.find<CartService>().updateList();
    setState(() {
      ArvProgressDialog.instance.dismissDialog(context);
    });
  }
}

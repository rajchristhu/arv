import 'package:arv/models/request/cart.dart';
import 'package:arv/models/response_models/products.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

class ProductInOfferList extends StatefulWidget {
  const ProductInOfferList({
    super.key,
    required this.product,
    required this.index,
  });

  final Product product;
  final int index;

  @override
  State<ProductInOfferList> createState() => _ProductInOfferListState();
}

class _ProductInOfferListState extends State<ProductInOfferList> {
  int count = 0;
  int quantity = 0;
  String productId = "";
  String productVariant = "";

  @override
  void initState() {
    super.initState();
    quantity = (widget.product.stock != null &&
            (widget.product.stock?.length ?? 0) > 0)
        ? widget.product.stock![0]
        : 0;
    productId = widget.product.id;
    try {
      productVariant = widget.product.productVariation![0];
    } catch (e) {
      productVariant = "";
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: widget.index == 0 ? 100 : 0, right: 12),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        child: Container(
          width: 125,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                arvApi.getMediaUri(widget.product.imageUri ?? ""),
                height: 90,
                width: MediaQuery.of(context).size.width,
              ),
              Text(
                "   ${widget.product.productName}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "   ${widget.product.productVariation!.isEmpty ? "" : widget.product.productVariation![0]}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "   ${widget.product.mrpPrice!.isEmpty ? "" : widget.product.mrpPrice![0]}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "   ${widget.product.sellingPrice!.isEmpty ? "" : widget.product.sellingPrice![0]}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: count == 0
                        ? OutlinedButton(
                            onPressed: () async =>
                                await performCartOperation(true),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(width: 1.0, color: pink),
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
                            width: 62.5,
                            height: 35,
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                                color: pink,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Icon(
                                    Icons.remove,
                                    size: 16,
                                    color: gray,
                                  ),
                                  onTap: () async =>
                                      await performCartOperation(false),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    '$count',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  child: Icon(
                                    Icons.add,
                                    size: 16,
                                    color: gray,
                                  ),
                                  onTap: () async =>
                                      await performCartOperation(true),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> performCartOperation(bool isInc) async {
    if (quantity == 0 ||
        (count == 0 && !isInc) ||
        (count == quantity && isInc)) {
      return;
    }
    count = (count < quantity && isInc) ? count + 1 : count - 1;
    if (count == 0) {
      arvApi.deleteCartItem(productId);
    } else {
      await arvApi.addToCart(
        Cart(
          productId: productId,
          variant: productId,
          qty: count,
        ),
      );
    }

    setState(() {});
  }
}

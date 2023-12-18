import 'package:arv/models/request/cart.dart';
import 'package:arv/models/response_models/products.dart';
import 'package:arv/shared/cart_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/utils/custom_progress_bar.dart';
import 'package:arv/views/product_detail/product_detail.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

class ProductItemInList extends StatefulWidget {
  const ProductItemInList({
    super.key,
    required this.product,
    required this.index,
  });

  final ProductDto product;
  final int index;

  @override
  State<ProductItemInList> createState() => _ProductItemInListState();
}

class _ProductItemInListState extends State<ProductItemInList> {
  int count = 0;
  int quantity = 0;
  String productId = "";
  String productVariant = "";
  double price = 0.0;

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
      price = widget.product.sellingPrice![0];
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
    return FutureBuilder<int>(
      initialData: 0,
      future: arvApi.getCartCountById(widget.product.id, productVariant),
      builder: (context, snapshot) {
        count = snapshot.data ?? 0;
        return InkWell(
          onTap: () {
            Get.to(() => ProductDetailPageView(productId: widget.product.id));
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: lightpink),
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin:
                EdgeInsets.only(left: widget.index == 0 ? 16 : 0, right: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                width: 140,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      arvApi.getMediaUri(widget.product.id),
                      height: 80,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Container(
                          color: white,
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: Text("No Image"),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
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
                      padding: const EdgeInsets.only(left: 8, top: 4),
                      // Add padding
                      child: Text(
                        widget.product.productVariation!.isEmpty
                            ? ""
                            : widget.product.productVariation![0],
                        style: GoogleFonts.poppins(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // Align text
                          children: [
                            Text(
                              "${widget.product.mrpPrice!.isEmpty ? '' : (widget.product.mrpPrice![0]).toInt()} ₹",
                              style: GoogleFonts.montserrat(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "${widget.product.sellingPrice!.isEmpty ? '' : (widget.product.sellingPrice![0]).toInt()} ₹",
                              style: GoogleFonts.montserrat(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        widget.product.isEnabled
                            ? Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: count == 0
                                    ? OutlinedButton(
                                        onPressed: () async =>
                                            await performCartOperation(true),
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
                                        width: 75,
                                        height: 35,
                                        margin: const EdgeInsets.all(8),
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
                                              onTap: () async =>
                                                  await performCartOperation(
                                                      false),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                  await performCartOperation(
                                                      true),
                                            ),
                                          ],
                                        ),
                                      ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> performCartOperation(bool isInc) async {
    ArvProgressDialog.instance.showProgressDialog(context);

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
    ArvProgressDialog.instance.dismissDialog(context);

    setState(() {});
  }
}

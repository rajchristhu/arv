import 'package:arv/models/response_models/cart_list.dart';
import 'package:arv/shared/cart_service.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:arv/utils/custom_progress_bar.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:cached_network_image/src/cached_image_widget.dart';

import '../product_detail/product_detail.dart';

class CartListItems extends StatefulWidget {
  const CartListItems({Key? key}) : super(key: key);

  @override
  State createState() => _CartListItemsState();
}

class _CartListItemsState extends State<CartListItems> {
  @override
  Widget build(BuildContext context) {
    ArvProgressDialog.instance.showProgressDialog(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 16, left: 16,top: 30),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: Text(
                    "Cart Products ",
                    style: TextStyle(
                        color: black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: 50.0,
                  height: 1,
                  margin: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(18)),
                      shape: BoxShape.rectangle,
                      color: (appColor)
                      // .withOpacity(_current == entry.key ? 0.9 : 0.1)
                      ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          child: FutureBuilder<CartList>(
            future: arvApi.getCartItems(0),
            builder: (context, snapshot) {
              CartList? cartList = snapshot.data;
              ArvProgressDialog.instance.dismissDialog(context);
              if (cartList == null || cartList.list.isEmpty) {
                return const Center(
                  child: Text("No products to show"),
                );
              }
print("nfjnd jndjf");
print( cartList.list.length);
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: cartList.list.length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = cartList.list[index];
                  int currentVariantIndex = product.productVariation
                          ?.indexOf(product.orderProductVariation!) ??
                      0;
                  double price = -1;
                  try {
                    price = product.sellingPrice![currentVariantIndex];
                  } catch (e) {
                    price = 0;
                  }
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            bottom: 16, left: 16, right: 16),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => ProductDetailPageView(
                              productId: product.id,
                            ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 0,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12.0),
                                      topRight: Radius.circular(2.0),
                                      bottomLeft: Radius.circular(2.0),
                                      bottomRight: Radius.circular(12.0)),
                                  child: CachedNetworkImage(
                                    imageUrl: arvApi.getMediaUri(product.id),
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50,
                                    placeholder: (context, url) => Container(
                                      width: 50,
                                      height: 50,
                                      padding: const EdgeInsets.all(10),
                                      child: Center(
                                        child: Text(
                                          "Loading ...",
                                          style: TextStyle(
                                            fontSize: 8,
                                            color: gray,
                                          ),
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>Container(
                                      width: 50,
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
                                    ),
                                  )


                                ),
                              ),
                              const SizedBox(
                                width: 18,
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              product.productName,
                                              style: TextStyle(
                                                color: black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () async {
                                              await arvApi.deleteCartItem(
                                                product.id,
                                                product.orderProductVariation,
                                              );
                                              await Get.find<CartService>()
                                                  .updateList();
                                              setState(() {});
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.grey,
                                              size: 26,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${product.orderProductVariation} x ${product.orderQty}",
                                            style: TextStyle(
                                              color: black,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            price == -1
                                                ? "Out of stock"
                                                : "₹ ${price * product.orderQty!}",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.montserrat(
                                                color: black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      // const SizedBox(
                                      //   height: 3,
                                      // ),
                                      // Text(
                                      //   "Address",
                                      //   maxLines: 2,
                                      //   overflow: TextOverflow.ellipsis,
                                      //   style: TextStyle(
                                      //       color: black,
                                      //       fontSize: 12,
                                      //       fontWeight: FontWeight.w500),
                                      // ),
                                      // const SizedBox(
                                      //   height: 3,
                                      // ),
                                      // Text(
                                      //   "Landmark",
                                      //   maxLines: 2,
                                      //   overflow: TextOverflow.ellipsis,
                                      //   style: TextStyle(
                                      //       color: black,
                                      //       fontSize: 12,
                                      //       fontWeight: FontWeight.w500),
                                      // ),
                                      const SizedBox(height: 12),
                                      Container(
                                        height: 1.6,
                                        color: gray50,
                                        padding: const EdgeInsets.only(
                                          right: 6,
                                          left: 6,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

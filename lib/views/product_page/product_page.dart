import 'dart:developer';

import 'package:arv/models/request/cart.dart';
import 'package:arv/models/response_models/categories.dart';
import 'package:arv/models/response_models/products.dart';
import 'package:arv/shared/cart_service.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

final List<String> imgList = [
  'assets/images/pp1.png.webp',
  'assets/images/pp2.png.webp',
  'assets/images/pp3.png.webp'
];
final List<String> imgLists = [
  'assets/images/tr.webp',
  'assets/images/tr1.webp',
  'assets/images/tr3.webp',
  'assets/images/tr4.webp',
  'assets/images/tr5.webp',
  'assets/images/tr6.webp',
  'assets/images/tr7.webp',
  'assets/images/tr8.webp',
  'assets/images/tr9.webp',
  'assets/images/tr10.webp',
  'assets/images/tr11.webp',
  'assets/images/tr12.webp',
];
final List<String> imgListss = [
  'assets/images/qw1.webp',
  'assets/images/qw2.webp',
];

final List<String> bnrList = [
  'assets/images/q1.png',
  'assets/images/q2.png',
  'assets/images/q3.png',
  'assets/images/q2.png',
];

class ProductsPage extends StatefulWidget {
  final bool isCategoryPage;

  const ProductsPage(this.isCategoryPage, {super.key});

  @override
  State createState() => _ProductsPageState();
}

var currentTab = 0;

class _ProductsPageState extends State<ProductsPage> {
  int selectedIndex = 0;
  int indexVal = 0;
  String selectedCategory = "";
  Products products =
      Products(list: [], currentPage: 0, totalCount: 0, totalPages: 0);

  getProductsByCategory() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      products = await arvApi.getAllProducts(0);
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getProductsByCategory();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight) / 3;
    final double itemWidth = size.width / 2;
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.white,
    //   statusBarBrightness: Brightness.dark,
    // ));
    final labelTextStyle =
        Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 8.0);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: const Center(
            child: Text(
              "Product Page",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: Row(
          children: [
            !widget.isCategoryPage
                ? Container(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: lightpink),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 100,
                          height: MediaQuery.of(context).size.height * 0.85,
                          child: FutureBuilder<Categories>(
                            future: arvApi.getAllCategories(),
                            builder: (context, snapshot) {
                              Categories? categories = snapshot.data;
                              if (categories == null) return Container();
                              return ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: categories.list.length,
                                primary: false,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  Category category = categories.list[index];
                                  if (selectedCategory == "") {
                                    selectedCategory = category.id;
                                  }
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        indexVal = index;
                                        getProductsByCategory();
                                      });
                                    },
                                    child: Container(
                                      color: indexVal == index
                                          ? pink
                                          : Colors.white,
                                      height: 100,
                                      padding: const EdgeInsets.only(
                                          bottom: 20, top: 10),
                                      margin: const EdgeInsets.only(left: 10),
                                      width: 50,
                                      child: Image.network(
                                        arvApi
                                            .getMediaUri(category.image ?? ""),
                                        width: 50,
                                        height: 50,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Center(
                                            child: Text(
                                              "No image",
                                              style: TextStyle(
                                                color: gray,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                : Container(),
            Container(
              width: widget.isCategoryPage
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width - 120,
              padding: const EdgeInsets.only(top: 10),
              child: GridView.count(
                crossAxisCount: !widget.isCategoryPage ? 2 : 3,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 8.0,
                children: List.generate(
                  products.list.length,
                  (index) {
                    Product product = products.list[index];
                    return GetBuilder<CartService>(
                      init: Get.find<CartService>(),
                      builder: (controller) {
                        int count = controller.isPresentInCart(product.id);
                        int quantity =
                            product.stock!.isNotEmpty ? product.stock![0] : 0;
                        String productId = product.id;
                        String productVariant = product.productVariation![0];
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: lightpink),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: const EdgeInsets.only(left: 16, right: 12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Container(
                                width: 140,
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      arvApi
                                          .getMediaUri(product.imageUri ?? ""),
                                      height: 34,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                          child: Text(
                                            "No image",
                                            style: TextStyle(
                                              color: gray,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      // Add padding to text
                                      child: Text(
                                        product.productName ?? "",
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
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 4),
                                      // Add padding
                                      child: Text(
                                        product.productCategory?.name ?? "",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start, // Align text
                                          children: [
                                            Text(
                                              "${product.mrpPrice!.isNotEmpty ? product.mrpPrice![0].toInt() : ""} rs",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              "${product.sellingPrice!.isNotEmpty ? product.sellingPrice![0].toInt() : ""} rs",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: count == 0
                                              ? OutlinedButton(
                                                  onPressed: () async {
                                                    await performCartOperation(
                                                      true,
                                                      quantity,
                                                      count,
                                                      productId,
                                                      productVariant,
                                                    );
                                                  },
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    side: BorderSide(
                                                        width: 1.0,
                                                        color: pink),
                                                  ),
                                                  child: Text(
                                                    'Add',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: pink,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  width: 75,
                                                  height: 35,
                                                  margin:
                                                      const EdgeInsets.all(8),
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
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      InkWell(
                                                          child: Icon(
                                                            Icons.remove,
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
                                                            );
                                                          }),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Text(
                                                          '$count',
                                                          style:
                                                              const TextStyle(
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
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                        ),
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
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> performCartOperation(bool isInc, int quantity, int count,
      String productId, String productVariant) async {
    log("Cart Added");
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
          variant: productVariant,
          qty: count,
        ),
      );
    }
    await Get.find<CartService>().updateList();

    setState(() {});
  }
}

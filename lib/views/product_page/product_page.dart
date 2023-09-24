import 'dart:developer';

import 'package:arv/models/request/cart.dart';
import 'package:arv/models/response_models/categories.dart';
import 'package:arv/models/response_models/products.dart';
import 'package:arv/models/response_models/sub_categories.dart';
import 'package:arv/shared/cart_service.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/utils/custom_progress_bar.dart';
import 'package:arv/views/product_detail/product_detail.dart';
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
  final bool isExploreAll;
  final bool isCategoryPage;
  final String? majorCategory;
  final String? category;
  final String? subSubCategory;
  final int currentPage;

  const ProductsPage(
    this.isExploreAll,
    this.isCategoryPage,
    this.currentPage,
    this.majorCategory,
    this.category,
    this.subSubCategory, {
    super.key,
  });

  @override
  State createState() => _ProductsPageState();
}

var currentTab = 0;

class _ProductsPageState extends State<ProductsPage> {
  bool isDisposed = false;
  int page = 0;
  int selectedIndex = 0;
  int indexVal = 0;
  String selectedCategory = "";
  Products products =
      Products(list: [], currentPage: 0, totalCount: 0, totalPages: 0);

  getProductsByCategory(String categoryId, String? subCategory) async {
    ArvProgressDialog.instance.showProgressDialog(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (isDisposed) return;
      products = await arvApi.getAllProducts(
        page,
        widget.majorCategory,
        categoryId,
        subCategory,
      );
      safeUpdate();
      // ignore: use_build_context_synchronously
      ArvProgressDialog.instance.dismissDialog(context);
    });
  }

  void safeUpdate() => WidgetsBinding.instance
      .addPostFrameCallback((timeStamp) => setState(() {}));

  @override
  void initState() {
    super.initState();
    page = widget.currentPage;
    if (widget.isCategoryPage) {
      getProductsByCategory("${widget.category}", widget.subSubCategory);
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight) / 3;
    final double itemWidth = size.width / 2.5;
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
            widget.isExploreAll
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
                                    getProductsByCategory(
                                      category.id,
                                      widget.subSubCategory,
                                    );
                                  }
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        indexVal = index;
                                        selectedCategory = category.id;
                                        getProductsByCategory(
                                          category.id,
                                          widget.subSubCategory,
                                        );
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
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              color: indexVal == index
                                                  ? pink
                                                  : gray50,
                                            ),
                                            child: Center(
                                              child: Text(
                                                category.name,
                                                style: TextStyle(
                                                  color: indexVal == index
                                                      ? white
                                                      : black,
                                                ),
                                                textAlign: TextAlign.center,
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
                : widget.isCategoryPage
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
                              child: FutureBuilder<SubCategories>(
                                future: arvApi.getAllSubCategoriesById(
                                    '${widget.category}'),
                                builder: (context, snapshot) {
                                  SubCategories? subCategories = snapshot.data;
                                  if (subCategories == null) return Container();
                                  return ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount: subCategories.list.length,
                                    primary: false,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      SubCategory subCategory =
                                          subCategories.list[index];
                                      if (selectedCategory == "") {
                                        selectedCategory = subCategory.id;
                                        getProductsByCategory(
                                          '${widget.category}',
                                          subCategory.id,
                                        );
                                      }
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            indexVal = index;
                                            selectedCategory = subCategory.id;
                                            getProductsByCategory(
                                              '${widget.category}',
                                              subCategory.id,
                                            );
                                          });
                                        },
                                        child: Container(
                                          color: indexVal == index
                                              ? pink
                                              : Colors.white,
                                          height: 100,
                                          padding: const EdgeInsets.only(
                                              bottom: 20, top: 10),
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          width: 50,
                                          child: Image.network(
                                            arvApi.getMediaUri(
                                                subCategory.image ?? ""),
                                            width: 50,
                                            height: 50,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5)),
                                                  color: indexVal == index
                                                      ? pink
                                                      : gray50,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    subCategory.name,
                                                    style: TextStyle(
                                                      color: indexVal == index
                                                          ? white
                                                          : black,
                                                    ),
                                                    textAlign: TextAlign.center,
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
              width: !(widget.isCategoryPage || widget.isExploreAll)
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width - 120,
              padding: const EdgeInsets.only(top: 10),
              child: GridView.count(
                crossAxisCount:
                    (widget.isCategoryPage || widget.isExploreAll) ? 2 : 3,
                crossAxisSpacing: 2.0,
                childAspectRatio: (itemWidth / itemHeight),
                mainAxisSpacing: 12.0,
                children: List.generate(
                  products.list.length,
                  (index) {
                    return ProductGridCard(product: products.list[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductGridCard extends StatefulWidget {
  const ProductGridCard({super.key, required this.product});

  final ProductDto product;

  @override
  State<StatefulWidget> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGridCard> {
  late ProductDto product;

  @override
  void initState() {
    super.initState();
    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return FutureBuilder<int>(
      initialData: 0,
      future: arvApi.getCartCountById(product.id),
      builder: (context, snapshot) {
        int count = snapshot.data ?? 0;
        int quantity = product.stock!.isNotEmpty ? product.stock![0] : 0;
        String productId = product.id;
        String productVariant = product.productVariation![0];
        return InkWell(
          onTap: () {
            Get.to(() => ProductDetailPageView(
                  productId: productId,
                ));
          },
          child: Center(
            child: Container(
              height: 600,
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
                        arvApi.getMediaUri(product.imageUri ?? ""),
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 100,
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                "No image",
                                style: TextStyle(
                                  color: gray,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
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
                        padding: const EdgeInsets.only(left: 0, top: 4),
                        // Add padding
                        child: Text(
                          product.productSubCategory.name,
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
                          Text(
                            "${product.mrpPrice!.isNotEmpty ? product.mrpPrice![0].toInt() : ""} rs",
                            style: GoogleFonts.poppins(
                              fontSize: 14.0,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "${product.sellingPrice!.isNotEmpty ? product.sellingPrice![0].toInt() : ""} rs",
                            style: GoogleFonts.poppins(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 1000000,
                        padding: const EdgeInsets.only(right: 0, top: 10),
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
                                width: 10000,
                                height: 35,
                                margin:
                                    const EdgeInsets.only(right: 0, top: 10),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                          );
                                        }),
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
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> performCartOperation(bool isInc, int quantity, int count,
      String productId, String productVariant) async {
    ArvProgressDialog.instance.showProgressDialog(context);

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
    setState(() {
      ArvProgressDialog.instance.dismissDialog(context);
    });
  }
}

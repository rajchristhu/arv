import 'package:arv/models/request/cart.dart';
import 'package:arv/models/response_models/products.dart';
import 'package:arv/shared/cart_service.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/utils/custom_progress_bar.dart';
import 'package:arv/views/order_page/cart.dart';
import 'package:arv/views/widgets/favourite_picks.dart';
import 'package:cached_network_image/src/cached_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/navigation_service.dart';
import '../home_bottom_navigation_screen.dart';

class ProductDetailPageView extends StatefulWidget {
  const ProductDetailPageView({super.key,required this.checks, this.productId});

  final String? productId;
  final bool? checks;

  @override
  State createState() => _ProductDetailPageViewState();
}

class _ProductDetailPageViewState extends State<ProductDetailPageView> {
  List<Color> colors = [Colors.blue, Colors.green, Colors.yellow, Colors.pink];
  List<String> imagePath = [
    "images/shoe_blue.png",
    "images/shoe_green.png",
    "images/shoe_yellow.png",
    "images/shoe_pink.png"
  ];
  Color selectedColor = Colors.blue;
  var isFavourite = false;
  var check = false;
  String? productId;
  int count = 0;
  int quantity = 0;
  int quantityCheck = 0;
  int variantIndex = 0;
  List<ProductVariant> variantList = [];
  List<double> mrpPrices = [];
  List<double> sellingPrices = [];
  List<double> vDiscount = [];

  @override
  void initState() {
    super.initState();
    check = true;
    productId = widget.productId;
    arvApi.productView('$productId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: arvApi.getProductById(productId),
          builder: (context, snapshot) {
            ProductDto? productDto = snapshot.data;
            quantity = ((productDto!.stock != null &&
                    (productDto.stock?.length ?? 0) > 0)
                ? productDto.stock![0]
                : 0);

            mrpPrices = productDto.mrpPrice ?? [];
            sellingPrices = productDto.sellingPrice ?? [];
            variantList = productDto.productVariants;
            if (check) {
              quantityCheck = variantList[0].qty;
              check = false;
            }
            vDiscount = productDto.vdiscount;
            vDiscount = List.generate(vDiscount.length, (index) {
              return index <= vDiscount.length - 1 ? vDiscount[index] : 0;
            });
            return Column(
              children: [
                header(productDto,widget.checks!),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 110,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      hero(productDto),
                      section(productDto),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Stack(children: [
        FloatingActionButton(
          heroTag: null,
          backgroundColor: pink,
          onPressed: () => {
            Navigator.pop(context),
            navigationService.setNavigation = 4,
          },
          child: SvgPicture.asset(
            "assets/images/bag.svg",
            semanticsLabel: 'Acme Logo',
            color: Colors.white,
            width: 28,
            height: 28,
          ),
        ),
        Positioned(
          top: 0,
          left: 30,
          child: GetBuilder<CartService>(
            init: Get.find<CartService>(),
            builder: (controller) {
              if (controller.items.length == 0) {
                return Container();
              }
              return Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25), // border color
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2), // border width
                  child: Container(
                    // or ClipRRect if you need to clip the content
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor, // inner circle color
                    ),
                    child: Center(
                      child: Text(
                        "${controller.items.length}",
                        style: TextStyle(
                          fontSize: 12,
                          color: white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ), // inner content
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }

  Widget header(ProductDto? productDto, bool checks) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(160),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        padding:
            const EdgeInsets.only(top: 10, right: 16, left: 16, bottom: 25),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          color: appColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                if(checks){
                  Get.to(() =>HomeBottomNavigationScreen(checkVal: false,));
                }else {
                  Navigator.pop(context);
                }
              },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 25,
                color: Colors.white,
              ),
            ),
            const Text(
              "Product Details",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // Icon(
            //   Icons.search,
            //   size: 30,
            //   color: Colors.white,
            // ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget hero(ProductDto? productDto) {
    print("quantityCheck");
    print(quantityCheck);
    return Stack(
      children: [
        quantityCheck == 0
            ? Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(40),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                      imageUrl: arvApi.getMediaUri(productDto?.imageUri),
                      placeholder: (context, url) => Container(
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
                      errorWidget: (context, url, error) => Container(
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
                    ),
                  ),
                  Positioned(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      color: grayts,
                      child: Center(
                        child: Text(
                          "Out of stock",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  Container(
                      padding: const EdgeInsets.all(40),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        imageUrl: arvApi.getMediaUri(productDto?.imageUri),
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
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
                        errorWidget: (context, url, error) => Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
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
                      )),
                  vDiscount.length != 0
                      ? vDiscount[0] == 0
                          ? Container()
                          : Positioned(
                              child: Container(
                                height: 100,
                                child: Stack(
                                  children: <Widget>[
                                    ClipOval(
                                      child: Container(
                                        color: Colors.grey,
                                        height: 70.0, // height of the button
                                        width: 70.0, // width of the button
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: ClipOval(
                                        child: Container(
                                          //color: Colors.green,
                                          height: 60.0, // height of the button
                                          width: 60.0, // width of the button
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 10.0,
                                                  style: BorderStyle.solid),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(21.0, 10.0),
                                                    blurRadius: 20.0,
                                                    spreadRadius: 40.0)
                                              ],
                                              shape: BoxShape.circle),
                                          child: Center(
                                              child: Text(
                                                  vDiscount.length != 0
                                                      ? vDiscount[0]
                                                              .toString() +
                                                          '%'
                                                      : "dff",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w800))),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                      : Container(),
                ],
              ),
        Positioned(
          top: 10,
          right: 20,
          child: SizedBox(
              width: 30,
              height: 30,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  setState(() {
                    isFavourite = !isFavourite;
                    arvApi.addFavourite('${widget.productId}');
                  });
                },
                child: Image.asset(
                  isFavourite
                      ? "images/heart_icon.png"
                      : "images/heart_icon_disabled.png",
                  height: 20,
                  width: 20,
                ),
              )),
        ),
      ],
    );
  }

  Widget section(ProductDto productDto) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  productDto.productName ?? "",
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                '₹ ${sellingPrices[variantIndex]}',
                textAlign: TextAlign.justify,
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 28,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      '₹ ${mrpPrices[variantIndex]}',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.montserrat(
                        color: gray,
                        fontSize: 17.5,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              productDto.isEnabled
                  ? FutureBuilder(
                      future: arvApi.getCartCountById(productDto.id,
                          variantList[variantIndex].productVariant),
                      initialData: 0,
                      builder: (context, snapshot) {
                        count = snapshot.data ?? 0;
                        return quantityCheck == 0
                            ? Container()
                            : count == 0
                                ? SizedBox(
                                    width: 100,
                                    height: 35,
                                    child: ElevatedButton(
                                      onPressed: () async =>
                                          await performCartOperation(true),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.pink,
                                      ),
                                      child: const Text(
                                        "Add",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 100,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          child: Icon(
                                            Icons.remove,
                                            size: 20,
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
                                              fontSize: 20,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          child: Icon(
                                            Icons.add,
                                            size: 20,
                                            color: gray,
                                          ),
                                          onTap: () async =>
                                              await performCartOperation(true),
                                        ),
                                      ],
                                    ),
                                  );
                      },
                    )
                  : Container(),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      "Product Description",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        "${productDto.description}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: variantList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                print("nfdjbnfjdnfjnd");
                print(variantList[index].qty);
                bool selectedIndex = index == variantIndex;
                return InkWell(
                  onTap: () {
                    variantIndex = index;
                    setState(() {
                      print("object");
                      print("sdpdwsdoollo");
                      quantityCheck = variantList[index].qty;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    width: 70,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: selectedIndex ? Colors.green : Colors.black12,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Center(
                      child: Text(
                        variantList[index].productVariant,
                        style: TextStyle(
                          fontSize: 12,
                          color: selectedIndex ? Colors.white : appColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          const UserFavourites(isRecentViews: true),
          const UserFavourites(isRecentViews: false),
        ],
      ),
    );
  }

  Widget property(ProductDto? productDto) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Color",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: List.generate(
                  4,
                  (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColor = colors[index];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(right: 10),
                          height: 34,
                          width: 34,
                          decoration: BoxDecoration(
                              color: colors[index],
                              borderRadius: BorderRadius.circular(17)),
                          child: selectedColor == colors[index]
                              ? Image.asset("images/checker.png")
                              : const SizedBox(),
                        ),
                      )),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Size",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: const Text(
                "10.2",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        )
      ],
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
      arvApi.deleteCartItem(
          productId, variantList[variantIndex].productVariant);
    } else {
      await arvApi.addToCart(
        Cart(
          productId: productId!,
          variant: variantList[variantIndex].productVariant,
          qty: count,
          orderPrice: variantList[variantIndex].price,
        ),
      );
    }
    await Get.find<CartService>().updateList();
    // ignore: use_build_context_synchronously
    ArvProgressDialog.instance.dismissDialog(context);
    setState(() {});
  }
}

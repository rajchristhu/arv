import 'package:arv/models/request/cart.dart';
import 'package:arv/models/response_models/products.dart';
import 'package:arv/shared/cart_service.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/utils/custom_progress_bar.dart';
import 'package:arv/views/widgets/favourite_picks.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class ProductDetailPageView extends StatefulWidget {
  const ProductDetailPageView({super.key, this.productId});

  final String? productId;

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
  String? productId;
  int count = 0;
  int quantity = 0;
  int variantIndex = 0;
  List<ProductVariant> variantList = [];
  List<double> mrpPrices = [];

  @override
  void initState() {
    super.initState();
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
            ProductDto? productDto = snapshot.data!;
            quantity = ((productDto.stock != null &&
                    (productDto.stock?.length ?? 0) > 0)
                ? productDto.stock![0]
                : 0);

            mrpPrices = productDto.mrpPrice ?? [];
            variantList = productDto.productVariants;
            return Column(
              children: [
                header(productDto),
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
    );
  }

  Widget header(ProductDto? productDto) {
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
                Navigator.pop(context);
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
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(40),
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: Image.network(
            arvApi.getMediaUri(productDto?.imageUri),
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          top: 10,
          right: 20,
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
              height: 34,
              width: 34,
            ),
          ),
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
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
                child: Text(
                  "4.5",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 170,
                height: 25,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Icon(
                      index == 4 ? Icons.star_half_rounded : Icons.star,
                      color: Colors.orange,
                    );
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                '₹ ${variantList[variantIndex].price}',
                textAlign: TextAlign.justify,
                style: const TextStyle(
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
                      style: TextStyle(
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
              FutureBuilder(
                future: arvApi.getCartCountById(
                    productDto.id, variantList[variantIndex].productVariant),
                initialData: 0,
                builder: (context, snapshot) {
                  count = snapshot.data ?? 0;
                  return count == 0
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
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
              ),
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "${productDto.description}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 5,
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
                bool selectedIndex = index == variantIndex;
                return InkWell(
                  onTap: () {
                    variantIndex = index;
                    setState(() {});
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
                        variantList[0].productVariant,
                        style: TextStyle(
                          fontSize: 16,
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
        ),
      );
    }
    await Get.find<CartService>().updateList();
    // ignore: use_build_context_synchronously
    ArvProgressDialog.instance.dismissDialog(context);
    setState(() {});
  }
}

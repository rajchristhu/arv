import 'package:arv/models/request/cart.dart';
import 'package:arv/models/response_models/products.dart';
import 'package:arv/shared/cart_service.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
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
  String productVariant = "";

  @override
  void initState() {
    super.initState();
    productId = widget.productId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: arvApi.getProductById(productId),
          builder: (context, snapshot) {
            ProductDto? productDto = snapshot.data;
            if (productDto == null) return Container();
            quantity = (productDto.stock != null &&
                    (productDto.stock?.length ?? 0) > 0)
                ? productDto.stock![0]
                : 0;

            try {
              productVariant = productDto.productVariation![0];
            } catch (e) {
              productVariant = "";
            }
            return Column(
              children: [
                header(productDto),
                hero(productDto),
                Expanded(child: section(productDto)),
                bottomButton(productDto),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget header(ProductDto? productDto) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("images/back_button.png"),
          Column(
            children: [
              Text(
                productDto?.productName ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 16,
                ),
              ),
              Text(
                productDto?.brand ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              )
            ],
          ),
          InkWell(
            onTap: () {},
            child: Image.asset(
              "images/bag_button.png",
              height: 34,
              width: 34,
            ),
          ),
        ],
      ),
    );
  }

  Widget hero(ProductDto? productDto) {
    return Stack(
      children: [
        Image.network(arvApi.getMediaUri(productDto?.imageUri)),
        Positioned(
          bottom: 10,
          right: 20,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              setState(() {
                isFavourite = !isFavourite;
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
        )
      ],
    );
  }

  Widget section(ProductDto? productDto) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Text(
            productDto?.description ?? "",
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          // property(productDto),
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
            Text(
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
                      print("index $index clicked");
                      setState(() {
                        selectedColor = colors[index];
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(right: 10),
                      height: 34,
                      width: 34,
                      child: selectedColor == colors[index]
                          ? Image.asset("images/checker.png")
                          : SizedBox(),
                      decoration: BoxDecoration(
                          color: colors[index],
                          borderRadius: BorderRadius.circular(17)),
                    ),
                  )),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Size",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Text(
                "10.2",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget bottomButton(ProductDto? productDto) {
    return FutureBuilder(
      future: arvApi.getCartCountById(productDto?.id),
      initialData: 0,
      builder: (context, snapshot) {
        count = snapshot.data ?? 0;
        return Container(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              count == 0
                  ? Container(
                      width: 200,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () async => await performCartOperation(true),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.purple,
                        ),
                        child: const Text(
                          "Add to cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 160,
                      height: 50,
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
                            onTap: () async => await performCartOperation(true),
                          ),
                        ],
                      ),
                    ),
              const Spacer(),
              Container(
                width: 200,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.purple,
                  ),
                  child: const Text(
                    "Place Order",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        );
      },
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
          productId: productId!,
          variant: productVariant,
          qty: count,
        ),
      );
    }
    await Get.find<CartService>().updateList();
    setState(() {});
  }
}
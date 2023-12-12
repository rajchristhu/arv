import 'package:arv/shared/cart_service.dart';
import 'package:arv/shared/navigation_service.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/views/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
class LandingPage extends StatelessWidget {
  const LandingPage({
    super.key,
    required this.itemWidth,
    required this.itemHeight,
  });

  final double itemWidth;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: HomePage(
            itemWidth: itemWidth,
            itemHeight: itemHeight,
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).size.height * 0.40),
          bottom: 35,
          left: 10,
          right: 10,
          child: GetBuilder<CartService>(
            init: Get.find<CartService>(),
            builder: (controller) {
              if (controller.items.length == 0) {
                return Container();
              }
              return Container(
                decoration: BoxDecoration(
                  color: appColor,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(5),
                height: 20,
                width: 600,
                child: Center(
                  child: SizedBox(
                    height: 20,
                    child: Row(
                      children: [
                        Text(
                          "Item ${controller.items.length} | ₹ ${controller.cartTotal.orderValue}",
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            color: white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () => navigationService.setNavigation = 4,
                          child: const Text(
                            "View cart",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        InkWell(
                          onTap: () => navigationService.setNavigation = 4,
                          child: const Icon(
                            Icons.shopping_bag,
                            color: Colors.pinkAccent,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

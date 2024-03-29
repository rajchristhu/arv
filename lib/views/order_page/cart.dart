import 'package:arv/views/order_page/cart_list.dart';
import 'package:arv/views/widgets/order_details/order_details.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            CartListItems(),
            CartValue(),
          ],
        ),
      ),
    )
     ;
  }
}

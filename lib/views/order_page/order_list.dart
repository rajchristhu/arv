import 'package:arv/utils/app_colors.dart';
import 'package:arv/views/order_page/my_order_list.dart';
import 'package:flutter/material.dart';

class OrderDetailsList extends StatefulWidget {
  const OrderDetailsList({Key? key}) : super(key: key);

  @override
  State createState() => _OrderDetailsListState();
}

class _OrderDetailsListState extends State<OrderDetailsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              SizedBox(
                child: Text(
                  "My Orders ",
                  style: TextStyle(
                      color: black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        const SizedBox(height: 15),
        const SizedBox(
          height: 600,
          child: MyOrderList(),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

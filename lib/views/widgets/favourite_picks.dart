import 'package:arv/models/response_models/products.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/views/widgets/product_item_in_list.dart';
import 'package:flutter/material.dart';

class FavouritePicks extends StatelessWidget {
  const FavouritePicks({
    super.key,
    required this.pageNumber,
  });

  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Products>(
      future: arvApi.getAllProducts(pageNumber,null, null, "64ff716ec78bc62fc17ef206"),
      builder: (context, snapshot) {
        List<Product> productList = snapshot.data?.list ?? [];
        if (productList.isEmpty) return Container();
        return SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: productList.length,
            primary: false,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ProductItemInList(
                product: productList[index],
                index: index,
              );
            },
          ),
        );
      },
    );
  }
}

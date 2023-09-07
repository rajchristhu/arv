import 'package:arv/models/response_models/products.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/views/widgets/product_in_offer_list.dart';
import 'package:flutter/material.dart';

class ProductsInOfferSection extends StatelessWidget {
  const ProductsInOfferSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Products>(
      future: arvApi.getAllProducts(0),
      builder: (context, snapshot) {
        List<Product> products = snapshot.data?.list ?? [];
        return SizedBox(
          height: 180,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: products.length,
            primary: false,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ProductInOfferList(
                product: products[index],
                index: index,
              );
            },
          ),
        );
      },
    );
  }
}

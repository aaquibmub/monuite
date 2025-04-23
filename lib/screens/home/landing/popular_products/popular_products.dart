import 'package:flutter/material.dart';
import 'package:monuite/screens/home/landing/popular_products/widgets/popular_product_card_widget.dart';
import 'package:provider/provider.dart';

import '../../../../providers/product_provider.dart';
import '../../../loading_screen.dart';

class PopularProducts extends StatefulWidget {
  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Popular Products",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ]),
        ),
        Center(
          child: FutureBuilder(
              future: Provider.of<ProductProvider>(context, listen: false)
                  .populatePopularProductList(take: 5),
              builder: (ctx, data) {
                if (data.connectionState == ConnectionState.waiting) {
                  return LoadingScreen();
                }
                return Container(
                  height: 100,
                  width: deviceSize.width,
                  child: Consumer<ProductProvider>(
                    builder: (ctx, provider, _) {
                      return provider.popularProducts.length > 0
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: <Widget>[
                                ...provider.popularProducts.map(
                                  (e) => PopularProductCardWidget(e),
                                ),
                              ]),
                            )
                          : Center(
                              child: Text("no products found"),
                            );
                    },
                  ),
                );
              }),
        ),
      ],
    );
  }
}

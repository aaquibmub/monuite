import 'package:flutter/material.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/screens/home/landing/popular_products/widgets/popular_product_card_widget.dart';
import 'package:provider/provider.dart';

import '../../../../providers/product_provider.dart';
import '../../../loading_screen.dart';

class PopularCategoryProducts extends StatefulWidget {
  @override
  State<PopularCategoryProducts> createState() =>
      _PopularCategoryProductsState();
}

class _PopularCategoryProductsState extends State<PopularCategoryProducts> {
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
              AppLocalizations.of(context)!.popularCategories,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ]),
        ),
        Center(
          child: FutureBuilder(
              future: Provider.of<ProductProvider>(context, listen: false)
                  .populatePopularCategoryProducts(),
              builder: (ctx, data) {
                if (data.connectionState == ConnectionState.waiting) {
                  return LoadingScreen();
                }
                return Container(
                  width: deviceSize.width,
                  child: Consumer<ProductProvider>(
                    builder: (ctx, provider, _) {
                      return provider.popularCategoryProducts.length > 0
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: <Widget>[
                                ...provider.popularCategoryProducts.map(
                                  (e) => PopularProductCardWidget(e),
                                ),
                              ]),
                            )
                          : Center(
                              child: Text(AppLocalizations.of(context)!
                                  .noProductsFound),
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

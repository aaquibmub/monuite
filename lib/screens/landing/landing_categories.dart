import 'package:flutter/material.dart';
import 'package:monuite/providers/product_provider.dart';
import 'package:monuite/screens/landing/widgets/landing_category_card_widget.dart';
import 'package:provider/provider.dart';

import '../loading_screen.dart';

class LandingCategories extends StatefulWidget {
  const LandingCategories({Key key}) : super(key: key);

  @override
  State<LandingCategories> createState() => _LandingCategoriesState();
}

class _LandingCategoriesState extends State<LandingCategories> {
  _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Center(
      child: FutureBuilder(
          future: Provider.of<ProductProvider>(context, listen: false)
              .populateCategoryList(),
          builder: (ctx, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            }
            return Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Consumer<ProductProvider>(
                builder: (ctx, provider, _) {
                  return provider.categories.length > 0
                      ? ListView.builder(
                          itemCount: provider.categories.length,
                          itemBuilder: (_a, i) {
                            return LandingCategoryCardWidget(
                              provider.categories[i],
                              _updateState,
                            );
                          },
                        )
                      : Center(
                          child: Text("no categories found"),
                        );
                },
              ),
            );
          }),
    );
  }
}

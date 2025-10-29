import 'package:flutter/material.dart';
import 'package:monuite/helpers/common/utility.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/providers/product_provider.dart';
import 'package:monuite/screens/categories/product_by_category_card_widget.dart';
import 'package:monuite/screens/loading_screen.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  String _query;

  ProductListScreen(
    this._query,
  );

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.products,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Body
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchProducts,
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  widget._query = value;
                });
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => ProductListScreen(
                //             value,
                //           )),
                // );
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: Provider.of<ProductProvider>(context, listen: false)
                      .populateProductList(widget._query),
                  builder: (ctx, data) {
                    if (data.connectionState == ConnectionState.waiting) {
                      return LoadingScreen();
                    }
                    return Container(
                      height: deviceSize.height - 200,
                      width: deviceSize.width,
                      child: Consumer<ProductProvider>(
                        builder: (ctx, provider, _) {
                          return provider.productList.length > 0
                              ? SingleChildScrollView(
                                  child: GridView(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          (Utility.getValuebyDeviceSize(
                                              deviceSize, 1, 2, 4) as int),
                                      // childAspectRatio: 3 / 2,
                                      crossAxisSpacing:
                                          (Utility.getValuebyDeviceSize(
                                                  deviceSize, 10.0, 20.0, 40.0)
                                              as double),
                                      mainAxisSpacing:
                                          (Utility.getValuebyDeviceSize(
                                                  deviceSize, 10.0, 40.0, 80.0)
                                              as double),
                                    ),
                                    physics: ScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    children: provider.productList
                                        .map((e) =>
                                            ProductByCategoryCardWidget(e))
                                        .toList(),
                                  ),
                                )
                              // Column(children: <Widget>[
                              //   ...provider.categories.map(
                              //     (e) => CategoryCardWidget(e),
                              //   ),
                              // ]),

                              : Center(
                                  child: Text(AppLocalizations.of(context)!
                                      .noProductsFound),
                                );
                        },
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

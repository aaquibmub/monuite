import 'package:flutter/material.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/providers/product_provider.dart';
import 'package:monuite/screens/categories/product_by_category_card_widget.dart';
import 'package:monuite/screens/loading_screen.dart';
import 'package:provider/provider.dart';

import '../../helpers/common/utility.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String _id;
  final String _name;

  CategoryDetailScreen(
    this._id,
    this._name,
  );

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _name,
        ),
      ),
      // drawer: Utility.buildDrawer(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                AppLocalizations.of(context)!.products,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: Provider.of<ProductProvider>(context, listen: false)
                      .populateProductByCategoryList(_id),
                  builder: (ctx, data) {
                    if (data.connectionState == ConnectionState.waiting) {
                      return LoadingScreen();
                    }
                    return Container(
                      height: deviceSize.height - 250,
                      width: deviceSize.width,
                      child: Consumer<ProductProvider>(
                        builder: (ctx, provider, _) {
                          return provider.productsByCategory.length > 0
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
                                    children: provider.productsByCategory
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
          // Container(
          //   margin: EdgeInsets.symmetric(
          //     vertical: 10,
          //   ),
          //   child: Container(
          //     width: double.infinity,
          //     height: 60,
          //     child: ElevatedButton(
          //       style: ButtonStyle(
          //           backgroundColor: WidgetStateProperty.all<Color>(
          //               Theme.of(context).primaryColor)),
          //       onPressed: () async {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => TabsScreen(0)),
          //         );
          //       },
          //       child: Text(
          //         AppLocalizations.of(context)!.backToHome,
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.bold,
          //           color: Constants.backgroundColor,
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
      bottomNavigationBar: Utility.buildBottomNavigationBar(context, 1),
    );
  }
}

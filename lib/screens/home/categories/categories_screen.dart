import 'package:flutter/material.dart';
import 'package:monuite/screens/home/categories/widgets/category_card_widget.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common/utility.dart';
import '../../../providers/product_provider.dart';
import '../../loading_screen.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Catgories',
          ),
        ),
      ),
      drawer: Utility.buildDrawer(context),
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
                "Categories",
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
                          return provider.allCategories.length > 0
                              ? SingleChildScrollView(
                                  child: GridView(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          (Utility.getValuebyDeviceSize(
                                              deviceSize, 2, 4, 8) as int),
                                      // childAspectRatio: 3 / 2,
                                      crossAxisSpacing:
                                          (Utility.getValuebyDeviceSize(
                                                  deviceSize, 15.0, 20.0, 40.0)
                                              as double),
                                      mainAxisSpacing:
                                          (Utility.getValuebyDeviceSize(
                                                  deviceSize, 20.0, 40.0, 80.0)
                                              as double),
                                    ),
                                    physics: ScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    children: provider.allCategories
                                        .map((e) => CategoryCardWidget(e))
                                        .toList(),
                                  ),
                                )
                              // Column(children: <Widget>[
                              //   ...provider.categories.map(
                              //     (e) => CategoryCardWidget(e),
                              //   ),
                              // ]),

                              : Center(
                                  child: Text("no categories found"),
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

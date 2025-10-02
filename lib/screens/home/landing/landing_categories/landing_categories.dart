import 'package:flutter/material.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/providers/product_provider.dart';
import 'package:monuite/screens/home/landing/landing_categories/widgets/landing_category_card_widget.dart';
import 'package:provider/provider.dart';

import '../../../loading_screen.dart';
import '../../tabs_screen.dart';

class LandingCategories extends StatefulWidget {
  const LandingCategories({Key? key}) : super(key: key);

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
              AppLocalizations.of(context)!.categories,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TabsScreen(1)),
                );
              },
              child: Text(AppLocalizations.of(context)!.seeAll),
            ),
          ]),
        ),
        Center(
          child: FutureBuilder(
              future: Provider.of<ProductProvider>(context, listen: false)
                  .populateCategoryList(take: 5),
              builder: (ctx, data) {
                if (data.connectionState == ConnectionState.waiting) {
                  return LoadingScreen();
                }
                return Container(
                  height: 200,
                  width: deviceSize.width,
                  child: Consumer<ProductProvider>(
                    builder: (ctx, provider, _) {
                      return provider.categories.length > 0
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: <Widget>[
                                ...provider.categories.map(
                                  (e) => LandingCategoryCardWidget(
                                    e,
                                    _updateState,
                                  ),
                                ),
                              ]),
                            )
                          : Center(
                              child: Text(AppLocalizations.of(context)!
                                  .noCategoriesFound),
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

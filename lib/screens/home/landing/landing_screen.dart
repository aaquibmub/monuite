import 'package:flutter/material.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/screens/home/landing/global_search/landing_global_search_button_widget.dart';
import 'package:monuite/screens/home/landing/landing_categories/landing_categories.dart';
import 'package:monuite/screens/home/landing/popular_category_products/popular_category_products.dart';
import 'package:monuite/screens/home/landing/popular_products/popular_products.dart';

import '../../../helpers/common/utility.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.home,
        ),
      ),
      drawer: Utility.buildDrawer(context),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LandingGlobalSearchButtonWidget(),
                LandingCategories(),
                PopularProducts(),
                PopularCategoryProducts()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

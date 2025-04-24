import 'package:flutter/material.dart';
import 'package:monuite/screens/home/landing/landing_categories/landing_categories.dart';
import 'package:monuite/screens/home/landing/popular_products/popular_products.dart';

import '../../../helpers/common/utility.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Home',
          ),
        ),
      ),
      drawer: Utility.buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[LandingCategories(), PopularProducts()],
        ),
      ),
    );
  }
}

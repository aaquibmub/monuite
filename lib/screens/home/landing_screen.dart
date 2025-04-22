import 'package:flutter/material.dart';

import '../../helpers/common/utility.dart';
import '../landing/landing_categories.dart';

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[LandingCategories()],
        ),
      ),
    );
  }
}

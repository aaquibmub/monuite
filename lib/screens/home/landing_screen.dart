import 'package:flutter/material.dart';

import '../../helpers/common/utility.dart';

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
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../helpers/common/utility.dart';
import '../home/home_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final String _id;

  ProductDetailScreen(
    this._id,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Product Detail',
          ),
        ),
      ),
      drawer: Utility.buildDrawer(context),
      body: Column(
      children: [
        Container(
          child: Center(
            child: Text("Product Detail Screen's $_id"),
          ),
        ),
        SizedBox(height: 10,),
        Container(child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen()),
            );
          },
          child: Text("Go Back"),
        ),) ,

      ],
    ) ,);
  }
}

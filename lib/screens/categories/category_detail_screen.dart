import 'package:flutter/material.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String _id;

  CategoryDetailScreen(
    this._id,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Category Detail Screen's $_id"),
      ),
    );
  }
}

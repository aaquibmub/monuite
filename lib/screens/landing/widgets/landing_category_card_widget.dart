import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:monuite/helpers/models/categories/category-list-model.dart';

import '../../categories/category_detail_screen.dart';

class LandingCategoryCardWidget extends StatelessWidget {
  final CategoryListModel _catgory;
  final Function _updateState;

  LandingCategoryCardWidget(
    this._catgory,
    this._updateState,
  );

  @override
  Widget build(BuildContext context) {
    debugger();
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryDetailScreen(
                      _catgory.id,
                    )),
          ).then((value) {
            _updateState();
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100,
              width: 100,
              child: Image.network(
                _catgory.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              _catgory.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

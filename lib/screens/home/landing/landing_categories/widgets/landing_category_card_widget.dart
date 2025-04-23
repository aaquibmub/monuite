import 'package:flutter_svg/flutter_svg.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:monuite/helpers/models/categories/category-list-model.dart';

import '../../../../categories/category_detail_screen.dart';

class LandingCategoryCardWidget extends StatelessWidget {
  final CategoryListModel _catgory;
  final Function _updateState;

  LandingCategoryCardWidget(
    this._catgory,
    this._updateState,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
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
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: new BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                shape: BoxShape.circle,
              ),
              height: 60,
              width: 60,
              child: Center(
                child: _catgory.imageUrl != null
                    ? (_catgory.imageUrl.endsWith('.svg')
                        ? SvgPicture.network(
                            _catgory.imageUrl,
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            _catgory.imageUrl,
                            fit: BoxFit.fill,
                          ))
                    : Text('N/A'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 100,
              child: Text(
                _catgory.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../helpers/models/categories/category-list-model.dart';
import '../../../categories/category_detail_screen.dart';

class CategoryCardWidget extends StatelessWidget {
  final CategoryListModel _catgory;

  CategoryCardWidget(
    this._catgory,
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
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: new BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.2),
              ),
              height: 140,
              width: 200,
              child: Center(
                child: _catgory.imageUrl != null
                    ? (_catgory.imageUrl!.endsWith('.svg')
                        ? SvgPicture.network(
                            _catgory.imageUrl!,
                            fit: BoxFit.fill,
                            height: 50,
                            width: 50,
                          )
                        : Image.network(
                            _catgory.imageUrl!,
                            fit: BoxFit.fill,
                            height: 50,
                            width: 50,
                          ))
                    : Text('N/A'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Center(
                child: Text(
                  _catgory.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

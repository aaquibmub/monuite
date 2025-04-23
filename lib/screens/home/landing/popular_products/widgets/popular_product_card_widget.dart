import 'package:flutter/material.dart';
import 'package:monuite/helpers/models/products/product_list_model.dart';

import '../../../../products/product_detail_screen.dart';

class PopularProductCardWidget extends StatelessWidget {
  final ProductListModel _product;

  PopularProductCardWidget(
    this._product,
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
                builder: (context) => ProductDetailScreen(
                      _product.id,
                    )),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Container(
            //   height: 50,
            //   width: 50,
            //   child: Image.network(
            //     _catgory.imageUrl,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            Text(
              _product.name,
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

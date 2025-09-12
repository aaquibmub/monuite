import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:monuite/helpers/common/constants.dart';
import 'package:monuite/helpers/models/products/product_list_model.dart';
import 'package:monuite/screens/products/product_detail_screen.dart';

class ProductByCategoryCardWidget extends StatelessWidget {
  final ProductListModel _product;

  ProductByCategoryCardWidget(
    this._product,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: new BoxDecoration(
        border: Border.all(
          color: Color.fromRGBO(0, 0, 0, 0.2),
        ),
      ),
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
            Container(
              height: 220,
              // width: 200,
              child: Center(
                child: _product.imageUrl != null
                    ? (_product.imageUrl!.endsWith('.svg')
                        ? SvgPicture.network(
                            _product.imageUrl!,
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            _product.imageUrl!,
                            fit: BoxFit.fill,
                          ))
                    : Text('N/A'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              _product.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              child: Text(
                _product.desc,
                style: TextStyle(
                  fontSize: 12,
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "CHF ${_product.price}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Constants.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

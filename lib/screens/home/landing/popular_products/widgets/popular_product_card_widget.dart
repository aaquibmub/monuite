import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:monuite/helpers/common/constants.dart';
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
      height: 420,
      width: 200,
      padding: EdgeInsets.all(5),
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
              height: 300,
              width: 200,
              child: Center(
                child: _product.imageUrl != null
                    ? (_product.imageUrl!.endsWith('.svg')
                        ? SvgPicture.network(
                            _product.imageUrl!,
                            fit: BoxFit.fill,
                          )
                        : CachedNetworkImage(
                            imageUrl: _product.imageUrl!,
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                    CircularProgressIndicator(
                                        value: progress.progress),
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
              height: 30,
              child: Text(
                _product.desc,
                style: TextStyle(
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
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

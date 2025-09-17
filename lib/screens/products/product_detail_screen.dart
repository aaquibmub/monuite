import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:monuite/helpers/common/constants.dart';
import 'package:monuite/helpers/models/cart/cart_item_model.dart';
import 'package:monuite/helpers/models/products/product_detail_model.dart';
import 'package:monuite/providers/cart_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import '../home/tabs_screen.dart';
import '../loading_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final String _id;

  ProductDetailScreen(
    this._id,
  );

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Provider.of<ProductProvider>(context, listen: false)
              .populateProductDetail(widget._id),
          builder: (ctx, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            }
            return Consumer<ProductProvider>(builder: (ctx, provider, _) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back Button
                        Container(
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => HomeScreen()),
                              // );
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Constants.colorGrey,
                              ),
                              child: Icon(Icons.arrow_back),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Center(
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                              child: provider.productDetail != null
                                  ? SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          // Images
                                          CarouselSlider(
                                            options: CarouselOptions(
                                              height: 500,
                                            ),
                                            items: provider.productDetail!
                                                        .imageUrls !=
                                                    null
                                                ? provider
                                                    .productDetail!.imageUrls!
                                                    .map((i) {
                                                    return Builder(
                                                      builder: (BuildContext
                                                          context) {
                                                        return i != null
                                                            ? (i.endsWith(
                                                                    '.svg')
                                                                ? SvgPicture
                                                                    .network(
                                                                    i,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  )
                                                                : Image.network(
                                                                    i,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ))
                                                            : Text('N/A');
                                                      },
                                                    );
                                                  }).toList()
                                                : [],
                                          ),
                                          // Name
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            child: Text(
                                              provider.productDetail!.name,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          // Price
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            child: Text(
                                              "CHF ${provider.productDetail!.price}",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Constants.primaryColor,
                                              ),
                                            ),
                                          ),
                                          // Description
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            child: Text(
                                              provider.productDetail!.desc,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Center(
                                      child: Text("no product found"),
                                    ))),
                    ),
                    // Add to Cart
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                Theme.of(context).primaryColor)),
                        onPressed: () async {
                          final ProductDetailModel product =
                              provider.productDetail!;
                          Provider.of<CartProvider>(context, listen: false)
                              .addItem(CartItemModel(
                            product.id,
                            '',
                            product.imageUrls![0],
                            product.name,
                            '',
                            product.price,
                            1,
                          ))
                              .then((value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TabsScreen(2)),
                            );
                          });
                        },
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Constants.backgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
          }),
    );
  }
}

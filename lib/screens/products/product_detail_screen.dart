import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:monuite/helpers/common/constants.dart';
import 'package:monuite/helpers/common/custom_icons.dart';
import 'package:monuite/helpers/common/routes.dart';
import 'package:monuite/helpers/common/utility.dart';
import 'package:monuite/helpers/models/cart/cart_item_model.dart';
import 'package:monuite/helpers/models/products/attribute_model.dart';
import 'package:monuite/helpers/models/products/product_detail_model.dart';
import 'package:monuite/helpers/models/products/product_variation_list_model.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/providers/cart_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
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
  // final _passwordFocusNode = FocusNode();
  ProductVariationListModel? _selectedVariation;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<ProductProvider>(context, listen: false)
            .populateProductDetail(widget._id),
        builder: (ctx, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          }
          return Consumer<ProductProvider>(builder: (ctx, provider, _) {
            bool hasVariations = provider.productDetail != null &&
                provider.productDetail!.variations != null &&
                provider.productDetail!.variations!.isNotEmpty;
            if (hasVariations && _selectedVariation == null) {
              _selectedVariation = provider.productDetail!.variations![0];
            }
            return Scaffold(
              appBar: AppBar(
                title: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.productDetailScreenTitle,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: FutureBuilder(
                            future: Provider.of<CartProvider>(context,
                                    listen: false)
                                .get(),
                            builder: (ctx, data) {
                              if (data.connectionState ==
                                  ConnectionState.waiting) {
                                return LoadingScreen();
                              }
                              return Consumer<CartProvider>(
                                  builder: (ctx, provider, _) {
                                return Badge.count(
                                  // Using Badge.count for a numerical badge
                                  count: provider.cartModel != null
                                      ? provider.cartModel!.items.length
                                      : 0,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: ImageIcon(
                                      AssetImage(
                                          CustomIcons.othersCartActive2x),
                                    ),

                                    // icon: Icon(Icons.more_horiz_rounded),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, Routes.cartScreen);
                                    },
                                  ),
                                );
                              });
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 32,
                  horizontal: 8,
                ),
                child: Column(
                  children: [
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
                                              clipBehavior: Clip.hardEdge,
                                              enableInfiniteScroll: false,
                                              enlargeCenterPage: true,
                                            ),
                                            items:
                                                provider.productDetail!
                                                            .imageUrls !=
                                                        null
                                                    ? provider.productDetail!
                                                        .imageUrls!
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
                                                                    : CachedNetworkImage(
                                                                        imageUrl:
                                                                            i,
                                                                        progressIndicatorBuilder: (context,
                                                                                url,
                                                                                progress) =>
                                                                            CircularProgressIndicator(value: progress.progress),
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
                                          // Quantity Selector
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                              vertical: 20,
                                            ),
                                            child: Consumer<CartProvider>(
                                                builder:
                                                    (ctx, cartProvider, _) {
                                              var cartItem = cartProvider
                                                          .cartModel !=
                                                      null
                                                  ? cartProvider
                                                      .cartModel!.items
                                                      .where((element) =>
                                                          element!.id ==
                                                          provider
                                                              .productDetail!
                                                              .id)
                                                      .firstOrNull
                                                  : null;
                                              return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: Constants
                                                                .colorGrey,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        height: 40,
                                                        width: 40,
                                                        margin: EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            '-',
                                                            style: TextStyle(
                                                              fontSize: 30,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      // icon: Icon(Icons.more_horiz_rounded),
                                                      onTap: cartItem != null
                                                          ? () {
                                                              Provider.of<CartProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .decreaseItemQuantity(
                                                                      cartItem);
                                                              // _updateState();
                                                            }
                                                          : null,
                                                    ),
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      child: Center(
                                                        child: Text(
                                                          '${cartItem?.quantity ?? 0}',
                                                          style: TextStyle(
                                                            fontSize: 30,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: Constants
                                                                .colorGrey,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        height: 40,
                                                        width: 40,
                                                        margin: EdgeInsets.only(
                                                          left: 10,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            '+',
                                                            style: TextStyle(
                                                              fontSize: 30,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      // icon: Icon(Icons.more_horiz_rounded),
                                                      onTap: cartItem != null
                                                          ? () {
                                                              Provider.of<CartProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .increaseItemQuantity(
                                                                      cartItem);
                                                              // _updateState();
                                                            }
                                                          : null,
                                                    )
                                                  ]);
                                            }),
                                          ),
                                          // Variantion
                                          if (hasVariations)
                                            Container(
                                              width: double.infinity,
                                              child: DropdownButton<String>(
                                                  isExpanded: true,
                                                  value: _selectedVariation?.id,
                                                  elevation: 16,
                                                  style: const TextStyle(
                                                      color: Colors.deepPurple),
                                                  underline: Container(
                                                    height: 2,
                                                    color:
                                                        Colors.deepPurpleAccent,
                                                  ),
                                                  onChanged: (String? value) {
                                                    // This is called when the user selects an item.
                                                    setState(() {
                                                      final ProductVariationListModel?
                                                          item = provider
                                                              .productDetail!
                                                              .variations!
                                                              .where(
                                                                  (element) =>
                                                                      element
                                                                          .id ==
                                                                      value)
                                                              .first;
                                                      if (item != null) {
                                                        setState(() {
                                                          _selectedVariation =
                                                              item;
                                                        });
                                                      }
                                                    });
                                                  },
                                                  selectedItemBuilder:
                                                      (BuildContext context) {
                                                    return provider
                                                        .productDetail!
                                                        .variations!
                                                        .map<Widget>(
                                                            (ProductVariationListModel
                                                                item) {
                                                      return Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        constraints:
                                                            const BoxConstraints(
                                                          maxWidth:
                                                              double.infinity,
                                                        ),
                                                        child: Text(
                                                          item.options
                                                              .map((option) =>
                                                                  option.name +
                                                                  ': ' +
                                                                  option.option)
                                                              .join(', '),
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      );
                                                    }).toList();
                                                  },
                                                  items: provider.productDetail!
                                                      .variations!
                                                      .map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (ProductVariationListModel
                                                              att) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: att.id,
                                                      child: Text(att.options
                                                          .map((option) =>
                                                              option.name +
                                                              ': ' +
                                                              option.option)
                                                          .join(', ')),
                                                    );
                                                  }).toList()),
                                            ),
                                          // Price
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            child: Text(
                                              "CHF ${_selectedVariation != null ? _selectedVariation!.price : provider.productDetail!.price}",
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
                                      child: Text(AppLocalizations.of(context)!
                                          .noProductFound),
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
                            _selectedVariation != null
                                ? _selectedVariation!.id
                                : '',
                            product.imageUrls != null &&
                                    product.imageUrls!.isNotEmpty
                                ? product.imageUrls![0]
                                : null,
                            product.name,
                            _selectedVariation != null
                                ? _selectedVariation!.options
                                    .map((option) =>
                                        option.name + ': ' + option.option)
                                    .join(', ')
                                : '',
                            _selectedVariation != null
                                ? _selectedVariation!.price
                                : product.price,
                            1,
                            product.groupOfQuantity,
                            product.minAllowedQuantity,
                            product.maxAllowedQuantity,
                          ))
                              .then((value) {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => TabsScreen(2)),
                            // );
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(AppLocalizations.of(context)!
                                  .itemAddedToCart),
                            ));
                          });
                        },
                        child: Text(
                          AppLocalizations.of(context)!.addToCart,
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
              ),
              bottomNavigationBar: Utility.buildBottomNavigationBar(context, 1),
            );
          });
        });
  }
}

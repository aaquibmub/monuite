import 'package:flutter/material.dart';
import 'package:monuite/helpers/common/routes.dart';
import 'package:monuite/helpers/common/utility.dart';
import 'package:monuite/screens/home/cart/widgets/cart_item_widget.dart';
import 'package:monuite/screens/home/checkout/checkout_screen.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common/constants.dart';
import '../../../providers/cart_provider.dart';
import '../../loading_screen.dart';
import '../checkout/address/add_new_address_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Provider.of<CartProvider>(context, listen: false).get(),
          builder: (ctx, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            }
            return Container(
              margin: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              child: Consumer<CartProvider>(
                builder: (ctx, provider, _) {
                  return provider.cartModel != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    // Top Bar
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Back Button
                                          Container(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                  Routes.homeScreen,
                                                );
                                              },
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Constants.colorGrey,
                                                ),
                                                child: Icon(Icons.home),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Cart',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white54,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            margin: EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: IconButton(
                                              icon: Icon(Icons.clear),
                                              // icon: Icon(Icons.more_horiz_rounded),
                                              onPressed: () {
                                                provider.clear();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Address
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: provider.cartModel!.address !=
                                                  null &&
                                              provider.cartModel!.address != ""
                                          ? Text(
                                              'Address: ' +
                                                  (provider.cartModel!.address!
                                                      .fullAddress),
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            )
                                          : InkWell(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Constants.colorGrey,
                                                    width: 1,
                                                    style: BorderStyle.solid,
                                                  ),
                                                ),
                                                height: 50,
                                                width: double.infinity,
                                                child: Center(
                                                  child: Text(
                                                    'Add Address',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onTap: () => {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddNewAddressScreen(
                                                              1)),
                                                )
                                              },
                                            ),
                                    ),
                                    // Cart Items
                                    provider.cartModel!.items.length == 0
                                        ? Center(
                                            child: Text("cart is empty"),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: provider
                                                .cartModel!.items.length,
                                            itemBuilder: (ctx, index) {
                                              return CartItemWidget(
                                                provider
                                                    .cartModel!.items[index]!,
                                                _updateState,
                                              );
                                            },
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            // Total
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Container(
                                width: double.infinity,
                                height: 60,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              Theme.of(context).primaryColor)),
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CheckoutScreen()),
                                    );
                                    // final ProductDetailModel product =
                                    //     provider.productDetail;
                                    // Provider.of<CartProvider>(context,
                                    //         listen: false)
                                    //     .addItem(CartItemModel(
                                    //   product.id,
                                    //   '',
                                    //   product.imageUrls[0],
                                    //   product.name,
                                    //   '',
                                    //   product.price,
                                    //   1,
                                    // ))
                                    //     .then((value) {
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             TabsScreen(2)),
                                    //   );
                                    // });
                                  },
                                  child: Text(
                                    "CHF ${Utility.formatNumber(provider.cartModel!.total)}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Constants.backgroundColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Text("cart is empty"),
                        );
                },
              ),
            );
          }),
    );
  }
}

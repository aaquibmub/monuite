import 'package:flutter/material.dart';
import 'package:monuite/helpers/common/custom_icons.dart';
import 'package:monuite/helpers/common/routes.dart';
import 'package:monuite/helpers/common/utility.dart';
import 'package:monuite/helpers/models/addresses/address_model.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/screens/home/cart/widgets/cart_item_widget.dart';
import 'package:monuite/screens/home/checkout/address/edit_address_screen.dart';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          margin: EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button
              Container(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(
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
                AppLocalizations.of(context)!.cartScreenTitle,
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
                child: IconButton(
                  icon: ImageIcon(AssetImage(CustomIcons.othersCartRemove2x)),
                  // icon: Icon(Icons.more_horiz_rounded),
                  onPressed: () {
                    // provider.clear();
                    Provider.of<CartProvider>(context, listen: false)
                        .clear()
                        .then((value) {
                      _updateState();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
          future: Provider.of<CartProvider>(context, listen: false).get(),
          builder: (ctx, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            }
            return Container(
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
                                    // Address
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: provider.cartModel!.address !=
                                                  null &&
                                              provider.cartModel!.address!
                                                      .fullAddress
                                                      .trim() !=
                                                  ''
                                          ? Container(
                                              width: double.infinity,
                                              height: 140,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.2),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              margin: EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 16,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      vertical: 42,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        // Address
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      16,
                                                                ),
                                                                child: Text(
                                                                  provider
                                                                          .cartModel!
                                                                          .address!
                                                                          .city +
                                                                      ', ' +
                                                                      provider
                                                                          .cartModel!
                                                                          .address!
                                                                          .state +
                                                                      ', ' +
                                                                      provider
                                                                          .cartModel!
                                                                          .address!
                                                                          .country,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              // Address 1 + Address 2
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      16,
                                                                ),
                                                                child: Text(
                                                                  provider
                                                                          .cartModel!
                                                                          .address!
                                                                          .address_1 +
                                                                      ' ' +
                                                                      provider
                                                                          .cartModel!
                                                                          .address!
                                                                          .address_2,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        // Edit Button
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 16,
                                                          ),
                                                          child: InkWell(
                                                            onTap: () {
                                                              // Navigate to Edit Address Screen
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => EditAddressScreen(AddressModel(
                                                                      provider
                                                                          .cartModel!
                                                                          .address!
                                                                          .country,
                                                                      provider
                                                                          .cartModel!
                                                                          .address!
                                                                          .first_name,
                                                                      provider
                                                                          .cartModel!
                                                                          .address!
                                                                          .last_name,
                                                                      provider
                                                                          .cartModel!
                                                                          .address!
                                                                          .company,
                                                                      provider
                                                                          .cartModel!
                                                                          .address!
                                                                          .address_1,
                                                                      provider
                                                                          .cartModel!
                                                                          .address!
                                                                          .address_2,
                                                                      provider
                                                                          .cartModel!
                                                                          .address!
                                                                          .city,
                                                                      provider
                                                                          .cartModel!
                                                                          .address!
                                                                          .state,
                                                                      provider
                                                                          .cartModel!
                                                                          .address!
                                                                          .postcode,
                                                                      provider
                                                                          .cartModel!
                                                                          .address!
                                                                          .phone,
                                                                      provider
                                                                          .cartModel!
                                                                          .address!
                                                                          .email)),
                                                                ),
                                                              );
                                                            },
                                                            child: Icon(
                                                                Icons.edit),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          //  Text(
                                          //                                         AppLocalizations.of(context)!
                                          //                                                 .addressWithColon +
                                          //                                             ' ' +
                                          //                                             (provider.cartModel!.address!
                                          //                                                 .fullAddress),
                                          //                                         style: TextStyle(
                                          //                                           fontSize: 20,
                                          //                                           fontWeight: FontWeight.bold,
                                          //                                           color: Colors.black,
                                          //                                         ),
                                          //                                       )
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
                                                    AppLocalizations.of(
                                                            context)!
                                                        .addAddress,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onTap: () => {
                                                Navigator.push(
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
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .cartEmptyMessage),
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
                          child: Text(
                              AppLocalizations.of(context)!.cartEmptyMessage),
                        );
                },
              ),
            );
          }),
    );
  }
}

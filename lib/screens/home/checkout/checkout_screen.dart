import 'package:flutter/material.dart';
import 'package:monuite/helpers/common/utility.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/screens/home/cart/cart_screen.dart';
import 'package:monuite/screens/home/checkout/address/add_new_address_screen.dart';
import 'package:monuite/screens/home/checkout/widgets/checkout_item_widget.dart';
import 'package:monuite/screens/home/payment/payment_screen.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common/constants.dart';
import '../../../providers/cart_provider.dart';
import '../../loading_screen.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: FutureBuilder(
          future: Provider.of<CartProvider>(context, listen: false).get(),
          builder: (ctx, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            }
            return Container(
              margin: EdgeInsets.symmetric(
                vertical: 32,
                horizontal: 8,
              ),
              child: Consumer<CartProvider>(
                builder: (ctx, provider, _) {
                  return provider.cartModel != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CartScreen()),
                                      );
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
                            SizedBox(height: 16),
                            // Top Bar
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .checkoutScreenTitle,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
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
                              child: provider.cartModel!.address != null
                                  ? Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Constants.colorGrey,
                                          width: 1,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      width: deviceSize.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .shippingAddress,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${provider.cartModel!.address!.fullAddress}",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
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
                                            AppLocalizations.of(context)!
                                                .addAddress,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () => {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddNewAddressScreen(1)),
                                        )
                                      },
                                    ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
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
                                              return CheckoutItemWidget(provider
                                                  .cartModel!.items[index]!);
                                            },
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            // Bottom Bar
                            Column(
                              children: [
                                // Total Price
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                                .totalWithColon +
                                            " CHF ${Utility.formatNumber(provider.cartModel!.total)}",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Appy Coupon
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 200,
                                        child: TextField(
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .enterCouponCode,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: Constants.colorGrey,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 60,
                                        width: 180,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all<
                                                          Color>(
                                                      Theme.of(context)
                                                          .primaryColor)),
                                          onPressed: () async {
                                            //   Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             TabsScreen(2)),
                                            //   );
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!.apply,
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
                                // Order Summary
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .orderSummary,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Subtotal
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${AppLocalizations.of(context)!.subtotal} (${provider.cartModel!.items.length} ${AppLocalizations.of(context)!.items})",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "CHF ${Utility.formatNumber(provider.cartModel!.total)}",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Constants.colorGrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Shipping Fee
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .shippingFee,
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "CHF ${Utility.formatNumber(provider.cartModel!.shippingCost)}",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Constants.colorGrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Coupon Discount
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .coupon,
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "CHF ${Utility.formatNumber(provider.cartModel!.couponDiscount ?? 0)}",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Constants.colorGrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Grand Total
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .total,
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "CHF ${Utility.formatNumber(provider.cartModel!.grandTotal)}",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                // Confirm & Pay Button
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
                                                  Theme.of(context)
                                                      .primaryColor)),
                                      onPressed: () async {
                                        if (provider.cartModel!.address ==
                                                null ||
                                            provider.cartModel!.address == "") {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                AppLocalizations.of(context)!
                                                    .addAddressBeforeCheckout),
                                          ));
                                          return;
                                        }
                                        if (provider.cartModel!.items.length ==
                                            0) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                AppLocalizations.of(context)!
                                                    .cartEmptyMessage),
                                          ));
                                          return;
                                        }
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PaymentScreen()),
                                        );
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .confirmAndPay,
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

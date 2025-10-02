import 'package:flutter/material.dart';
import 'package:monuite/helpers/common/utility.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common/constants.dart';
import '../../../helpers/common/custom_icons.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/order_provider.dart';
import '../../loading_screen.dart';
import '../../orders/order_confirmed_screen.dart';
import '../checkout/checkout_screen.dart';

class PaymentScreen extends StatefulWidget {
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Widget _buildPaymentMethod(
      String imageUrl,
      String title,
      Function onTap,
    ) {
      return InkWell(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 10,
          ),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Constants.colorGrey,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 80,
                      margin: EdgeInsets.only(
                        right: 10,
                      ),
                      child: Image.asset(imageUrl),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_right),
            ],
          ),
        ),
        onTap: () => {onTap()},
      );
    }

    void _showErrorDialogue(BuildContext context, String? message) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.anErrorOccurred),
              content:
                  Text(message ?? AppLocalizations.of(context)!.unknownError),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text(AppLocalizations.of(context)!.okay))
              ],
            );
          });
    }

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
              width: deviceSize.width,
              child: _isLoading
                  ? LoadingScreen()
                  : Consumer<CartProvider>(
                      builder: (ctx, provider, _) {
                        return provider.cartModel != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CheckoutScreen()),
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
                                              .selectPaymentMethod,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Payment Method List
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          _buildPaymentMethod(
                                              CustomIcons.paymentMethodInvoice,
                                              Constants.paymentMethodInvoice,
                                              () {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            Provider.of<OrderProvider>(context,
                                                    listen: false)
                                                .createOrder(
                                              provider.cartModel!,
                                              Constants.paymentMethodInvoice,
                                            )
                                                .then((value) {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              if (value.hasError) {
                                                _showErrorDialogue(
                                                    context, value.msg);
                                              } else {
                                                Provider.of<CartProvider>(
                                                        context,
                                                        listen: false)
                                                    .clear()
                                                    .then((_) {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrderConfirmedScreen(
                                                              value.result!,
                                                            )),
                                                  );
                                                });
                                              }
                                            });
                                          }),
                                          _buildPaymentMethod(
                                              CustomIcons.paymentMethodPayPal,
                                              Constants.paymentMethodPaypal,
                                              () {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            Provider.of<OrderProvider>(context,
                                                    listen: false)
                                                .createOrder(
                                              provider.cartModel!,
                                              Constants.paymentMethodPaypal,
                                            )
                                                .then((value) {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              if (value.hasError) {
                                                _showErrorDialogue(
                                                    context, value.msg);
                                              } else {
                                                Provider.of<CartProvider>(
                                                        context,
                                                        listen: false)
                                                    .clear()
                                                    .then((_) {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrderConfirmedScreen(
                                                              value.result!,
                                                            )),
                                                  );
                                                });
                                              }
                                            });
                                          }),
                                          _buildPaymentMethod(
                                              CustomIcons.paymentMethodTwint,
                                              Constants.paymentMethodTwint, () {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            Provider.of<OrderProvider>(context,
                                                    listen: false)
                                                .createOrder(
                                              provider.cartModel!,
                                              Constants.paymentMethodTwint,
                                            )
                                                .then((value) {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              if (value.hasError) {
                                                _showErrorDialogue(
                                                    context, value.msg);
                                              } else {
                                                Provider.of<CartProvider>(
                                                        context,
                                                        listen: false)
                                                    .clear()
                                                    .then((_) {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrderConfirmedScreen(
                                                              value.result!,
                                                            )),
                                                  );
                                                });
                                              }
                                            });
                                          }),
                                          _buildPaymentMethod(
                                              CustomIcons
                                                  .paymentMethodCreditCard,
                                              Constants.paymentMethodCreditCard,
                                              () {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            Provider.of<OrderProvider>(context,
                                                    listen: false)
                                                .createOrder(
                                              provider.cartModel!,
                                              Constants.paymentMethodCreditCard,
                                            )
                                                .then((value) {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              if (value.hasError) {
                                                _showErrorDialogue(
                                                    context, value.msg);
                                              } else {
                                                Provider.of<CartProvider>(
                                                        context,
                                                        listen: false)
                                                    .clear()
                                                    .then((_) {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrderConfirmedScreen(
                                                              value.result!,
                                                            )),
                                                  );
                                                });
                                              }
                                            });
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Bottom Bar
                                  Column(
                                    children: [
                                      // Order Summary
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // Subtotal
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                vertical: 10,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Constants.colorGrey,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .total,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    "CHF ${Utility.formatNumber(provider.cartModel!.grandTotal)}",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                              "${AppLocalizations.of(context)!.pay} CHF ${Utility.formatNumber(provider.cartModel!.grandTotal)}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    Constants.backgroundColor,
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
                                child: Text("cart is empty"),
                              );
                      },
                    ),
            );
          }),
    );
  }
}

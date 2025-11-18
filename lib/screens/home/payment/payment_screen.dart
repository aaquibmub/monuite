import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:monuite/helpers/common/utility.dart';
import 'package:monuite/helpers/models/orders/order_create_response_model.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common/constants.dart';
import '../../../helpers/common/custom_icons.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/order_provider.dart';
import '../../loading_screen.dart';
import '../../orders/order_confirmed_screen.dart';

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

    Future<void> initPaymentSheet(OrderCreateResponseModel data) async {
      try {
        // 2. initialize the payment sheet
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            // Set to true for custom flow
            customFlow: false,
            // Main params
            merchantDisplayName: 'Flutter Stripe Store Demo',
            paymentIntentClientSecret: data.paymentIntentSecret,

            // Customer keys
            // customerEphemeralKeySecret: data['ephemeralKey'],
            // customerId: data['customer'],
            // Extra options
            // applePay: const PaymentSheetApplePay(
            //   merchantCountryCode: 'US',
            // ),
            // googlePay: const PaymentSheetGooglePay(
            //   merchantCountryCode: 'US',
            //   testEnv: true,
            // ),
            style: ThemeMode.dark,
          ),
        );
        // setState(() {
        //   _ready = true;
        // });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
        rethrow;
      }
    }

    Future<void> displayPaymentSheet(OrderCreateResponseModel data) async {
      try {
        await Stripe.instance.presentPaymentSheet().then((value) {
          Provider.of<CartProvider>(context, listen: false).clear().then((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => OrderConfirmedScreen(
                        data.orderId,
                      )),
            );
          });
        }).onError((error, stackTrace) {
          throw Exception(error);
        });
      } on StripeException catch (e) {
        print('Error is:---> $e');
        AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  Text("Payment Failed"),
                ],
              ),
            ],
          ),
        );
      } catch (e) {
        print('$e');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.selectPaymentMethod,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
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
                                  // Payment Method List
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          // Invoice
                                          _buildPaymentMethod(
                                              CustomIcons.paymentMethodInvoice,
                                              AppLocalizations.of(context)!
                                                  .paymentOnAmount, () {
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
                                                              value.result
                                                                      ?.orderId ??
                                                                  '',
                                                            )),
                                                  );
                                                });
                                              }
                                            });
                                          }),
                                          // PayPal
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
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          PaypalCheckoutView(
                                                    sandboxMode:
                                                        PaypalEnvironment
                                                            .Sandbox,
                                                    clientId: PaypalEnvironment
                                                        .ClientId,
                                                    secretKey: PaypalEnvironment
                                                        .Secret,
                                                    transactions: const [
                                                      {
                                                        "amount": {
                                                          "total": '100',
                                                          "currency": "USD",
                                                          "details": {
                                                            "subtotal": '100',
                                                            "shipping": '0',
                                                            "shipping_discount":
                                                                0
                                                          }
                                                        },
                                                        "description":
                                                            "The payment transaction description.",
                                                      }
                                                    ],
                                                    note:
                                                        "Contact us for any questions on your order.",
                                                    onSuccess:
                                                        (Map params) async {
                                                      Provider.of<CartProvider>(
                                                              context,
                                                              listen: false)
                                                          .clear()
                                                          .then((_) {
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  OrderConfirmedScreen(
                                                                    value.result
                                                                            ?.orderId ??
                                                                        '',
                                                                  )),
                                                        );
                                                      });
                                                    },
                                                    onError: (error) {
                                                      AlertDialog(
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Row(
                                                              children: const [
                                                                Icon(
                                                                  Icons.cancel,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                                Text(
                                                                    "Payment Failed"),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                      Navigator.pop(context);
                                                    },
                                                    onCancel: () {
                                                      AlertDialog(
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Row(
                                                              children: const [
                                                                Icon(
                                                                  Icons.cancel,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                                Text(
                                                                    "Payment Cancelled"),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ));
                                              }
                                            });
                                          }),
                                          // TWINT
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
                                                initPaymentSheet(value.result!)
                                                    .then((_) {
                                                  displayPaymentSheet(
                                                      value.result!);
                                                });
                                              }
                                            });
                                          }),
                                          // Credit / Debit Card
                                          _buildPaymentMethod(
                                              CustomIcons
                                                  .paymentMethodCreditCard,
                                              AppLocalizations.of(context)!
                                                  .stripe, () {
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
                                                initPaymentSheet(value.result!)
                                                    .then((_) {
                                                  displayPaymentSheet(
                                                      value.result!);
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

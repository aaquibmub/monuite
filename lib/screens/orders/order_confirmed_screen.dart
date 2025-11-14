import 'package:flutter/material.dart';
import 'package:monuite/helpers/common/utility.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/screens/orders/widgets/order_item_widget.dart';
import 'package:provider/provider.dart';

import '../../helpers/common/constants.dart';
import '../../providers/order_provider.dart';
import '../loading_screen.dart';

class OrderConfirmedScreen extends StatefulWidget {
  final String _orderId;
  const OrderConfirmedScreen(this._orderId, {Key? key}) : super(key: key);

  @override
  State<OrderConfirmedScreen> createState() => _OrderConfirmedScreenState();
}

class _OrderConfirmedScreenState extends State<OrderConfirmedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.orderConfirmed,
        ),
      ),
      body: FutureBuilder(
          future: Provider.of<OrderProvider>(context, listen: false)
              .getOrderModel(widget._orderId),
          builder: (ctx, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            }

            return Container(
                margin: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Consumer<OrderProvider>(
                        builder: (ctx, provider, _) {
                          return provider.orderModel != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    // Confirmation Message
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .confirmed,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .thankYouForOrdering,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Constants.colorGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            // Cart Items
                                            provider.orderModel!.items.length ==
                                                    0
                                                ? Center(
                                                    child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .cartEmptyMessage),
                                                  )
                                                : ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: provider
                                                        .orderModel!
                                                        .items
                                                        .length,
                                                    itemBuilder: (ctx, index) {
                                                      return OrderItemWidget(
                                                        provider.orderModel!
                                                            .items[index],
                                                      );
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "${AppLocalizations.of(context)!.totalWithColon} CHF ${provider.orderModel!.total}",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .orderSummary,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${AppLocalizations.of(context)!.subtotal} (${provider.orderModel!.items.length} ${AppLocalizations.of(context)!.items})",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                      "CHF ${provider.orderModel!.total}",
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
                                              // Shipping Fee
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
                                                          .shippingFee,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                      "CHF ${provider.orderModel!.shippingCost}",
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
                                              // Coupon Discount
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
                                                          .coupon,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                      "CHF ${provider.orderModel!.couponDiscount ?? 0}",
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
                                                      "CHF ${provider.orderModel!.grandTotal}",
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
                                      ],
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                      // Top Bar
                                      Center(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .orderNotFound,
                                        ),
                                      ),
                                    ]);
                        },
                      ),
                    ),
                    // Confirm & Pay Button
                    // Container(
                    //   margin: EdgeInsets.symmetric(
                    //     vertical: 10,
                    //   ),
                    //   child: Container(
                    //     width: double.infinity,
                    //     height: 60,
                    //     child: ElevatedButton(
                    //       style: ButtonStyle(
                    //           backgroundColor: WidgetStateProperty.all<Color>(
                    //               Theme.of(context).primaryColor)),
                    //       onPressed: () async {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => TabsScreen(0)),
                    //         );
                    //       },
                    //       child: Text(
                    //         AppLocalizations.of(context)!.backToHome,
                    //         style: TextStyle(
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.bold,
                    //           color: Constants.backgroundColor,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ));
          }),
      bottomNavigationBar: Utility.buildBottomNavigationBar(context, 0),
    );
  }
}

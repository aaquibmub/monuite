import 'package:flutter/material.dart';
import 'package:monuite/screens/orders/widgets/order_item_widget.dart';
import 'package:provider/provider.dart';

import '../../helpers/common/constants.dart';
import '../../providers/order_provider.dart';
import '../home/tabs_screen.dart';
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
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Container(
                                    //       child: InkWell(
                                    //         onTap: () {
                                    //           Navigator.push(
                                    //             context,
                                    //             MaterialPageRoute(
                                    //                 builder: (context) =>
                                    //                     PaymentScreen()),
                                    //           );
                                    //         },
                                    //         child: Container(
                                    //           width: 30,
                                    //           height: 30,
                                    //           decoration: BoxDecoration(
                                    //             shape: BoxShape.circle,
                                    //             color: Constants.colorGrey,
                                    //           ),
                                    //           child: Icon(Icons.arrow_back),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
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
                                            'Order Confirmed',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                                            'Confirmed',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Thank you for your order. You will receive an email confirmation shortly.',
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
                                                    child:
                                                        Text("cart is empty"),
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
                                                "Total: CHF ${provider.orderModel!.total}",
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
                                                      "Order Summary",
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
                                                      "Subtotal (${provider.orderModel!.items.length} items)",
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
                                                      "Shipping Free",
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
                                                      "Coupon",
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
                                                      "Total",
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
                                        child: Text("Order not found"),
                                      ),
                                    ]);
                        },
                      ),
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
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  Theme.of(context).primaryColor)),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TabsScreen(0)),
                            );
                          },
                          child: Text(
                            "Continue to explore",
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
                ));
          }),
    );
  }
}

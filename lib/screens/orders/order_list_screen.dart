import 'package:flutter/material.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/providers/order_provider.dart';
import 'package:monuite/screens/loading_screen.dart';
import 'package:monuite/screens/orders/widgets/order_list_card_widget.dart';
import 'package:provider/provider.dart';

class OrderListScreen extends StatefulWidget {
  String _query;

  OrderListScreen(
    this._query,
  );

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.orders,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Body
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchOrders,
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  widget._query = value;
                });
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: Provider.of<OrderProvider>(context, listen: false)
                      .populateOrderList(widget._query),
                  builder: (ctx, data) {
                    if (data.connectionState == ConnectionState.waiting) {
                      return LoadingScreen();
                    }
                    return Container(
                      height: deviceSize.height,
                      width: deviceSize.width,
                      child: Consumer<OrderProvider>(
                        builder: (ctx, provider, _) {
                          return provider.orderList.length > 0
                              ? SingleChildScrollView(
                                  child: Column(
                                    children: provider.orderList
                                        .map((e) => OrderListCardWidget(e))
                                        .toList(),
                                  ),
                                )
                              : Center(
                                  child: Text(AppLocalizations.of(context)!
                                      .noOrdersFound),
                                );
                        },
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

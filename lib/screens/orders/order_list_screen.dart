import 'package:flutter/material.dart';
import 'package:monuite/helpers/common/constants.dart';
import 'package:monuite/helpers/common/routes.dart';
import 'package:monuite/l10n/app_localizations.dart';
import 'package:monuite/providers/order_provider.dart';
import 'package:monuite/screens/loading_screen.dart';
import 'package:monuite/screens/orders/widgets/order_list_card_widget.dart';
import 'package:provider/provider.dart';

class OrderListScreen extends StatefulWidget {
  final String _query;

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
    TextEditingController _myController =
        TextEditingController(text: widget._query);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: 32,
              horizontal: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop(Routes.profileScreen);
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
                Text(
                  AppLocalizations.of(context)!.orders,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(''),
              ],
            ),
          ),
          // Body
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: TextField(
              autofocus: true,
              controller: _myController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchOrders,
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // setState(() {
                //   widget._query = value;
                // });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderListScreen(
                            value,
                          )),
                );
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

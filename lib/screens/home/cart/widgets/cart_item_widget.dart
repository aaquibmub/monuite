import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:monuite/helpers/models/cart/cart_item_model.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common/constants.dart';
import '../../../../providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel _model;
  final Function _updateState;

  CartItemWidget(
    this._model,
    this._updateState,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: new BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                ),
                height: 150,
                width: 200,
                child: Center(
                  child: _model.imageUrl != null
                      ? _model.imageUrl.endsWith('.svg')
                          ? SvgPicture.network(
                              _model.imageUrl,
                              fit: BoxFit.fill,
                              height: 150,
                              width: 150,
                            )
                          : Image.network(
                              _model.imageUrl,
                              fit: BoxFit.fill,
                              height: 150,
                              width: 200,
                            )
                      : Text('N/A'),
                ),
              ),
              Container(
                height: 150,
                width: 160,
                margin: EdgeInsets.only(
                  left: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _model.name ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        'CHF ${_model.price}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Constants.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 200,
                  child: Center(
                    child: Text(''),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Constants.colorGrey,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        child: Container(
                          height: 40,
                          width: 40,
                          margin: EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text(
                            '-',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                        // icon: Icon(Icons.more_horiz_rounded),
                        onTap: () {
                          Provider.of<CartProvider>(context, listen: false)
                              .decreaseItemQuantity(_model);
                          _updateState();
                        },
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        child: Text(
                          '${_model.quantity}',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          height: 40,
                          width: 40,
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            '+',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                        // icon: Icon(Icons.more_horiz_rounded),
                        onTap: () {
                          Provider.of<CartProvider>(context, listen: false)
                              .increaseItemQuantity(_model);
                          _updateState();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // return ListTile(
    //   title: Text(_model.name ?? ''),
    //   subtitle: Text(
    //     'CHF ${_model.price}',
    //   ),
    //   trailing: Text(
    //     '${_model.quantity}',
    //   ),
    // );
  }
}

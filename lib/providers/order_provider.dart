import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:monuite/helpers/models/orders/order_item_model.dart';

import '../helpers/common/constants.dart';
import '../helpers/models/cart/cart_model.dart';
import '../helpers/models/common/response_model.dart';
import '../helpers/models/orders/order_model.dart';

class OrderProvider with ChangeNotifier {
  OrderModel? _orderModel = null;

  OrderModel? get orderModel {
    return _orderModel;
  }

  Future<void> getOrderModel(String id) async {
    var url = Uri.parse('${Constants.baseUrl}order/get-model/${id}');
    try {
      final response = await http.get(
        url,
        headers: {
          // 'Authorization': 'Bearer $authToken',
          // 'Content-Type': 'application/json'
        },
      );

      switch (response.statusCode) {
        case HttpStatus.ok:
          final value = json.decode(response.body) as dynamic;
          _orderModel = OrderModel.fromJson((value));
          break;
        case HttpStatus.forbidden:
          break;
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<ResponseModel<String>> createOrder(
    CartModel? cartModel,
    String paymentMethod,
  ) async {
    try {
      if (cartModel == null) {
        return ResponseModel(null, 'Cart is empty', true);
      }

      var orderModel = OrderModel(
        cartModel.address!,
        cartModel.items
            .map((e) => OrderItemModel(
                  e!.id,
                  e.variantId.isEmpty ? null : e.variantId,
                  e.imageUrl,
                  e.name,
                  e.variantName,
                  e.price,
                  e.quantity,
                ))
            .toList(),
        cartModel.shippingCost,
        cartModel.couponDiscount,
        paymentMethod,
        cartModel.total,
      );
      final url = Uri.parse('${Constants.baseUrl}order/create');
      var orderModelJson = orderModel.toJson();
      var body = jsonEncode(orderModelJson);
      print(body);
      return await http
          .post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $authToken',
        },
        body: body,
      )
          .then((response) {
        if (response.statusCode == HttpStatus.forbidden) {
          return ResponseModel<String>(null, 'Operation not allowed', true);
        }
        final responseData = json.decode(response.body);
        print(responseData);
        ResponseModel<String> result =
            ResponseModel<String>.fromJson(responseData);
        return result;
      }).onError((error, stackTrace) {
        throw error!;
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> initiateTwintPayment(double amount) async {
    final url = Uri.parse(
        'https://api.twint.ch/payment/initiate'); // Replace with Twint's actual endpoint
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer YOUR_API_KEY', // Replace with your API key
    };
    final body = jsonEncode({
      'amount': amount,
      'currency': 'CHF',
      'description': 'Payment for Order #12345',
      'callbackUrl':
          'https://yourapp.com/callback', // Replace with your callback URL
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('Payment initiated: ${responseData['paymentUrl']}');
      // Redirect user to the payment URL
    } else {
      print('Error initiating payment: ${response.body}');
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:monuite/helpers/models/orders/order_create_response_model.dart';
import 'package:monuite/helpers/models/orders/order_item_model.dart';
import 'package:monuite/helpers/models/orders/order_list_model.dart';
import 'package:monuite/helpers/models/user.dart';

import '../helpers/common/constants.dart';
import '../helpers/models/cart/cart_model.dart';
import '../helpers/models/common/response_model.dart';
import '../helpers/models/orders/order_model.dart';

class OrderProvider with ChangeNotifier {
  final String? authToken;
  final User? user;

  OrderProvider(this.authToken, this.user);

  List<OrderListModel> _orderList = [];

  List<OrderListModel> get orderList {
    return [..._orderList];
  }

  Future<void> populateOrderList(String query) async {
    var url =
        Uri.parse('${Constants.baseUrl}order/get-order-list?query=$query');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      switch (response.statusCode) {
        case HttpStatus.ok:
          final List<dynamic>? extractedData =
              json.decode(response.body) as List<dynamic>;
          final List<OrderListModel> loadedOrders = [];
          if (extractedData != null) {
            extractedData.forEach((value) {
              OrderListModel order = OrderListModel.fromJson((value));
              loadedOrders.add(order);
            });
          }
          _orderList = loadedOrders;
          break;
        case HttpStatus.forbidden:
          break;
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

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
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json'
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

  Future<ResponseModel<OrderCreateResponseModel>> createOrder(
    CartModel? cartModel,
    String paymentMethod,
  ) async {
    try {
      if (cartModel == null) {
        return ResponseModel(null, 'Cart is empty', true);
      }

      if (cartModel.items.isEmpty) {
        return ResponseModel(null, 'Cart is empty', true);
      }

      if (cartModel.address == null ||
          cartModel.address!.fullAddress.trim() == '') {
        return ResponseModel(null, 'Address is required', true);
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
        user?.wpId ?? 0,
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
          return ResponseModel<OrderCreateResponseModel>(
              null, 'Operation not allowed', true);
        }
        final responseData = json.decode(response.body);
        print(responseData);
        ResponseModel<OrderCreateResponseModel> result =
            ResponseModel<OrderCreateResponseModel>.fromJson(responseData);
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

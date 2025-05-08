import 'dart:developer';

import '../addresses/address_model.dart';
import 'cart_item_model.dart';

class CartModel {
  AddressModel address;
  final List<CartItemModel> items;
  double total;
  double shippingCost;
  double couponDiscount;
  double get grandTotal {
    return (total ?? 0) + shippingCost - (couponDiscount ?? 0);
  }

  CartModel(
    this.address,
    this.items,
    this.shippingCost,
    this.total,
  );

  factory CartModel.fromJson(dynamic json) {
    final List<CartItemModel> items = [];
    final exPickups = json['items'] as List<dynamic>;
    if (exPickups != null) {
      exPickups.forEach((value) {
        CartItemModel prod = CartItemModel.fromJson((value));
        items.add(prod);
      });
    }
    final addressJson = json['address'] as dynamic;
    final address = AddressModel.fromJson(addressJson);
    return CartModel(
      address,
      items,
      json['shippingCost'] as double,
      json['price'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address?.toJson(),
      'items': items.map((item) => item.toJson()).toList(),
      'shippingCost': shippingCost,
      'price': total,
    };
  }
}

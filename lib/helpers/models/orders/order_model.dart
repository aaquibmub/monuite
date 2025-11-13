import 'package:monuite/helpers/models/cart/card_information_model.dart';

import '../addresses/address_model.dart';
import 'order_item_model.dart';

class OrderModel {
  CardInformationModel? card;
  AddressModel address;
  final List<OrderItemModel> items;
  int? customerId;
  String paymentMethod;
  double? total;
  double shippingCost;
  double? couponDiscount;
  double get grandTotal {
    return (total ?? 0) + shippingCost - (couponDiscount ?? 0);
  }

  OrderModel(this.address, this.items, this.customerId, this.shippingCost,
      this.couponDiscount, this.paymentMethod, this.total,
      {this.card});

  factory OrderModel.fromJson(dynamic json) {
    final List<OrderItemModel> items = [];
    final List<dynamic>? exPickups = json['items'] as List<dynamic>;
    if (exPickups != null) {
      exPickups.forEach((value) {
        OrderItemModel prod = OrderItemModel.fromJson((value));
        items.add(prod);
      });
    }
    final addressJson = json['address'] as dynamic;
    final address = AddressModel.fromJson(addressJson);
    return OrderModel(
      address,
      items,
      json['customerId'] as int?,
      json['shippingCost'] as double,
      json['couponDiscount'] as double,
      json['paymentMethod'] as String,
      json['total'] as double,
      card: json['card'] != null
          ? CardInformationModel.fromJson(json['card'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address.toJson(),
      'items': items.map((item) => item.toJson()).toList(),
      'customerId': customerId,
      'shippingCost': shippingCost,
      'couponDiscount': couponDiscount ?? 0,
      'paymentMethod': paymentMethod,
      'total': total,
      'grandTotal': grandTotal,
      'card': card?.toJson(),
    };
  }
}

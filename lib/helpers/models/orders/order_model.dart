import '../addresses/address_model.dart';
import 'order_item_model.dart';

class OrderModel {
  AddressModel address;
  final List<OrderItemModel> items;
  String paymentMethod;
  double total;
  double shippingCost;
  double couponDiscount;
  double get grandTotal {
    return (total ?? 0) + shippingCost - (couponDiscount ?? 0);
  }

  OrderModel(
    this.address,
    this.items,
    this.shippingCost,
    this.couponDiscount,
    this.paymentMethod,
    this.total,
  );

  factory OrderModel.fromJson(dynamic json) {
    final List<OrderItemModel> items = [];
    final exPickups = json['items'] as List<dynamic>;
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
      json['shippingCost'] as double,
      json['couponDiscount'] as double,
      json['paymentMethod'] as String,
      json['total'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address.toJson(),
      'items': items.map((item) => item.toJson()).toList(),
      'shippingCost': shippingCost,
      'couponDiscount': couponDiscount ?? 0,
      'paymentMethod': paymentMethod,
      'total': total,
      'grandTotal': grandTotal,
    };
  }
}

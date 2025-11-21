import '../addresses/address_model.dart';
import 'order_item_model.dart';

class OrderModel {
  AddressModel address;
  final List<OrderItemModel> items;
  int? customerId;
  String paymentMethod;
  double? total;
  double shippingCost;
  // double taxRate;
  double taxAmount;
  double? couponDiscount;
  double get grandTotal {
    return (total ?? 0) + shippingCost + taxAmount - (couponDiscount ?? 0);
  }

  OrderModel(
    this.address,
    this.items,
    this.customerId,
    this.shippingCost,
    // this.taxRate,
    this.taxAmount,
    this.couponDiscount,
    this.paymentMethod,
    this.total,
  );

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
      // json['taxRate'] as double,
      json['taxAmount'] as double,
      json['couponDiscount'] as double,
      json['paymentMethod'] as String,
      json['total'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address.toJson(),
      'items': items.map((item) => item.toJson()).toList(),
      'customerId': customerId,
      'shippingCost': shippingCost,
      // 'taxRate': taxRate,
      'taxAmount': taxAmount,
      'couponDiscount': couponDiscount ?? 0,
      'paymentMethod': paymentMethod,
      'total': total,
      'grandTotal': grandTotal,
    };
  }
}

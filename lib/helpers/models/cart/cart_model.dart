import '../addresses/address_model.dart';
import 'cart_item_model.dart';

class CartModel {
  AddressModel? address;
  final List<CartItemModel?> items;
  double? total;
  double shippingCost;
  double taxRate;
  double? couponDiscount;
  double get grandTotal {
    return (total ?? 0) +
        shippingCost +
        shippingTax +
        taxAmount -
        (couponDiscount ?? 0);
  }

  double get taxAmount {
    return (taxRate / 100) * (total ?? 0);
  }

  double get shippingTax {
    return (taxRate / 100) * shippingCost;
  }

  CartModel(
    this.address,
    this.items,
    this.shippingCost,
    this.taxRate,
    this.total,
  );

  factory CartModel.fromJson(dynamic json) {
    final List<CartItemModel> items = [];
    final exPickups =
        json['items'] != null ? json['items'] as List<dynamic> : null;
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
      json['taxRate'] as double,
      json['price'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address?.toJson(),
      'items': items.map((item) => item!.toJson()).toList(),
      'shippingCost': shippingCost,
      'taxRate': taxRate,
      'price': total,
    };
  }
}

import 'package:monuite/helpers/models/orders/order_list_item_model.dart';

class OrderListModel {
  final String id;
  final DateTime orderDate;
  final String orderId;
  final String orderNumber;
  final String status;
  final List<OrderListItemModel> items;
  final String paymentMethod;
  final double total;

  OrderListModel(
    this.id,
    this.orderDate,
    this.orderId,
    this.orderNumber,
    this.status,
    this.items,
    this.paymentMethod,
    this.total,
  );

  factory OrderListModel.fromJson(dynamic json) {
    final List<OrderListItemModel> items = [];
    final List<dynamic>? exPickups = json['items'] as List<dynamic>?;
    if (exPickups != null) {
      exPickups.forEach((value) {
        OrderListItemModel prod = OrderListItemModel.fromJson((value));
        items.add(prod);
      });
    }
    return OrderListModel(
      json['id'] as String,
      DateTime.parse(json['orderDate'] as String),
      json['orderId'] as String,
      json['orderNumber'] as String,
      json['status'] as String,
      items,
      json['paymentMethod'] as String,
      json['total'] as double,
    );
  }
}

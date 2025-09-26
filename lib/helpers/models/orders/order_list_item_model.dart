class OrderListItemModel {
  final String? imageUrl;
  final String name;
  final String variantName;
  final double price;
  int quantity;

  OrderListItemModel(
    this.imageUrl,
    this.name,
    this.variantName,
    this.price,
    this.quantity,
  );

  double get totalPrice => price * quantity;

  factory OrderListItemModel.fromJson(dynamic json) {
    return OrderListItemModel(
      json['imageUrl'] as String,
      json['name'] as String,
      json['variantName'] as String,
      json['price'] as double,
      json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'variantName': variantName,
      'price': price,
      'quantity': quantity,
    };
  }
}

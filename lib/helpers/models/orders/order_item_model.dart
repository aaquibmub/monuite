class OrderItemModel {
  final String id;
  final String? variantId;
  final String? imageUrl;
  final String name;
  final String variantName;
  final double price;
  int quantity;

  OrderItemModel(
    this.id,
    this.variantId,
    this.imageUrl,
    this.name,
    this.variantName,
    this.price,
    this.quantity,
  );

  double get totalPrice => price * quantity;

  factory OrderItemModel.fromJson(dynamic json) {
    return OrderItemModel(
      json['id'] as String,
      json['variantId'] as String,
      json['imageUrl'] as String,
      json['name'] as String,
      json['variantName'] as String,
      json['price'] as double,
      json['quantity'] as int,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'variantId': variantId,
      'imageUrl': imageUrl,
      'name': name,
      'variantName': variantName,
      'price': price,
      'quantity': quantity,
    };
  }
}

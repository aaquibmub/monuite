class ProductListModel {
  final String id;
  final String name;
  final String desc;
  final double price;
  final String? imageUrl;
  final double? groupOfQuantity;
  final double? minAllowedQuantity;
  final double? maxAllowedQuantity;

  ProductListModel(this.id, this.name, this.desc, this.price, this.imageUrl,
      {this.groupOfQuantity, this.minAllowedQuantity, this.maxAllowedQuantity});

  factory ProductListModel.fromJson(dynamic json) => ProductListModel(
        json['id'] as String,
        json['name'] as String,
        json['desc'] as String,
        json['price'] as double,
        json['imageUrl'] as String?,
        groupOfQuantity: json['groupOfQuantity'] != null
            ? (json['groupOfQuantity'] as num).toDouble()
            : null,
        minAllowedQuantity: json['minAllowedQuantity'] != null
            ? (json['minAllowedQuantity'] as num).toDouble()
            : null,
        maxAllowedQuantity: json['maxAllowedQuantity'] != null
            ? (json['maxAllowedQuantity'] as num).toDouble()
            : null,
      );
}

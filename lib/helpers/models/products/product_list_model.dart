class ProductListModel {
  final String id;
  final String name;
  final String desc;
  final double price;
  final String? imageUrl;

  ProductListModel(
    this.id,
    this.name,
    this.desc,
    this.price,
    this.imageUrl,
  );

  factory ProductListModel.fromJson(dynamic json) => ProductListModel(
        json['id'] as String,
        json['name'] as String,
        json['desc'] as String,
        json['price'] as double,
        json['imageUrl'] as String?,
      );
}

class ProductDetailModel {
  final String id;
  final String name;
  final String desc;
  final double price;
  final List<String?>? imageUrls;

  ProductDetailModel(
    this.id,
    this.name,
    this.desc,
    this.price,
    this.imageUrls,
  );

  factory ProductDetailModel.fromJson(dynamic json) {
    final List<String> imageUrls = [];
    final List<dynamic>? exPickups = json['imageUrls'] as List<dynamic>;
    if (exPickups != null) {
      exPickups.forEach((value) {
        imageUrls.add(value as String);
      });
    }

    return ProductDetailModel(
      json['id'] as String,
      json['name'] as String,
      json['desc'] as String,
      json['price'] as double,
      imageUrls,
    );
  }
}

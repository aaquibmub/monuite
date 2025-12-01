import 'package:monuite/helpers/models/products/attribute_model.dart';

class ProductVariationListModel {
  final String id;
  final List<AttributeModel> options;
  final double price;

  ProductVariationListModel(this.id, this.options, this.price);

  factory ProductVariationListModel.fromJson(dynamic json) {
    final List<AttributeModel> attributes = [];
    final List<dynamic>? exOptions = json['options'] as List<dynamic>;
    if (exOptions != null) {
      exOptions.forEach((value) {
        attributes.add(AttributeModel.fromJson(value));
      });
    }
    return ProductVariationListModel(
      json['id'] as String,
      attributes,
      json['price'] as double,
    );
  }
}

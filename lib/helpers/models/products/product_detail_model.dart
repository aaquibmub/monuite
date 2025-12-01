import 'package:monuite/helpers/models/products/attribute_model.dart';
import 'package:monuite/helpers/models/products/product_variation_list_model.dart';

class ProductDetailModel {
  final String id;
  final String name;
  final String desc;
  final double price;
  final List<String?>? imageUrls;
  final List<ProductVariationListModel>? variations;
  final double? groupOfQuantity;
  final double? minAllowedQuantity;
  final double? maxAllowedQuantity;

  List<AttributeModel> get attributes {
    List<AttributeModel> attrs = [];
    if (variations != null && variations!.length > 0) {
      variations!.forEach((variation) {
        variation.options.forEach((option) {
          if (!attrs.any((element) => element.name == option.name)) {
            attrs.add(option);
          }
        });
      });
    }
    return attrs;
  }

  ProductDetailModel(this.id, this.name, this.desc, this.price, this.imageUrls,
      this.variations,
      {this.groupOfQuantity, this.minAllowedQuantity, this.maxAllowedQuantity});

  factory ProductDetailModel.fromJson(dynamic json) {
    final List<String> imageUrls = [];
    final List<dynamic>? exPickups = json['imageUrls'] as List<dynamic>;
    if (exPickups != null) {
      exPickups.forEach((value) {
        imageUrls.add(value as String);
      });
    }
    final List<ProductVariationListModel> variations = [];
    final List<dynamic>? exVariations = json['variations'] as List<dynamic>;
    if (exVariations != null) {
      exVariations.forEach((value) {
        variations.add(ProductVariationListModel.fromJson(value));
      });
    }
    return ProductDetailModel(
      json['id'] as String,
      json['name'] as String,
      json['desc'] as String,
      json['price'] as double,
      imageUrls,
      variations,
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
}

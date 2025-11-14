import 'package:monuite/helpers/models/products/product_list_model.dart';

class CategoryProductListModel {
  final String category;
  final List<ProductListModel> products;

  CategoryProductListModel({
    required this.category,
    required this.products,
  });

  factory CategoryProductListModel.fromJson(Map<String, dynamic> json) {
    final List<ProductListModel> items = [];
    final List<dynamic>? exPickups = json['products'] as List<dynamic>;
    if (exPickups != null) {
      exPickups.forEach((value) {
        ProductListModel prod = ProductListModel.fromJson((value));
        items.add(prod);
      });
    }
    return CategoryProductListModel(
      category: json['category'],
      products: items,
    );
  }
}

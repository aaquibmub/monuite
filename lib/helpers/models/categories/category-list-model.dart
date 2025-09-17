class CategoryListModel {
  final String id;
  final String name;
  final String? imageUrl;

  CategoryListModel(
    this.id,
    this.name,
    this.imageUrl,
  );

  factory CategoryListModel.fromJson(dynamic json) {
    return CategoryListModel(
      json['id'] as String,
      json['name'] as String,
      json['imageUrl'] != null ? json['imageUrl'] as String : null,
    );
  }
}

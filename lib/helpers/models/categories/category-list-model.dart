class CategoryListModel {
  final String id;
  final String name;
  final String? imageUrl;

  CategoryListModel(
    this.id,
    this.name,
    this.imageUrl,
  );

  factory CategoryListModel.fromJson(dynamic json) => CategoryListModel(
        json['id'] as String,
        json['name'] as String,
        json['imageUrl'] as String,
      );
}

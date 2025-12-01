class AttributeModel {
  final int id;
  final String name;
  final String option;

  AttributeModel(this.id, this.name, this.option);
  factory AttributeModel.fromJson(dynamic json) {
    return AttributeModel(
      json['id'] as int,
      json['name'] as String,
      json['option'] as String,
    );
  }
}

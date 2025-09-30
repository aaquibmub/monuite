import 'package:monuite/helpers/models/addresses/address_model.dart';

class AddressBookModel {
  String id;
  bool isDefault;
  AddressModel address;

  AddressBookModel({
    required this.id,
    required this.isDefault,
    required this.address,
  });
  factory AddressBookModel.fromJson(dynamic json) {
    return AddressBookModel(
      id: json['id'] as String,
      isDefault: json['isDefault'] as bool,
      address: AddressModel.fromJson(json['address']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isDefault': isDefault,
      'address': address.toJson(),
    };
  }
}

import 'package:monuite/helpers/models/addresses/address_model.dart';

class AddressBookModel {
  bool isDefault;
  AddressModel address;

  AddressBookModel({
    required this.isDefault,
    required this.address,
  });
  factory AddressBookModel.fromJson(dynamic json) {
    return AddressBookModel(
      isDefault: json['isDefault'] as bool,
      address: AddressModel.fromJson(json['address']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'isDefault': isDefault,
      'address': address.toJson(),
    };
  }
}

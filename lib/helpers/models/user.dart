import 'package:json_annotation/json_annotation.dart';
import 'package:monuite/helpers/models/addresses/address_model.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class User {
  final String id;
  final String? firstName;
  final String? lastName;
  final String email;
  final String userName;
  final AddressModel billing;
  AddressModel shipping;
  int? wpId;

  User({
    required this.id,
    required this.email,
    required this.userName,
    required this.billing,
    required this.shipping,
    this.firstName,
    this.lastName,
    this.wpId,
  });

  factory User.fromJson(dynamic json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      userName: json['userName'] as String,
      billing: AddressModel.fromJson(json['billing'] as Map<String, dynamic>),
      shipping: AddressModel.fromJson(json['shipping'] as Map<String, dynamic>),
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      wpId: json['wpId'] as int?,
    );
  }
  Map<String, dynamic> toJson() => userToJson(this);

  Map<String, dynamic> userToJson(
    User instance,
  ) =>
      <String, dynamic>{
        'id': instance.id,
        'email': instance.email,
        'userName': instance.userName,
        'billing': instance.billing.toJson(),
        'shipping': instance.shipping.toJson(),
        'firstName': instance.firstName,
        'lastName': instance.lastName,
        'wpId': instance.wpId,
      };
}

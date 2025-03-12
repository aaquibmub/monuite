import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class User {
  final String id;
  final String firstName;
  final String lastName;

  User({
    @required this.id,
    @required this.firstName,
    this.lastName,
  });

  factory User.fromJson(dynamic json) {
    return User(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );
  }
  Map<String, dynamic> toJson() => userToJson(this);

  Map<String, dynamic> userToJson(
    User instance,
  ) =>
      <String, dynamic>{
        'id': instance.id,
        'firstName': instance.firstName,
        'lastName': instance.lastName,
      };
}

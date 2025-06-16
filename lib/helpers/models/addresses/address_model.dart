class AddressModel {
  final String country;
  final String first_name;
  final String last_name;
  final String company;
  final String address_1;
  final String address_2;
  final String city;
  final String state;
  final String postcode;
  final String phone;
  final String email;

  AddressModel(
    this.country,
    this.first_name,
    this.last_name,
    this.company,
    this.address_1,
    this.address_2,
    this.city,
    this.state,
    this.postcode,
    this.phone,
    this.email,
  );

  factory AddressModel.fromJson(dynamic json) {
    // if (json == null || json.isEmpty) {
    //   return null;
    // }
    return json == null || json.isEmpty
        ? AddressModel(
            '',
            '',
            '',
            '',
            '',
            '',
            '',
            '',
            '',
            '',
            '',
          )
        : AddressModel(
            json['country'] as String,
            json['first_name'] as String,
            json['last_name'] as String,
            json['company'] as String,
            json['address_1'] as String,
            json['address_2'] as String,
            json['city'] as String,
            json['state'] as String,
            json['postcode'] as String,
            json['phone'] as String,
            json['email'] as String,
          );
  }
  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'first_name': first_name,
      'last_name': last_name,
      'company': company,
      'address_1': address_1,
      'address_2': address_2,
      'city': city,
      'state': state,
      'postcode': postcode,
      'phone': phone,
      'email': email,
    };
  }
}

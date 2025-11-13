class CardInformationModel {
  String? number;
  String? expYear;
  String? expMonth;
  String? cvc;

  CardInformationModel({
    this.number,
    this.expYear,
    this.expMonth,
    this.cvc,
  });

  factory CardInformationModel.fromJson(dynamic json) {
    return CardInformationModel(
      number: json['number'] as String?,
      expYear: json['expYear'] as String?,
      expMonth: json['expMonth'] as String?,
      cvc: json['cvc'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'expYear': expYear,
      'expMonth': expMonth,
      'cvc': cvc,
    };
  }
}

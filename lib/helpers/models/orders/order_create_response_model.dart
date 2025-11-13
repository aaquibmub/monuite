class OrderCreateResponseModel {
  OrderCreateResponseModel({
    required this.orderId,
    this.paymentIntentSecret,
  });

  final String orderId;
  final String? paymentIntentSecret;

  factory OrderCreateResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderCreateResponseModel(
      orderId: json['orderId'] as String,
      paymentIntentSecret: json['paymentIntentSecret'] as String?,
    );
  }
}

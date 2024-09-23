class PromocodeModel {
  String? promocode;
  String? discountPrice;
  String? paybleAmount;
  String? codeId;
  String? status;
  String? message;

  PromocodeModel(
      {this.promocode,
      this.discountPrice,
      this.paybleAmount,
      this.codeId,
      this.status,
      this.message});

  PromocodeModel.fromJson(Map<String, dynamic> json) {
    promocode = json['promocode'];
    discountPrice = json['discount_price'].toString();
    paybleAmount = json['payble_amount'].toString();
    codeId = json['code_id'];
    status = json['status'].toString();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['promocode'] = promocode;
    data['discount_price'] = discountPrice;
    data['payble_amount'] = paybleAmount;
    data['code_id'] = codeId;
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

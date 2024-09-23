import 'package:get/get.dart';
import 'package:new_user_singlevendor/Ui%20View/Home_View/Model/product_model.dart';

class CartModel {
  int? status;
  String? message;
  List<ProductsModel>? productData;
  String? subTotal;
  RxString? discountTotal = "0.00".obs;
  String? gstTotal;
  RxString? grossTotal = "0.00".obs;

  CartModel(
      {this.status,
      this.message,
      this.productData,
      this.subTotal,
      this.discountTotal,
      this.gstTotal,
      this.grossTotal});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      productData = <ProductsModel>[];
      json['data'].forEach((v) {
        productData!.add(ProductsModel.fromJson(v));
      });
    }
    subTotal = json['Sub_Total'];
    discountTotal?.value = json['discount_total'];
    gstTotal = json['gst_total'];
    grossTotal?.value = json['gross_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (productData != null) {
      data['data'] = productData!.map((v) => v.toJson()).toList();
    }
    data['Sub_Total'] = subTotal;
    data['discount_total'] = discountTotal?.value;
    data['gst_total'] = gstTotal;
    data['gross_total'] = grossTotal?.value;
    return data;
  }
}

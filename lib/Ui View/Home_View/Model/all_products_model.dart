import 'package:get/get.dart';

import 'product_model.dart';

class AllProductsModel {
  int? status;
  String? message;
  RxList<ProductsModel>? productData = <ProductsModel>[].obs;

  AllProductsModel({this.status, this.message, this.productData});

  AllProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      productData = <ProductsModel>[].obs;
      json['data'].forEach((v) {
        productData!.add(ProductsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (productData != null) {
      data['data'] = productData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

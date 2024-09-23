import 'package:new_user_singlevendor/Ui%20View/Categories_View/Model/category_model.dart';
import 'package:new_user_singlevendor/Ui%20View/Home_View/Model/product_model.dart';

class SearchModel {
  int? status;
  String? message;
  List<CategoryModel>? category;
  List<ProductsModel>? products;

  SearchModel({this.status, this.message, this.category, this.products});

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['category'] != null) {
      category = <CategoryModel>[];
      json['category'].forEach((v) {
        category!.add(CategoryModel.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <ProductsModel>[];
      json['products'].forEach((v) {
        products!.add(ProductsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

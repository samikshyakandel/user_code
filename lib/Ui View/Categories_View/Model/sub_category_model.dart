import 'package:new_user_singlevendor/Ui%20View/Categories_View/Model/category_model.dart';
import 'package:new_user_singlevendor/Ui%20View/Home_View/Model/product_model.dart';

class SubCategoryModel {
  int? status;
  String? message;
  SubCategoryData? data;

  SubCategoryModel({this.status, this.message, this.data});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? SubCategoryData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SubCategoryData {
  String? intGlcode;
  String? fkParent;
  String? varTitle;
  String? varSlug;
  String? varIcon;
  List<CategoryModel>? subCategory;
  List<ProductsModel>? productList;

  SubCategoryData(
      {this.intGlcode,
      this.fkParent,
      this.varTitle,
      this.varSlug,
      this.varIcon,
      this.subCategory,
      this.productList});

  SubCategoryData.fromJson(Map<String, dynamic> json) {
    intGlcode = json['int_glcode'];
    fkParent = json['fk_parent'];
    varTitle = json['var_title'];
    varSlug = json['var_slug'];
    varIcon = json['var_icon'];
    if (json['subCategory'] != null) {
      subCategory = <CategoryModel>[];
      json['subCategory'].forEach((v) {
        subCategory!.add(CategoryModel.fromJson(v));
      });
    }
    if (json['productList'] != null) {
      productList = <ProductsModel>[];
      json['productList'].forEach((v) {
        productList!.add(ProductsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['int_glcode'] = intGlcode;
    data['fk_parent'] = fkParent;
    data['var_title'] = varTitle;
    data['var_slug'] = varSlug;
    data['var_icon'] = varIcon;
    if (subCategory != null) {
      data['subCategory'] = subCategory!.map((v) => v.toJson()).toList();
    }
    if (productList != null) {
      data['productList'] = productList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

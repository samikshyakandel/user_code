import 'category_model.dart';

class AllCategoryModel {
  int? status;
  String? message;
  List<CategoryModel>? categoryData;

  AllCategoryModel({
    this.status,
    this.message,
    this.categoryData,
  });

  AllCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    if (json['homeCategory'] != null) {
      categoryData = <CategoryModel>[];
      json['homeCategory'].forEach((v) {
        categoryData!.add(CategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (categoryData != null) {
      data['homeCategory'] = categoryData!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

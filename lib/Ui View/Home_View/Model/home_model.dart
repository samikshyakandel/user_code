import '../../Categories_View/Model/category_model.dart';
import 'product_model.dart';

class HomeModel {
  int? status;
  String? message;
  List<HomeBanner>? homeBanner;
  List<CategoryModel>? homeCategory;
  List<ProductsModel>? offerProducts;
  List<ProductsModel>? hotProducts;

  HomeModel(
      {this.status,
      this.message,
      this.homeBanner,
      this.homeCategory,
      this.offerProducts,
      this.hotProducts});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['homeBanner'] != null) {
      homeBanner = <HomeBanner>[];
      json['homeBanner'].forEach((v) {
        homeBanner!.add(HomeBanner.fromJson(v));
      });
    }
    if (json['homeCategory'] != null) {
      homeCategory = <CategoryModel>[];
      json['homeCategory'].forEach((v) {
        homeCategory!.add(CategoryModel.fromJson(v));
      });
    }
    if (json['offerProducts'] != null) {
      offerProducts = <ProductsModel>[];
      json['offerProducts'].forEach((v) {
        offerProducts!.add(ProductsModel.fromJson(v));
      });
    }
    if (json['hotProducts'] != null) {
      hotProducts = <ProductsModel>[];
      json['hotProducts'].forEach((v) {
        hotProducts!.add(ProductsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (homeBanner != null) {
      data['homeBanner'] = homeBanner!.map((v) => v.toJson()).toList();
    }
    if (homeCategory != null) {
      data['homeCategory'] = homeCategory!.map((v) => v.toJson()).toList();
    }
    if (offerProducts != null) {
      data['offerProducts'] = offerProducts!.map((v) => v.toJson()).toList();
    }
    if (hotProducts != null) {
      data['hotProducts'] = hotProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeBanner {
  String? intGlcode;
  String? varTitle;
  String? varTxtDescription;
  String? varImage;

  HomeBanner(
      {this.intGlcode, this.varTitle, this.varTxtDescription, this.varImage});

  HomeBanner.fromJson(Map<String, dynamic> json) {
    intGlcode = json['int_glcode'];
    varTitle = json['var_title'];
    varTxtDescription = json['var_txt_description'];
    varImage = json['var_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['int_glcode'] = intGlcode;
    data['var_title'] = varTitle;
    data['var_txt_description'] = varTxtDescription;
    data['var_image'] = varImage;
    return data;
  }
}

import 'package:get/get.dart';
import 'package:new_user_singlevendor/Ui%20View/Home_View/Model/product_model.dart';

class ProductDetailsModel {
  int? status;
  String? message;
  DetailsData? data;
  List<ProductsModel>? similarCategoryProduct;
  List<ProductReview>? productReview;

  ProductDetailsModel(
      {this.status,
      this.message,
      this.data,
      this.similarCategoryProduct,
      this.productReview});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? DetailsData.fromJson(json['data']) : null;
    if (json['similar_category_product'] != null) {
      similarCategoryProduct = <ProductsModel>[];
      json['similar_category_product'].forEach((v) {
        similarCategoryProduct!.add(ProductsModel.fromJson(v));
      });
    }
    if (json['product_review'] != null) {
      productReview = <ProductReview>[];
      json['product_review'].forEach((v) {
        productReview!.add(ProductReview.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (similarCategoryProduct != null) {
      data['similar_category_product'] =
          similarCategoryProduct!.map((v) => v.toJson()).toList();
    }
    if (productReview != null) {
      data['product_review'] = productReview!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DetailsData {
  String? intGlcode;
  String? skuId;
  String? brand;
  String? brandSlug;
  String? category;
  String? categorySlug;
  String? varTitle;
  String? varSlug;
  String? varImage;
  String? varShortDescription;
  String? txtDescription;
  String? txtNutrition;
  String? includingGstY;
  String? shareUrl;
  String? varGst;
  String? isVariant;
  String? detail;
  String? fkCategory;
  String? fkBrand;
  List<String>? imgs;
  List<ProdOptions>? prodOptions;
  List<VariantDataModel>? variant;
  RxString? like = "N".obs;
  int? totalRatting;
  int? ratting;

  DetailsData(
      {this.intGlcode,
      this.skuId,
      this.brand,
      this.brandSlug,
      this.category,
      this.categorySlug,
      this.varTitle,
      this.varSlug,
      this.varImage,
      this.varShortDescription,
      this.txtDescription,
      this.txtNutrition,
      this.includingGstY,
      this.shareUrl,
      this.varGst,
      this.isVariant,
      this.detail,
      this.fkCategory,
      this.fkBrand,
      this.imgs,
      this.prodOptions,
      this.variant,
      this.like,
      this.totalRatting,
      this.ratting});

  DetailsData.fromJson(Map<String, dynamic> json) {
    intGlcode = json['int_glcode'];
    skuId = json['sku_id'];
    brand = json['brand'];
    brandSlug = json['brand_slug'];
    category = json['category'];
    categorySlug = json['category_slug'];
    varTitle = json['var_title'];
    varSlug = json['var_slug'];
    varImage = json['var_image'];
    varShortDescription = json['var_short_description'];
    txtDescription = json['txt_description'];
    txtNutrition = json['txt_nutrition'];
    includingGstY = json['including_gst_y'];
    shareUrl = json['share_url'];
    varGst = json['var_gst'];
    isVariant = json['is_variant'];
    detail = json['detail'];
    fkCategory = json['fk_category'];
    fkBrand = json['fk_brand'];
    imgs = json['imgs'].cast<String>();
    if (json['prod_options'] != null) {
      prodOptions = <ProdOptions>[];
      json['prod_options'].forEach((v) {
        prodOptions!.add(ProdOptions.fromJson(v));
      });
    }
    if (json['variant'] != null) {
      variant = <VariantDataModel>[];
      json['variant'].forEach((v) {
        variant!.add(VariantDataModel.fromJson(v));
      });
    }
    like?.value = json['like'];
    totalRatting = json['totalRatting'];
    ratting = json['ratting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['int_glcode'] = intGlcode;
    data['sku_id'] = skuId;
    data['brand'] = brand;
    data['brand_slug'] = brandSlug;
    data['category'] = category;
    data['category_slug'] = categorySlug;
    data['var_title'] = varTitle;
    data['var_slug'] = varSlug;
    data['var_image'] = varImage;
    data['var_short_description'] = varShortDescription;
    data['txt_description'] = txtDescription;
    data['including_gst_y'] = includingGstY;
    data['share_url'] = includingGstY;
    data['var_gst'] = varGst;
    data['is_variant'] = isVariant;
    data['detail'] = detail;
    data['fk_category'] = fkCategory;
    data['fk_brand'] = fkBrand;
    data['imgs'] = imgs;
    if (prodOptions != null) {
      data['prod_options'] = prodOptions!.map((v) => v.toJson()).toList();
    }
    if (variant != null) {
      data['variant'] = variant!.map((v) => v.toJson()).toList();
    }
    data['like'] = like?.value;
    data['totalRatting'] = totalRatting;
    data['ratting'] = ratting;

    return data;
  }
}

class ProdOptions {
  String? fkAttribute;
  String? varAttribute;
  List<AttrsV>? attrsV;

  ProdOptions({this.fkAttribute, this.varAttribute, this.attrsV});

  ProdOptions.fromJson(Map<String, dynamic> json) {
    fkAttribute = json['fk_attribute'];
    varAttribute = json['var_attribute'];
    if (json['attrs_v'] != null) {
      attrsV = <AttrsV>[];
      json['attrs_v'].forEach((v) {
        attrsV!.add(AttrsV.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fk_attribute'] = fkAttribute;
    data['var_attribute'] = varAttribute;
    if (attrsV != null) {
      data['attrs_v'] = attrsV!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttrsV {
  String? intGlcode;
  String? varAttributesValues;
  String? fkAttribute;
  String? colorCode;

  AttrsV(
      {this.intGlcode,
      this.varAttributesValues,
      this.fkAttribute,
      this.colorCode});

  AttrsV.fromJson(Map<String, dynamic> json) {
    intGlcode = json['int_glcode'];
    varAttributesValues = json['var_attributes_values'];
    fkAttribute = json['fk_attribute'];
    colorCode = json['colorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['int_glcode'] = intGlcode;
    data['var_attributes_values'] = varAttributesValues;
    data['fk_attribute'] = fkAttribute;
    data['colorCode'] = colorCode;
    return data;
  }
}

class VariantDataModel {
  String? intGlcode;
  String? variantId;
  String? varStock;
  String? varPrice;
  String? sellingPrice;
  String? startDate;
  String? endDate;
  List<String>? variantValues;
  List<String>? variantImgs;
  int? isOffered;
  int? totalRatting;
  int? ratting;
  RxInt? cartItem = 0.obs;

  VariantDataModel(
      {this.intGlcode,
      this.variantId,
      this.varStock,
      this.varPrice,
      this.sellingPrice,
      this.startDate,
      this.endDate,
      this.variantValues,
      this.variantImgs,
      this.isOffered,
      this.totalRatting,
      this.ratting,
      this.cartItem});

  VariantDataModel.fromJson(Map<String, dynamic> json) {
    intGlcode = json['int_glcode'];
    variantId = json['variant_id'];
    varStock = json['var_stock'];
    varPrice = json['var_price'];
    sellingPrice = json['selling_price'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    variantValues = json['variant_values'].cast<String>();
    variantImgs = json['variant_imgs'].cast<String>();
    isOffered = json['is_offered'];
    totalRatting = json['totalRatting'];
    ratting = json['ratting'];
    cartItem?.value = json['cartItem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['int_glcode'] = intGlcode;
    data['variant_id'] = variantId;
    data['var_stock'] = varStock;
    data['var_price'] = varPrice;
    data['selling_price'] = sellingPrice;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['variant_values'] = variantValues;
    data['variant_imgs'] = variantImgs;
    data['is_offered'] = isOffered;
    data['totalRatting'] = totalRatting;
    data['ratting'] = ratting;
    data['cartItem'] = cartItem?.value;
    return data;
  }
}

class ProductReview {
  String? varRating;
  String? varReview;
  String? varName;
  String? dtModifydate;

  ProductReview(
      {this.varRating, this.varReview, this.varName, this.dtModifydate});

  ProductReview.fromJson(Map<String, dynamic> json) {
    varRating = json['var_rating'];
    varReview = json['var_review'];
    varName = json['var_name'];
    dtModifydate = json['dt_modifydate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['var_rating'] = varRating;
    data['var_review'] = varReview;
    data['var_name'] = varName;
    data['dt_modifydate'] = dtModifydate;
    return data;
  }
}

import 'package:get/get.dart';

class ProductsModel {
  String? intGlcode;
  String? fkCategory;
  String? fkBrand;
  String? varTitle;
  String? varSlug;
  String? varOffer;
  String? varImage;
  String? varShortDescription;
  String? txtDescription;
  String? varGst;
  String? isVariant;
  String? varPrice;
  String? sellingPrice;
  String? startDate;
  String? endDate;
  String? varStock;
  String? variantId;
  RxString? like = 'N'.obs;
  int? totalRatting;
  int? ratting;
  VariantDetails? variantDetails;
  RxInt? cartItem = 0.obs;

  ProductsModel(
      {this.intGlcode,
      this.fkCategory,
      this.fkBrand,
      this.varTitle,
      this.varSlug,
      this.varOffer,
      this.varImage,
      this.varShortDescription,
      this.txtDescription,
      this.varGst,
      this.isVariant,
      this.varPrice,
      this.sellingPrice,
      this.startDate,
      this.endDate,
      this.varStock,
      this.variantId,
      this.like,
      this.totalRatting,
      this.ratting,
      this.variantDetails,
      this.cartItem});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    intGlcode = json['int_glcode'];
    fkCategory = json['fk_category'];
    fkBrand = json['fk_brand'];
    varTitle = json['var_title'];
    varSlug = json['var_slug'];
    varOffer = json['var_offer'];
    varImage = json['var_image'];
    varShortDescription = json['var_short_description'];
    txtDescription = json['txt_description'];
    varGst = json['var_gst'];
    isVariant = json['is_variant'];
    varPrice = json['var_price'];
    sellingPrice = json['selling_price'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    varStock = json['var_stock'];
    variantId = json['variant_id'];
    like?.value = json['like'];
    totalRatting = json['totalRatting'];
    ratting = json['ratting'];
    variantDetails = json['Variant_details'] != null
        ? VariantDetails.fromJson(json['Variant_details'])
        : null;
    cartItem?.value = json['cartItem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['int_glcode'] = intGlcode;
    data['fk_category'] = fkCategory;
    data['fk_brand'] = fkBrand;
    data['var_title'] = varTitle;
    data['var_slug'] = varSlug;
    data['var_offer'] = varOffer;
    data['var_image'] = varImage;
    data['var_short_description'] = varShortDescription;
    data['txt_description'] = txtDescription;
    data['var_gst'] = varGst;
    data['is_variant'] = isVariant;
    data['var_price'] = varPrice;
    data['selling_price'] = sellingPrice;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['var_stock'] = varStock;
    data['variant_id'] = variantId;
    data['like'] = like?.value;
    data['totalRatting'] = totalRatting;
    data['ratting'] = ratting;
    if (variantDetails != null) {
      data['Variant_details'] = variantDetails!.toJson();
    }
    data['cartItem'] = cartItem?.value;
    return data;
  }
}

class VariantDetails {
  String? intGlcode;
  String? fkProduct;
  String? variantId;
  String? varStock;
  String? varPrice;
  String? sellingPrice;
  String? startDate;
  String? endDate;

  VariantDetails(
      {this.intGlcode,
      this.fkProduct,
      this.variantId,
      this.varStock,
      this.varPrice,
      this.sellingPrice,
      this.startDate,
      this.endDate});

  VariantDetails.fromJson(Map<String, dynamic> json) {
    intGlcode = json['int_glcode'];
    fkProduct = json['fk_product'];
    variantId = json['variant_id'];
    varStock = json['var_stock'];
    varPrice = json['var_price'];
    sellingPrice = json['selling_price'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['int_glcode'] = intGlcode;
    data['fk_product'] = fkProduct;
    data['variant_id'] = variantId;
    data['var_stock'] = varStock;
    data['var_price'] = varPrice;
    data['selling_price'] = sellingPrice;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    return data;
  }
}

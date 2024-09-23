class OrderDetailsModel {
  int? status;
  String? message;
  OrderDetailsData? data;

  OrderDetailsModel({this.status, this.message, this.data});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? OrderDetailsData.fromJson(json['data']) : null;
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

class OrderDetailsData {
  String? intGlcode;
  String? orderId;
  String? fkUser;
  String? fkDelivery;
  String? varDeliveryMode;
  String? vendorDeliveryTime;
  List<FkProductArr>? fkProductArr;
  String? customizeArr;
  String? varPaymentMode;
  String? chrStatus;
  String? varUserAddress;
  String? dtTimeslot;
  String? vdTimeslot;
  String? chrDeliveryStatus;
  String? dtDeliveryDate;
  String? registerContact;
  String? varAlternateMobile;
  String? varAddressType;
  String? addressId;
  String? varDeliveryCharge;
  String? varWalletAmount;
  String? varDiscountAmount;
  String? varTotalAmount;
  String? varPayableAmount;
  String? convienceFee;
  String? gstPrice;
  String? varCashback;
  String? varPromocode;
  String? varTransactionId;
  String? varVideo;
  String? orderNotes;
  String? varPurchasedFrom;
  String? canceledBy;
  String? chrDelete;
  String? dtCreateddate;
  String? varIpaddress;
  List<ReturnProduct>? returnProduct;

  OrderDetailsData(
      {this.intGlcode,
      this.orderId,
      this.fkUser,
      this.fkDelivery,
      this.varDeliveryMode,
      this.vendorDeliveryTime,
      this.fkProductArr,
      this.customizeArr,
      this.varPaymentMode,
      this.chrStatus,
      this.varUserAddress,
      this.dtTimeslot,
      this.vdTimeslot,
      this.chrDeliveryStatus,
      this.dtDeliveryDate,
      this.registerContact,
      this.varAlternateMobile,
      this.varAddressType,
      this.addressId,
      this.varDeliveryCharge,
      this.varWalletAmount,
      this.varDiscountAmount,
      this.varTotalAmount,
      this.varPayableAmount,
      this.convienceFee,
      this.gstPrice,
      this.varCashback,
      this.varPromocode,
      this.varTransactionId,
      this.varVideo,
      this.orderNotes,
      this.varPurchasedFrom,
      this.canceledBy,
      this.chrDelete,
      this.dtCreateddate,
      this.varIpaddress,
      this.returnProduct});

  OrderDetailsData.fromJson(Map<String, dynamic> json) {
    intGlcode = json['int_glcode'];
    orderId = json['order_id'];
    fkUser = json['fk_user'];
    fkDelivery = json['fk_delivery'];
    varDeliveryMode = json['var_delivery_mode'];
    vendorDeliveryTime = json['vendor_delivery_time'];
    if (json['fk_product_arr'] != null) {
      fkProductArr = <FkProductArr>[];
      json['fk_product_arr'].forEach((v) {
        fkProductArr!.add(FkProductArr.fromJson(v));
      });
    }
    customizeArr = json['customize_arr'];
    varPaymentMode = json['var_payment_mode'];
    chrStatus = json['chr_status'];
    varUserAddress = json['var_user_address'];
    dtTimeslot = json['dt_timeslot'];
    vdTimeslot = json['vd_timeslot'];
    chrDeliveryStatus = json['chr_delivery_status'];
    dtDeliveryDate = json['dt_delivery_date'];
    registerContact = json['register_contact'];
    varAlternateMobile = json['var_alternate_mobile'];
    varAddressType = json['var_address_type'];
    addressId = json['address_id'];
    varDeliveryCharge = json['var_delivery_charge'];
    varWalletAmount = json['var_wallet_amount'];
    varDiscountAmount = json['var_discount_amount'];
    varTotalAmount = json['var_total_amount'];
    varPayableAmount = json['var_payable_amount'];
    convienceFee = json['convience_fee'];
    gstPrice = json['gst_price'];
    varCashback = json['var_cashback'];
    varPromocode = json['var_promocode'];
    varTransactionId = json['var_transaction_id'];
    varVideo = json['var_video'];
    orderNotes = json['order_notes'];
    varPurchasedFrom = json['var_purchased_from'];
    canceledBy = json['canceled_by'];
    chrDelete = json['chr_delete'];
    dtCreateddate = json['dt_createddate'];
    varIpaddress = json['var_ipaddress'];
    if (json['returnProduct'] != null) {
      returnProduct = <ReturnProduct>[];
      json['returnProduct'].forEach((v) {
        returnProduct!.add(ReturnProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['int_glcode'] = intGlcode;
    data['order_id'] = orderId;
    data['fk_user'] = fkUser;
    data['fk_delivery'] = fkDelivery;
    data['var_delivery_mode'] = varDeliveryMode;
    data['vendor_delivery_time'] = vendorDeliveryTime;
    if (fkProductArr != null) {
      data['fk_product_arr'] = fkProductArr!.map((v) => v.toJson()).toList();
    }
    data['customize_arr'] = customizeArr;
    data['var_payment_mode'] = varPaymentMode;
    data['chr_status'] = chrStatus;
    data['var_user_address'] = varUserAddress;
    data['dt_timeslot'] = dtTimeslot;
    data['vd_timeslot'] = vdTimeslot;
    data['chr_delivery_status'] = chrDeliveryStatus;
    data['dt_delivery_date'] = dtDeliveryDate;
    data['register_contact'] = registerContact;
    data['var_alternate_mobile'] = varAlternateMobile;
    data['var_address_type'] = varAddressType;
    data['address_id'] = addressId;
    data['var_delivery_charge'] = varDeliveryCharge;
    data['var_wallet_amount'] = varWalletAmount;
    data['var_discount_amount'] = varDiscountAmount;
    data['var_total_amount'] = varTotalAmount;
    data['var_payable_amount'] = varPayableAmount;
    data['convience_fee'] = convienceFee;
    data['gst_price'] = gstPrice;
    data['var_cashback'] = varCashback;
    data['var_promocode'] = varPromocode;
    data['var_transaction_id'] = varTransactionId;
    data['var_video'] = varVideo;
    data['order_notes'] = orderNotes;
    data['var_purchased_from'] = varPurchasedFrom;
    data['canceled_by'] = canceledBy;
    data['chr_delete'] = chrDelete;
    data['dt_createddate'] = dtCreateddate;
    data['var_ipaddress'] = varIpaddress;
    if (returnProduct != null) {
      data['returnProduct'] = returnProduct!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FkProductArr {
  String? fkProduct;
  String? fkVariant;
  String? varName;
  String? varPrice;
  String? varDiscount;
  String? gstPercentage;
  String? cancelStatus;
  String? gstPrice;
  String? netPrice;
  String? varUnit;
  String? subTotal;
  String? varImage;
  String? review;
  List<Attribute>? attribute;
  int? varQut;

  FkProductArr(
      {this.fkProduct,
      this.fkVariant,
      this.varName,
      this.varPrice,
      this.varDiscount,
      this.gstPercentage,
      this.cancelStatus,
      this.gstPrice,
      this.netPrice,
      this.varUnit,
      this.subTotal,
      this.varImage,
      this.review,
      this.attribute,
      this.varQut});

  FkProductArr.fromJson(Map<String, dynamic> json) {
    fkProduct = json['fk_product'];
    fkVariant = json['fk_variant'];
    varName = json['var_name'];
    varPrice = json['var_price'];
    varDiscount = json['var_discount'];
    gstPercentage = json['gst_percentage'];
    cancelStatus = json['cancel_status'];
    gstPrice = json['gst_price'];
    netPrice = json['net_price'];
    varUnit = json['var_unit'];
    subTotal = json['sub_total'];
    varImage = json['var_image'];
    review = json['review'];
    if (json['attribute'] != null) {
      attribute = <Attribute>[];
      json['attribute'].forEach((v) {
        attribute!.add(Attribute.fromJson(v));
      });
    }
    varQut = json['var_qut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fk_product'] = fkProduct;
    data['fk_variant'] = fkVariant;
    data['var_name'] = varName;
    data['var_price'] = varPrice;
    data['var_discount'] = varDiscount;
    data['gst_percentage'] = gstPercentage;
    data['cancel_status'] = cancelStatus;
    data['gst_price'] = gstPrice;
    data['net_price'] = netPrice;
    data['var_unit'] = varUnit;
    data['sub_total'] = subTotal;
    data['var_image'] = varImage;
    data['review'] = review;
    if (attribute != null) {
      data['attribute'] = attribute!.map((v) => v.toJson()).toList();
    }
    data['var_qut'] = varQut;
    return data;
  }
}

class ReturnProduct {
  String? fkProduct;
  String? fkVariant;
  String? varName;
  String? varPrice;
  String? varDiscount;
  String? gstPercentage;
  String? cancelStatus;
  String? gstPrice;
  String? netPrice;
  int? varUnit;
  String? subTotal;
  String? fkProductArr;
  String? varImage;
  List<Attribute>? attribute;

  ReturnProduct(
      {this.fkProduct,
      this.fkVariant,
      this.varName,
      this.varPrice,
      this.varDiscount,
      this.gstPercentage,
      this.cancelStatus,
      this.gstPrice,
      this.netPrice,
      this.varUnit,
      this.subTotal,
      this.fkProductArr,
      this.varImage,
      this.attribute});

  ReturnProduct.fromJson(Map<String, dynamic> json) {
    fkProduct = json['fk_product'];
    fkVariant = json['fk_variant'];
    varName = json['var_name'];
    varPrice = json['var_price'];
    varDiscount = json['var_discount'];
    gstPercentage = json['gst_percentage'];
    cancelStatus = json['cancel_status'];
    gstPrice = json['gst_price'];
    netPrice = json['net_price'];
    varUnit = json['var_unit'];
    subTotal = json['sub_total'];
    fkProductArr = json['fk_product_arr'];
    varImage = json['var_image'];
    if (json['attribute'] != null) {
      attribute = <Attribute>[];
      json['attribute'].forEach((v) {
        attribute!.add(Attribute.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fk_product'] = fkProduct;
    data['fk_variant'] = fkVariant;
    data['var_name'] = varName;
    data['var_price'] = varPrice;
    data['var_discount'] = varDiscount;
    data['gst_percentage'] = gstPercentage;
    data['cancel_status'] = cancelStatus;
    data['gst_price'] = gstPrice;
    data['net_price'] = netPrice;
    data['var_unit'] = varUnit;
    data['sub_total'] = subTotal;
    data['fk_product_arr'] = fkProductArr;
    data['var_image'] = varImage;
    if (attribute != null) {
      data['attribute'] = attribute!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attribute {
  String? fkAttribute;
  String? fkValue;
  String? varAttribute;
  String? varAttributesValues;

  Attribute(
      {this.fkAttribute,
      this.fkValue,
      this.varAttribute,
      this.varAttributesValues});

  Attribute.fromJson(Map<String, dynamic> json) {
    fkAttribute = json['fk_attribute'];
    fkValue = json['fk_value'];
    varAttribute = json['var_attribute'];
    varAttributesValues = json['var_attributes_values'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fk_attribute'] = fkAttribute;
    data['fk_value'] = fkValue;
    data['var_attribute'] = varAttribute;
    data['var_attributes_values'] = varAttributesValues;
    return data;
  }
}

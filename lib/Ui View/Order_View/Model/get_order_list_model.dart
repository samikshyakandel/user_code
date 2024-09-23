import 'order_details_model.dart';

class GetOrderListModel {
  int? status;
  String? message;
  List<OrderData>? data;

  GetOrderListModel({this.status, this.message, this.data});

  GetOrderListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OrderData>[];
      json['data'].forEach((v) {
        data!.add(OrderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderData {
  String? intGlcode;
  String? orderId;
  String? chrStatus;
  String? varPayableAmount;
  List<FkProductArr>? fkProductArr;
  String? dtCreateddate;
  int? totalProducts;
  String? chrStatusText;

  OrderData(
      {this.intGlcode,
      this.orderId,
      this.chrStatus,
      this.varPayableAmount,
      this.fkProductArr,
      this.dtCreateddate,
      this.totalProducts,
      this.chrStatusText});

  OrderData.fromJson(Map<String, dynamic> json) {
    intGlcode = json['int_glcode'];
    orderId = json['order_id'];
    chrStatus = json['chr_status'];
    varPayableAmount = json['var_payable_amount'];
    if (json['fk_product_arr'] != null) {
      fkProductArr = <FkProductArr>[];
      json['fk_product_arr'].forEach((v) {
        fkProductArr!.add(FkProductArr.fromJson(v));
      });
    }
    dtCreateddate = json['dt_createddate'];
    totalProducts = json['totalProducts'];
    chrStatusText = json['chr_status_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['int_glcode'] = intGlcode;
    data['order_id'] = orderId;
    data['chr_status'] = chrStatus;
    data['var_payable_amount'] = varPayableAmount;
    if (fkProductArr != null) {
      data['fk_product_arr'] = fkProductArr!.map((v) => v.toJson()).toList();
    }
    data['dt_createddate'] = dtCreateddate;
    data['totalProducts'] = totalProducts;
    data['chr_status_text'] = chrStatusText;
    return data;
  }
}

// class FkProductArr {
//   String? fkProduct;
//   String? fkVariant;
//   String? varName;
//   String? varImage;
//   int? varPrice;
//   int? varDiscount;
//   String? gstPercentage;
//   String? cancelStatus;
//   int? gstPrice;
//   int? netPrice;
//   int? varUnit;
//   int? subTotal;

//   FkProductArr(
//       {this.fkProduct,
//       this.fkVariant,
//       this.varName,
//       this.varImage,
//       this.varPrice,
//       this.varDiscount,
//       this.gstPercentage,
//       this.cancelStatus,
//       this.gstPrice,
//       this.netPrice,
//       this.varUnit,
//       this.subTotal});

//   FkProductArr.fromJson(Map<String, dynamic> json) {
//     fkProduct = json['fk_product'];
//     fkVariant = json['fk_variant'];
//     varName = json['var_name'];
//     varImage = json['var_image'];
//     varPrice = json['var_price'];
//     varDiscount = json['var_discount'];
//     gstPercentage = json['gst_percentage'];
//     cancelStatus = json['cancel_status'];
//     gstPrice = json['gst_price'];
//     netPrice = json['net_price'];
//     varUnit = json['var_unit'];
//     subTotal = json['sub_total'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['fk_product'] = fkProduct;
//     data['fk_variant'] = fkVariant;
//     data['var_name'] = varName;
//     data['var_image'] = varImage;
//     data['var_price'] = varPrice;
//     data['var_discount'] = varDiscount;
//     data['gst_percentage'] = gstPercentage;
//     data['cancel_status'] = cancelStatus;
//     data['gst_price'] = gstPrice;
//     data['net_price'] = netPrice;
//     data['var_unit'] = varUnit;
//     data['sub_total'] = subTotal;
//     return data;
//   }
// }

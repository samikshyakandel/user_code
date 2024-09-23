class GetAddressModel {
  int? status;
  String? message;
  List<AddressData>? data;

  GetAddressModel({this.status, this.message, this.data});

  GetAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AddressData>[];
      json['data'].forEach((v) {
        data!.add(AddressData.fromJson(v));
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

class AddressData {
  String? intGlcode;
  String? fkUser;
  String? varHouseNo;
  String? varAppName;
  String? varLandmark;
  String? varCountry;
  String? varState;
  String? varCity;
  String? varPincode;
  String? chrType;
  String? defaultStatus;
  String? chrPublish;
  String? chrDelete;
  String? dtCreateddate;
  String? dtModifydate;
  String? varIpaddress;

  AddressData(
      {this.intGlcode,
        this.fkUser,
        this.varHouseNo,
        this.varAppName,
        this.varLandmark,
        this.varCountry,
        this.varState,
        this.varCity,
        this.varPincode,
        this.chrType,
        this.defaultStatus,
        this.chrPublish,
        this.chrDelete,
        this.dtCreateddate,
        this.dtModifydate,
        this.varIpaddress});

  AddressData.fromJson(Map<String, dynamic> json) {
    intGlcode = json['int_glcode'];
    fkUser = json['fk_user'];
    varHouseNo = json['var_house_no'];
    varAppName = json['var_app_name'];
    varLandmark = json['var_landmark'];
    varCountry = json['var_country'];
    varState = json['var_state'];
    varCity = json['var_city'];
    varPincode = json['var_pincode'];
    chrType = json['chr_type'];
    defaultStatus = json['default_status'];
    chrPublish = json['chr_publish'];
    chrDelete = json['chr_delete'];
    dtCreateddate = json['dt_createddate'];
    dtModifydate = json['dt_modifydate'];
    varIpaddress = json['var_ipaddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['int_glcode'] = intGlcode;
    data['fk_user'] = fkUser;
    data['var_house_no'] = varHouseNo;
    data['var_app_name'] = varAppName;
    data['var_landmark'] = varLandmark;
    data['var_country'] = varCountry;
    data['var_state'] = varState;
    data['var_city'] = varCity;
    data['var_pincode'] = varPincode;
    data['chr_type'] = chrType;
    data['default_status'] = defaultStatus;
    data['chr_publish'] = chrPublish;
    data['chr_delete'] = chrDelete;
    data['dt_createddate'] = dtCreateddate;
    data['dt_modifydate'] = dtModifydate;
    data['var_ipaddress'] = varIpaddress;
    return data;
  }
}
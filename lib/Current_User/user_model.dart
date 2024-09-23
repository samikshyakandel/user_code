class UserModel {
  int? status;
  String? message;
  Data? data;
  String? userId;

  UserModel({this.status, this.message, this.data, this.userId});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['user_id'] = userId;
    return data;
  }
}

class Data {
  String? userId;
  String? varName;
  String? varEmail;
  String? varMobileNo;
  String? varAltMobile;
  String? varDefaultNo;
  String? varImage;
  String? chrVerify;
  String? refferalCode;
  String? varDob;
  String? chrGender;

  Data(
      {this.userId,
      this.varName,
      this.varEmail,
      this.varMobileNo,
      this.varAltMobile,
      this.varDefaultNo,
      this.varImage,
      this.chrVerify,
      this.refferalCode,
        this.varDob,
        this.chrGender});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    varName = json['var_name'];
    varEmail = json['var_email'];
    varMobileNo = json['var_mobile_no'];
    varAltMobile = json['var_alt_mobile'];
    varDefaultNo = json['var_default_no'];
    varImage = json['var_image'];
    chrVerify = json['chr_verify'];
    refferalCode = json['refferal_code'];
    varDob = json['var_dob'];
    chrGender = json['chr_gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['var_name'] = varName;
    data['var_email'] = varEmail;
    data['var_mobile_no'] = varMobileNo;
    data['var_alt_mobile'] = varAltMobile;
    data['var_default_no'] = varDefaultNo;
    data['var_image'] = varImage;
    data['chr_verify'] = chrVerify;
    data['refferal_code'] = refferalCode;
    data['var_dob'] = varDob;
    data['chr_gender'] = chrGender;
    return data;
  }
}

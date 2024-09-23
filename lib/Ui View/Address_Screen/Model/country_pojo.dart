class CountryModel {
  int? status;
  String? message;
  List<CountryListData>? data;

  CountryModel({this.status, this.message, this.data});

  CountryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CountryListData>[];
      json['data'].forEach((v) {
        data!.add(CountryListData.fromJson(v));
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

class CountryListData {
  String? intGlcode;
  String? code;
  String? name;

  CountryListData({this.intGlcode, this.code, this.name});

  CountryListData.fromJson(Map<String, dynamic> json) {
    intGlcode = json['int_glcode'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['int_glcode'] = intGlcode;
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}
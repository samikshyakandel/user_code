class StateListModel {
  int? status;
  String? message;
  List<StateListData>? data;

  StateListModel({this.status, this.message, this.data});

  StateListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StateListData>[];
      json['data'].forEach((v) {
        data!.add(StateListData.fromJson(v));
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

class StateListData {
  String? id;
  String? stateName;
  String? stateCode;
  String? countryCode;

  StateListData({this.id, this.stateName, this.stateCode, this.countryCode});

  StateListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateName = json['state_name'];
    stateCode = json['state_code'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['state_name'] = stateName;
    data['state_code'] = stateCode;
    data['country_code'] = countryCode;
    return data;
  }
}
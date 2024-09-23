class FilterAttributeModel {
  int? status;
  String? message;
  List<AttributeData>? data;

  FilterAttributeModel({this.status, this.message, this.data});

  FilterAttributeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AttributeData>[];
      json['data'].forEach((v) {
        data!.add(AttributeData.fromJson(v));
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

class AttributeData {
  String? id;
  String? title;
  List<AttributeList>? attributeList;

  AttributeData({this.id, this.title, this.attributeList});

  AttributeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['list'] != null) {
      attributeList = <AttributeList>[];
      json['list'].forEach((v) {
        attributeList!.add(AttributeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    if (attributeList != null) {
      data['list'] = attributeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttributeList {
  String? id;
  String? value;

  AttributeList({this.id, this.value});

  AttributeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    return data;
  }
}

class CategoryModel {
  String? intGlcode;
  String? fkParent;
  String? varTitle;
  String? varSlug;
  String? varIcon;

  CategoryModel(
      {this.intGlcode,
      this.fkParent,
      this.varTitle,
      this.varSlug,
      this.varIcon});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    intGlcode = json['int_glcode'];
    fkParent = json['fk_parent'];
    varTitle = json['var_title'];
    varSlug = json['var_slug'];
    varIcon = json['var_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['int_glcode'] = intGlcode;
    data['fk_parent'] = fkParent;
    data['var_title'] = varTitle;
    data['var_slug'] = varSlug;
    data['var_icon'] = varIcon;
    return data;
  }
}

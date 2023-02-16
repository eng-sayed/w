class PromoCodeModel {
  int? id;
  String? name;
  String? code;
  String? type;
  int? value;

  PromoCodeModel({this.id, this.name, this.code, this.type, this.value});

  PromoCodeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

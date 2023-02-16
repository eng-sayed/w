class CountriesModel {
  int? id;
  String? name;
  int? hasDelivery;
  String? flag;

  CountriesModel({this.id, this.name, this.hasDelivery, this.flag});

  CountriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hasDelivery = json['has_delivery'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['has_delivery'] = this.hasDelivery;
    data['flag'] = this.flag;
    return data;
  }
}

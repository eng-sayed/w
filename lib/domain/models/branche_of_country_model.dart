class BranchesOfCountriesModel {
  int? id;
  String? name;
  String? address;
  String? phones;
  String? location_url;
  String? close_time;
  String? open_time;

  BranchesOfCountriesModel(
      {this.id,
      this.name,
      this.location_url,
      this.address,
      this.phones,
      this.open_time,
      this.close_time});

  BranchesOfCountriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phones = json['phones'];
    location_url = json['location_url'];
    close_time = json['close_time'];
    open_time = json['open_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['location_url'] = this.location_url;
    data['phones'] = this.phones;
    data['open_time'] = this.open_time;
    data['close_time'] = this.close_time;
    return data;
  }
}

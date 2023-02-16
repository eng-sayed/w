class ModelsCarsModel {
  int? id;
  String? name;
  String? coverImage;
  Brand? brand;
  List<String>? gallery;

  ModelsCarsModel(
      {this.id, this.name, this.coverImage, this.brand, this.gallery});

  ModelsCarsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coverImage = json['cover_image'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    gallery = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cover_image'] = this.coverImage;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    data['images'] = this.gallery;
    return data;
  }
}

class Brand {
  int? id;
  String? name;
  String? logo;

  Brand({this.id, this.name, this.logo});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}

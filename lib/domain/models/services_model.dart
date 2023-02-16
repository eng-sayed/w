// class ServicesModel {
//   int? id;
//   String? name;
//   String? image;
//   String? description;
//   String? shortDescription;
//   List<SubServices>? subServices;

//   ServicesModel(
//       {this.id,
//       this.name,
//       this.image,
//       this.description,
//       this.shortDescription,
//       this.subServices});

//   ServicesModel.fromJson(json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//     description = json['description'];
//     shortDescription = json['short_description'];
//     if (json['sub_services'] != null) {
//       subServices = <SubServices>[];
//       json['sub_services'].forEach((v) {
//         subServices!.add(new SubServices.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     data['description'] = this.description;
//     data['short_description'] = this.shortDescription;
//     if (this.subServices != null) {
//       data['sub_services'] = this.subServices!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class SubServices {
//   int? id;
//   String? name;
//   double? price;
//   int? insurancePeriod;
//   String? image;
//   String? description;
//   String? shortDescription;

//   SubServices(
//       {this.id,
//       this.name,
//       this.price,
//       this.insurancePeriod,
//       this.image,
//       this.description,
//       this.shortDescription});

//   SubServices.fromJson(json) {
//     id = json['id'];
//     name = json['name'];
//     price = json['price'];
//     insurancePeriod = json['insurance_period'];
//     image = json['image'];
//     description = json['description'];
//     shortDescription = json['short_description'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['price'] = this.price;
//     data['insurance_period'] = this.insurancePeriod;
//     data['image'] = this.image;
//     data['description'] = this.description;
//     data['short_description'] = this.shortDescription;
//     return data;
//   }
// }

class ServicesModel {
  int? id;
  String? name;
  String? image;
  String? description;
  String? shortDescription;
  List<SubServices>? subServices;

  ServicesModel(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.shortDescription,
      this.subServices});

  ServicesModel.fromJson(json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    shortDescription = json['short_description'];
    if (json['sub_services'] != null) {
      subServices = <SubServices>[];
      json['sub_services'].forEach((v) {
        subServices!.add(new SubServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['short_description'] = this.shortDescription;
    if (this.subServices != null) {
      data['sub_services'] = this.subServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubServices {
  int? id;
  int? parent_id;
  String? name;
  num? price;
  int? insurancePeriod;
  String? image;
  Offer? offer;
  String? description;
  String? shortDescription;

  SubServices(
      {this.id,
      this.name,
      this.parent_id,
      this.price,
      this.insurancePeriod,
      this.image,
      this.offer,
      this.description,
      this.shortDescription});

  SubServices.fromJson(json) {
    id = json['id'];
    name = json['name'];
    parent_id = json['parent_id'];
    price = json['price'];
    insurancePeriod = json['insurance_period'];
    image = json['image'];
    offer = json['offer'] != null ? new Offer.fromJson(json['offer']) : null;
    description = json['description'];
    shortDescription = json['short_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parent_id;
    data['price'] = this.price;
    data['insurance_period'] = this.insurancePeriod;
    data['image'] = this.image;
    if (this.offer != null) {
      data['offer'] = this.offer!.toJson();
    }
    data['description'] = this.description;
    data['short_description'] = this.shortDescription;
    return data;
  }
}

class Offer {
  num? priceBefore;
  num? priceAfter;
  int? percentage;
  List<String>? gifts;

  Offer({this.priceBefore, this.priceAfter, this.percentage, this.gifts});

  Offer.fromJson(json) {
    priceBefore = json['price_before'];
    priceAfter = json['price_after'];
    percentage = json['percentage'];
    gifts = json['gifts'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price_before'] = this.priceBefore;
    data['price_after'] = this.priceAfter;
    data['percentage'] = this.percentage;
    data['gifts'] = this.gifts;
    return data;
  }
}

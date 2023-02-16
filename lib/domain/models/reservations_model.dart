class ReservationsModel {
  int? id;
  String? notes;
  String? type;
  String? status;
  String? receipt_image;
  String? insurance_image;
  Car? car;
  String? reservationDate;
  Branch? branch;
  List<SubServices>? subServices;
  List<Progress>? progress;

  ReservationsModel(
    this.id,
    this.notes,
    this.type,
    this.status,
    this.insurance_image,
    this.receipt_image,
    this.car,
    this.reservationDate,
    this.branch,
    this.subServices,
    this.progress,
  );

  ReservationsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notes = json['notes'];
    type = json['type'];
    status = json['status'];
    receipt_image = json['receipt_image'];
    insurance_image = json['insurance_image'];
    car = json['car'] != null ? new Car.fromJson(json['car']) : null;
    reservationDate = json['reservation_date'];
    branch =
        json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
    if (json['sub_services'] != null) {
      subServices = <SubServices>[];
      json['sub_services'].forEach((v) {
        subServices!.add(new SubServices.fromJson(v));
      });
    }
    if (json['progress'] != null) {
      progress = <Progress>[];
      json['progress'].forEach((v) {
        progress!.add(new Progress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notes'] = this.notes;
    data['type'] = this.type;
    data['insurance_image'] = this.insurance_image;
    data['receipt_image'] = this.receipt_image;
    data['status'] = this.status;
    if (this.car != null) {
      data['car'] = this.car!.toJson();
    }
    data['reservation_date'] = this.reservationDate;
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    if (this.subServices != null) {
      data['sub_services'] = this.subServices!.map((v) => v.toJson()).toList();
    }
    if (this.progress != null) {
      data['progress'] = this.progress!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Car {
  int? id;
  String? image;
  String? notes;
  int? kilometers;
  String? plateNumber;
  Brand? brand;
  Model? model;

  Car(
      {this.id,
      this.image,
      this.notes,
      this.kilometers,
      this.plateNumber,
      this.brand,
      this.model});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    notes = json['notes'];
    kilometers = json['kilometers'];
    plateNumber = json['plate_number'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    model = json['model'] != null ? new Model.fromJson(json['model']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['notes'] = this.notes;
    data['kilometers'] = this.kilometers;
    data['plate_number'] = this.plateNumber;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    if (this.model != null) {
      data['model'] = this.model!.toJson();
    }
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

class Model {
  int? id;
  String? name;
  String? coverImage;
  Brand? brand;

  Model({this.id, this.name, this.coverImage, this.brand});

  Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coverImage = json['cover_image'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cover_image'] = this.coverImage;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    return data;
  }
}

class Branch {
  int? id;
  String? name;
  String? address;
  String? phones;

  Branch({this.id, this.name, this.address, this.phones});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phones = json['phones'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phones'] = this.phones;
    return data;
  }
}

class SubServices {
  int? id;
  int? parent_id;
  String? name;
  String? image;
  String? description;
  String? shortDescription;
  List<Null>? subServices;

  SubServices(
      {this.id,
      this.parent_id,
      this.name,
      this.image,
      this.description,
      this.shortDescription,
      this.subServices});

  SubServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parent_id = json['parent_id'];
    image = json['image'];
    description = json['description'];
    shortDescription = json['short_description'];
    if (json['sub_services'] != null) {
      subServices = <Null>[];
      //TODO json['sub_services'].forEach((v) {
      //   subServices!.add(new Null.fromJson(v));
      // });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parent_id;
    data['image'] = this.image;
    data['description'] = this.description;
    data['short_description'] = this.shortDescription;
    // if (this.subServices != null) {
    //   data['sub_services'] = this.subServices!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Progress {
  String? name;
  String? status;
  String? icon;
  String? generalNotes;
  List<PartsDetails>? partsDetails;

  Progress(
      {this.name,
      this.status,
      this.generalNotes,
      this.partsDetails,
      this.icon});

  Progress.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
    generalNotes = json['general_notes'];
    icon = json['icon'];
    if (json['parts_details'] != null) {
      partsDetails = <PartsDetails>[];
      json['parts_details'].forEach((v) {
        partsDetails!.add(new PartsDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['status'] = this.status;
    data['general_notes'] = this.generalNotes;
    if (this.partsDetails != null) {
      data['parts_details'] =
          this.partsDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PartsDetails {
  String? name;
  String? image;
  String? notes;
  List<String>? gallery;

  PartsDetails({this.name, this.image, this.notes, this.gallery});

  PartsDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    notes = json['notes'];
    gallery = json['gallery'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['notes'] = this.notes;
    data['gallery'] = this.gallery;
    return data;
  }
}

import 'dart:io';

import 'package:dio/dio.dart';

class ComplainsModel {
  String? notes;
  List<File>? images;
  int? car_id;
  int? service_id;
  int? part_id;

  ComplainsModel({
    this.images,
    this.notes,
    this.service_id,
    this.part_id,
    this.car_id,
  });

  ComplainsModel.fromJson(Map<String, dynamic> json) {
    notes = json['notes'];
    images = json['images'];
    part_id = json['part_id'];
    service_id = json['service_id'];
    car_id = json['car_id'];
  }

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['notes'] = this.notes;
    data['part_id'] = this.part_id;
    data['service_id'] = this.service_id;
    data['car_id'] = this.car_id;
    if (this.images != null) {
      print("323232" + images!.length.toString());
      data['images[]'] = [
        for (int i = 0; i < (this.images ?? []).length; i++)
          await MultipartFile.fromFile((this.images ?? [])[i].path)
      ];

      // data['images[]'] = this
      //     .images
      //     ?.map((element) async => await MultipartFile.fromFile(element.path))
      //     .toList();

      // for (int i = 0; i < {this.images ?? []}.length; i++) {
      //   data['images[]']
      //       .add(await MultipartFile.fromFile((this.images ?? [])[i].path));
      // }
      // this.images?.forEach((element) async {
      // data['images[]']
      //     .toList()
      //     .add(await MultipartFile.fromFile(element.path));
      // });
    }
    return data;
  }

  ComplainsModel copyWith({
    String? notes,
    List<File>? images,
    int? car_id,
    int? service_id,
    int? part_id,
  }) {
    return ComplainsModel(
      images: images ?? this.images,
      notes: notes ?? this.notes,
      part_id: part_id ?? this.part_id,
      service_id: service_id ?? this.service_id,
      car_id: car_id ?? this.car_id,
    );
  }
}

class ComplainModel {
  int? id;
  String? notes;
  Service? service;
  User? user;
  Part? part;
  Car? car;
  List<Replies>? replies;
  List<String>? images;

  ComplainModel(
      {this.id,
      this.notes,
      this.service,
      this.user,
      this.part,
      this.car,
      this.replies,
      this.images});

  ComplainModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notes = json['notes'];
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    part = json['part'] != null ? new Part.fromJson(json['part']) : null;
    car = json['car'] != null ? new Car.fromJson(json['car']) : null;
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notes'] = this.notes;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.part != null) {
      data['part'] = this.part!.toJson();
    }
    if (this.car != null) {
      data['car'] = this.car!.toJson();
    }
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    data['images'] = this.images;
    return data;
  }
}

class Service {
  int? id;
  String? name;
  String? image;
  String? description;
  String? shortDescription;

  Service({
    this.id,
    this.name,
    this.image,
    this.description,
    this.shortDescription,
  });

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    shortDescription = json['short_description'];
    // if (json['sub_services'] != null) {
    //   subServices = <Null>[];
    //   json['sub_services'].forEach((v) {
    //     subServices!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['short_description'] = this.shortDescription;
    // if (this.subServices != null) {
    //   data['sub_services'] = this.subServices!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? avatar;
  String? birthDate;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.avatar,
      this.birthDate});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
    birthDate = json['birth_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['birth_date'] = this.birthDate;
    return data;
  }
}

class Part {
  int? id;
  String? name;

  Part({this.id, this.name});

  Part.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Car {
  int? id;
  String? image;
  String? notes;
  int? year;
  int? kilometers;
  String? plateNumber;
  bool? hasMaintenance;
  bool? hasComplain;
  Brand? brand;
  Model? model;
  bool? selling;

  Car(
      {this.id,
      this.image,
      this.notes,
      this.year,
      this.kilometers,
      this.plateNumber,
      this.hasMaintenance,
      this.hasComplain,
      this.brand,
      this.model,
      this.selling});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    notes = json['notes'];
    year = json['year'];
    kilometers = json['kilometers'];
    plateNumber = json['plate_number'];
    hasMaintenance = json['has_maintenance'];
    hasComplain = json['has_complain'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    model = json['model'] != null ? new Model.fromJson(json['model']) : null;
    selling = json['selling'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['notes'] = this.notes;
    data['year'] = this.year;
    data['kilometers'] = this.kilometers;
    data['plate_number'] = this.plateNumber;
    data['has_maintenance'] = this.hasMaintenance;
    data['has_complain'] = this.hasComplain;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    if (this.model != null) {
      data['model'] = this.model!.toJson();
    }
    data['selling'] = this.selling;
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
  List<String>? gallery;

  Model({this.id, this.name, this.coverImage, this.brand, this.gallery});

  Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coverImage = json['cover_image'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    gallery = json['gallery'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cover_image'] = this.coverImage;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    data['gallery'] = this.gallery;
    return data;
  }
}

class Replies {
  int? id;
  int? complaintId;
  String? reply;
  String? createdAt;
  String? updatedAt;

  Replies(
      {this.id, this.complaintId, this.reply, this.createdAt, this.updatedAt});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    complaintId = json['complaint_id'];
    reply = json['reply'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['complaint_id'] = this.complaintId;
    data['reply'] = this.reply;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

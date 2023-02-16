import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:supa_kota/domain/models/reservations_model.dart';

class MyCarsModel {
  int? id;
  String? image;
  File? imageCar;
  String? notes;
  int? kilometers;
  int? model_id;
  int? brand_id;
  String? plateNumber;
  Brand? brand;
  int? year;
  bool? selling;
  bool? has_active_reservation;
  bool? can_complaint;
  Model? model;
  List<ReservationsModel>? reservations;

  MyCarsModel(
      {this.id,
      this.image,
      this.can_complaint,
      this.has_active_reservation,
      this.notes,
      this.year,
      this.kilometers,
      this.plateNumber,
      this.brand_id,
      this.model_id,
      this.brand,
      this.reservations,
      this.selling,
      this.imageCar,
      this.model});

  MyCarsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    year = json['year'];
    has_active_reservation = json['has_active_reservation'];
    can_complaint = json['can_complaint'];
    notes = json['notes'];
    kilometers = json['kilometers'];
    selling = json['selling'];
    plateNumber = json['plate_number'];
    if (json['reservations'] != null) {
      reservations = <ReservationsModel>[];
      json['reservations'].forEach((v) {
        reservations!.add(new ReservationsModel.fromJson(v));
      });
    }
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    model = json['model'] != null ? new Model.fromJson(json['model']) : null;
  }

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['selling'] = this.selling;
    data['year'] = this.year;
    data['can_complaint'] = this.can_complaint;
    data['has_active_reservation'] = this.has_active_reservation;
    data['brand_id'] = this.brand_id;
    data['model_id'] = this.model_id;
    data['id'] = this.id;
    data['image'] = this.image;
    data['notes'] = this.notes;
    data['kilometers'] = this.kilometers;
    data['plate_number'] = this.plateNumber;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    if (this.reservations != null) {
      data['reservations'] = this.reservations!.map((v) => v.toJson()).toList();
    }
    if (this.model != null) {
      data['model'] = this.model!.toJson();
    }
    data['imageCar'] = await MultipartFile.fromFile(this.imageCar?.path ?? "");
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

class HasComplainAndReserVationsModel {
  bool? can_complaint;
  bool? has_active_reservation;
  HasComplainAndReserVationsModel({
    this.can_complaint,
    this.has_active_reservation,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (can_complaint != null) {
      result.addAll({'can_complaint': can_complaint});
    }
    if (has_active_reservation != null) {
      result.addAll({'has_active_reservation': has_active_reservation});
    }

    return result;
  }

  factory HasComplainAndReserVationsModel.fromMap(Map<String, dynamic> map) {
    return HasComplainAndReserVationsModel(
      can_complaint: map['can_complaint'],
      has_active_reservation: map['has_active_reservation'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HasComplainAndReserVationsModel.fromJson(String source) =>
      HasComplainAndReserVationsModel.fromMap(json.decode(source));
}

class Reservations {
  int? id;
  String? notes;
  String? type;
  String? status;
  String? reservationDate;
  Branch? branch;
  List<SubServices>? subServices;

  Reservations(
      {this.id,
      this.notes,
      this.type,
      this.status,
      this.reservationDate,
      this.branch,
      this.subServices});

  Reservations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notes = json['notes'];
    type = json['type'];
    status = json['status'];
    reservationDate = json['reservation_date'];
    branch =
        json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
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
    data['notes'] = this.notes;
    data['type'] = this.type;
    data['status'] = this.status;
    data['reservation_date'] = this.reservationDate;
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    if (this.subServices != null) {
      data['sub_services'] = this.subServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

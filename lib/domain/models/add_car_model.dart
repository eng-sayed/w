import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class AddCarModel {
  String? notes;
  String? brand_id;
  String? model_id;
  String? kilometers;
  String? plate_number;
  File? uploadImage;
  String? image;
  int? year;

  AddCarModel(
      {this.notes,
      this.brand_id,
      this.model_id,
      this.kilometers,
      this.plate_number,
      this.image,
      this.year,
      this.uploadImage});

  Future<Map<String, dynamic>> toMap() async {
    final result = <String, dynamic>{};

    if (notes != null) {
      result.addAll({'notes': notes});
    }
    if (year != null) {
      result.addAll({'year': year});
    }
    if (brand_id != null) {
      result.addAll({'brand_id': brand_id});
    }
    if (model_id != null) {
      result.addAll({'model_id': model_id});
    }
    if (kilometers != null) {
      result.addAll({'kilometers': kilometers});
    }
    if (plate_number != null) {
      result.addAll({'plate_number': plate_number});
    }

    if (image != null) {
      result.addAll({'image': image});
    }
    if (uploadImage != null) {
      result['image'] = await MultipartFile.fromFile(uploadImage?.path ?? "");
    }
    return result;
  }

  factory AddCarModel.fromMap(Map<String, dynamic> map) {
    return AddCarModel(
      notes: map['notes'],
      year: map['year'],
      brand_id: map['brand_id'],
      model_id: map['model_id'],
      kilometers: map['kilometers'],
      plate_number: map['plate_number'],
      image: map['image'],
    );
  }

  factory AddCarModel.fromJson(String source) =>
      AddCarModel.fromMap(json.decode(source));

  AddCarModel copyWith({
    String? notes,
    String? brand_id,
    String? model_id,
    String? kilometers,
    String? plate_number,
    File? uploadImage,
    String? image,
    int? year,
  }) {
    return AddCarModel(
      notes: notes ?? this.notes,
      brand_id: brand_id ?? this.brand_id,
      model_id: model_id ?? this.model_id,
      kilometers: kilometers ?? this.kilometers,
      plate_number: plate_number ?? this.plate_number,
      uploadImage: uploadImage ?? this.uploadImage,
      image: image ?? this.image,
      year: year ?? this.year,
    );
  }
}

class UpdateCarModel {
  String? notes;
  String? brand_id;
  String? model_id;
  String? kilometers;
  String? plate_number;
  int? year;

  UpdateCarModel({
    this.notes,
    this.brand_id,
    this.model_id,
    this.kilometers,
    this.year,
    this.plate_number,
  });

  Future<Map<String, dynamic>> toMap() async {
    final Map<String, dynamic> result = new Map<String, dynamic>();
    if (notes != null) {
      result.addAll({'notes': notes});
    }
    if (brand_id != null) {
      result.addAll({'brand_id': brand_id});
    }
    if (model_id != null) {
      result.addAll({'model_id': model_id});
    }
    if (kilometers != null) {
      result.addAll({'kilometers': kilometers});
    }
    if (year != null) {
      result.addAll({'year': year});
    }
    if (plate_number != null) {
      result.addAll({'plate_number': plate_number});
    }

    return result;
  }

  factory UpdateCarModel.fromMap(Map<String, dynamic> map) {
    return UpdateCarModel(
      notes: map['notes'],
      brand_id: map['brand_id'],
      year: map['year'],
      model_id: map['model_id'],
      kilometers: map['kilometers'],
      plate_number: map['plate_number'],
    );
  }

  factory UpdateCarModel.fromJson(String source) =>
      UpdateCarModel.fromMap(json.decode(source));

  UpdateCarModel copyWith({
    String? notes,
    String? brand_id,
    String? model_id,
    String? kilometers,
    String? plate_number,
  }) {
    return UpdateCarModel(
      notes: notes ?? this.notes,
      brand_id: brand_id ?? this.brand_id,
      model_id: model_id ?? this.model_id,
      kilometers: kilometers ?? this.kilometers,
      plate_number: plate_number ?? this.plate_number,
    );
  }
}

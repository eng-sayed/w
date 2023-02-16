import 'dart:io';

import 'package:dio/dio.dart';

class AuthModel {
  Data? data;

  AuthModel({this.data});

  AuthModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  User? user;

  Data({this.token, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  bool? is_partner;
  int? city_id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? avatar;
  String? device_token;
  String? birth_date;
  File? image;

  User(
      {this.id,
      this.name,
      this.email,
      this.city_id,
      this.is_partner,
      this.phone,
      this.password,
      this.avatar,
      this.image,
      this.birth_date,
      this.device_token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    is_partner = json['is_partner'];
    email = json['email'];
    password = json['password'];
    city_id = json['city_id'];
    birth_date = json['birth_date'];
    phone = json['phone'];
    avatar = json['avatar'];
    device_token = json['device_token'];
    image = json['image'];
  }

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city_id'] = this.city_id;
    data['is_partner'] = this.is_partner;
    data['name'] = this.name;
    data['password'] = this.password;
    data['birth_date'] = this.birth_date;
    data['email'] = this.email;
    data['phone'] = this.phone;
    // data['avatar'] = this.avatar;
    data['device_token'] = this.device_token;
    if (this.image != null) {
      data['avatar'] = await MultipartFile.fromFile(this.image?.path ?? "");
    }
    return data;
  }

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    int? city_id,
    String? phone,
    String? birth_date,
    File? image,
    String? avatar,
    String? device_token,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      birth_date: birth_date ?? this.birth_date,
      city_id: city_id ?? this.city_id,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      device_token: device_token ?? this.device_token,
      image: image ?? this.image,
    );
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:supa_kota/core/utiles/utiles.dart';

import '../../../data/api/my_api.dart';
import '../../endpoints/endpoints.dart';
import '../../models/auth_model.dart';

class ProfileRepo {
  static Future<User?> fetchProfile(context, {bool? load}) async {
    final response = await DioHelper.getData(
        context: context,
        url: EndPoints.ME,
        loading: load ?? true,
        token: Utiles.token);
    print(response);
    if (response != null) {
      User user = User.fromJson(response.data['data']["user"]);
      Utiles.UserImage = user.avatar ?? '';
      Utiles.isPartner = user.is_partner ?? false;
      print(user.toJson());

      return user;
    }
  }

  static UpdateDataProfile(User user) async {
    final response = await DioHelper.postData(
        body: await user.toJson(),
        url: EndPoints.UPDATE_PROFILE,
        loading: true,
        token: Utiles.token,
        isForm: true);
    print(response);
    if (response != null) {
      User user = User.fromJson(response.data['data']["user"]);

      print(user.toJson());

      return user;
    }
  }

  static UpdatePassword(pass, context) async {
    final response = await DioHelper.postData(
        body: {"password": pass},
        url: EndPoints.RESET_PASS,
        loading: true,
        token: Utiles.token,
        isForm: true);
    print(response);
    if (response != null) {
      User user = User.fromJson(response.data['data']["user"]);
      Navigator.pop(context);

      print(user.toJson());

      return user;
    }
  }

  static UpdateImageProfile(File image) async {
    final response = await DioHelper.postData(
        body: {
          'avatar': await MultipartFile.fromFile(image.path,
              filename: image.path.split(Platform.pathSeparator).last)
        },
        url: EndPoints.UPDATE_PROFILE,
        loading: true,
        token: Utiles.token,
        isForm: true);
    print(response);
    if (response != null) {
      User user = User.fromJson(response.data['data']["user"]);
      Utiles.UserImage = user.avatar ?? '';
      print(user.toJson());

      return user;
    }
  }

  static deleteAccount(String? password) async {
    final response = await DioHelper.postData(
        body: {'password': password},
        url: EndPoints.DELETE_ACCOUNT,
        loading: true,
        token: Utiles.token,
        isForm: true);
    print(response);
    if (response != null) {
      // User user = User.fromJson(response.data['data']["user"]);

      return response.data;
    }
  }
}

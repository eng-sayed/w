import 'package:supa_kota/core/utiles/utiles.dart';
import 'package:supa_kota/domain/endpoints/endpoints.dart';
import 'package:supa_kota/domain/models/auth_model.dart';

import '../../../data/api/my_api.dart';

class AuthRepo {
  static login({required String phone, required String password}) async {
    final response = await DioHelper.postData(
        url: EndPoints.LOGIN,
        isForm: true,
        body: {
          'phone': phone,
          'password': password,
          'device_token': Utiles.FCMToken
        },
        loading: true);
    if (response != null) {
      User user = User.fromJson(response.data['data']["user"]);
      print("Utiles.token");
      print(user.toJson());
      Utiles.token = response.data['data']['token'];
      Utiles.name = user.name ?? '';
      Utiles.email = user.email ?? '';
      Utiles.phone = user.phone ?? '';
      Utiles.UserId = user.id.toString();
      return response;
    }
  }

  static register(User authModel, image) async {
    authModel.image = image;
    final response = await DioHelper.postData(
        url: EndPoints.REGISTER,
        isForm: true,
        body: await authModel.copyWith(device_token: Utiles.FCMToken).toJson(),
        loading: true);
    if (response != null) {
      User user = User.fromJson(response.data['data']["user"]);

      Utiles.token = response.data['data']['token'];
      Utiles.name = user.name ?? '';
      Utiles.email = user.email ?? '';
      Utiles.phone = user.phone ?? '';
      Utiles.UserId = user.id.toString();

      return response;
    }
  }

  static forgetPasswordRequest(email, context) async {
    final response = await DioHelper.postData(
        url: EndPoints.FORGET_PASS,
        isForm: true,
        query: {'email': email},
        loading: true);
    if (response != null) {
      return response.data['message'];
    }
  }

  static checkCodeRequest(code, context) async {
    final response = await DioHelper.postData(
        url: EndPoints.CHECK_CODE, query: {'code': code}, loading: true);
    if (response != null) {
      return response.data['token'];
    }
  }

  static changePassRequest(pass, token, context) async {
    final response = await DioHelper.postData(
        url: EndPoints.RESET_PASSWORD,
        body: {
          "token": token,
          "password": pass,
        },
        isForm: true,
        loading: true);
    if (response != null) {
      return response.data['message'];
    }
  }
}

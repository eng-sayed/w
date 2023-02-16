import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supa_kota/domain/models/countries_model.dart';
import 'package:supa_kota/domain/models/promo_code_model.dart';
import 'package:supa_kota/domain/models/review_model.dart';
import 'package:supa_kota/domain/models/services_model.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utiles/utiles.dart';
import '../../../data/api/my_api.dart';
import '../../../data/hive/local_hive.dart';
import '../../endpoints/endpoints.dart';
import '../../models/add_review.dart';
import '../../models/branches_model.dart';
import '../../models/branche_of_country_model.dart';
import '../../models/maintence_model.dart';

class ServicesRepo {
  static Future<List<ServicesModel>?> fetchServices(context) async {
    List<ServicesModel> services = [];

    final response = await DioHelper.getData(
        context: context, url: EndPoints.GET_SERVICES, token: Utiles.token);
    print(response);
    if (response != null) {
      response.data['data']["services"].forEach((e) {
        services.add(ServicesModel.fromJson(e));
      });
      // List<ServicesModel> user =
      // response.data['data']["services"] as List<ServicesModel>;

      print(services);
      print('----------------------');

      // print(user);

      return services;
    }
  }

  static Future<ServicesModel?> fetchService(id, context) async {
    ServicesModel service = ServicesModel();

    final response = await DioHelper.getData(
        context: context,
        url: '${EndPoints.GET_SERVICES}$id',
        token: Utiles.token,
        loading: true);
    print(response);
    if (response != null) {
      service = ServicesModel.fromJson(response.data['data']["service"]);

      print(service);
      print('----------------------');

      // print(user);

      return service;
    }
  }

  static Future<List<ReviewModel>?> fetchReviewServices(id, context) async {
    List<ReviewModel> reviewServices = [];

    final response = await DioHelper.getData(
        context: context,
        url: '${EndPoints.GET_SERVICES}$id/reviews',
        token: Utiles.token,
        loading: true);
    print(response);
    if (response != null) {
      response.data['data']["reviews"].forEach((e) {
        reviewServices.add(ReviewModel.fromJson(e));
      });
      // service = ServicesModel.fromJson(response.data['data']["service"]);

      print(reviewServices);
      print('----------------------');

      // print(user);

      return reviewServices;
    }
  }

  static Future<List<ReviewModel>?> postReviewServices(id,
      {AddReviewModel? addReviewModel}) async {
    List<ReviewModel> reviewServices = [];

    final response = await DioHelper.postData(
        url: '${EndPoints.GET_SERVICES}$id/review',
        token: Utiles.token,
        loading: true,
        body: await addReviewModel?.toJson(),
        isForm: true);
    print(response);
    if (response != null) {
      Fluttertoast.showToast(
          msg: response.data["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: AppColors.primiry,
          textColor: Colors.white,
          fontSize: 16.0);
      // response.data['data']["review"].forEach((e) {
      //   reviewServices.add(ReviewModel.fromJson(e));
      // });
      // service = ServicesModel.fromJson(response.data['data']["service"]);

      print(reviewServices);
      print('----------------------');

      // print(user);

      return reviewServices;
    }
  }

  static Future<List<BranchesDropDownModel>?> fetchBranchesDropdown(
      context) async {
    List<BranchesDropDownModel> brsnches = [];

    final response = await DioHelper.getData(
        context: context,
        url: '${EndPoints.GET_BRANCHES_DROPDOWN}',
        token: Utiles.token,
        loading: true);
    print(response);
    if (response != null) {
      response.data['data']["branches"].forEach((e) {
        brsnches.add(BranchesDropDownModel.fromJson(e));
      });

      print(brsnches);
      print('----------------------');

      return brsnches;
    }
  }

  static Future<List<CountriesModel>?> fetchCountries(context) async {
    List<CountriesModel> countries = [];

    final response = await DioHelper.getData(
        context: context,
        url: '${EndPoints.GET_COUNTRIES}?branches=1',
        token: Utiles.token,
        loading: true);
    print(response);
    if (response != null) {
      response.data['data']["countries"].forEach((e) {
        countries.add(CountriesModel.fromJson(e));
      });

      print(countries);
      print('----------------------');

      return countries;
    }
  }

  static Future<List<BranchesOfCountriesModel>?> fetchBranchCountries(
      id, context) async {
    List<BranchesOfCountriesModel> branches = [];

    final response = await DioHelper.getData(
        context: context,
        url: '${EndPoints.GET_COUNTRIES + id + '/branches'}',
        token: Utiles.token,
        loading: true);
    print(response);
    if (response != null) {
      response.data['data']["branches"].forEach((e) {
        branches.add(BranchesOfCountriesModel.fromJson(e));
      });

      print(branches);
      print('----------------------');

      return branches;
    }
  }

  static Future<PromoCodeModel?> checkPromoCode(String code, context) async {
    PromoCodeModel promoCodeModel;

    final response = await DioHelper.getData(
        context: context,
        url: '${EndPoints.GET_PROMO_CODE}${code}/check',
        token: Utiles.token,
        loading: true);
    print(response);
    if (response != null) {
      promoCodeModel =
          PromoCodeModel.fromJson(response.data['data']["promoCode"]);

      print(promoCodeModel);
      print('----------------------');

      return promoCodeModel;
    }
  }

  static Future<List<String>?> phoneNum(context) async {
    List<String> phones = [];

    final response = await DioHelper.getData(
        context: context,
        url: '${EndPoints.GET_Setting}',
        query: {"key": 'contact_phones'},
        token: Utiles.token,
        loading: false);
    print(response);
    if (response != null) {
      phones = response.data['data']["settings"]["contact_phones"]
          .toString()
          .split(',');
      print('phonesphonesssssssssssssssssssssssssssssssssssssssssssssssss');
      print(phones);

      return phones;
    }
  }

  static createMainReservation(MaintenanceModel maintenanceModel) async {
    final response = await DioHelper.postData(
        url: '${EndPoints.CREATE_MAIN_RESERVATION}',
        body: maintenanceModel.toJson(),
        token: Utiles.token,
        loading: true);
    print(response);
    if (response != null) {
      return response;
    } else {
      return null;
    }
  }

  PromoCodeModel? promoCodeModel;
  static checkPromoCodeRequest(code) async {
    final response = await DioHelper.postData(
        url: '${EndPoints.CHECK_PROMO_CODE + code + '/check'}',
        query: {'code': code},
        token: Utiles.token,
        loading: true);
    print(response);
    if (response != null) {
      print('----------------------');

      return response.data['data']["promoCode"];
    }
  }
}

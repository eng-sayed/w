import 'dart:io';

import 'package:dio/dio.dart';
import 'package:supa_kota/domain/models/add_car_model.dart';
import 'package:supa_kota/domain/models/complains_model.dart';

import '../../../core/utiles/utiles.dart';
import '../../../data/api/my_api.dart';
import '../../endpoints/endpoints.dart';
import '../../models/car_parts_model.dart';
import '../../models/my_cars_model.dart';
import '../../models/services_model.dart';

class CarsRepo {
  static Future<List<MyCarsModel>?> fetchMyCars(context) async {
    List<MyCarsModel> myCars = [];

    final response = await DioHelper.getData(
        url: EndPoints.GET_MY_CARS, token: Utiles.token, context: context);
    print(response);
    if (response != null) {
      response.data['data']["cars"].forEach((e) {
        myCars.add(MyCarsModel.fromJson(e));
      });
      // List<ServicesModel> user =
      // response.data['data']["services"] as List<ServicesModel>;

      print(myCars);
      print('----------------------');

      // print(user);

      return myCars;
    }
  }

  static Future<MyCarsModel?>? fetchOneCar(id, context) async {
    MyCarsModel myCar;

    final response = await DioHelper.getData(
        url: EndPoints.GET_MY_CARS + id, token: Utiles.token, context: context);
    print(response);
    if (response != null) {
      myCar = MyCarsModel.fromJson(response.data['data']["car"]);

      // List<ServicesModel> user =
      // response.data['data']["services"] as List<ServicesModel>;

      print(myCar);
      print('----------------------');

      return myCar;
    }
  }

  static Future<HasComplainAndReserVationsModel?> fetchHasComplain(
      id, context) async {
    HasComplainAndReserVationsModel? hasComplainAndReservation;

    final response = await DioHelper.getData(
        url: EndPoints.GET_MY_CARS + id + '/info',
        token: Utiles.token,
        context: context);
    print(response);
    if (response != null) {
      hasComplainAndReservation =
          HasComplainAndReserVationsModel.fromMap(response.data['data']);

      // List<ServicesModel> user =
      // response.data['data']["services"] as List<ServicesModel>;

      print(hasComplainAndReservation);
      print('----------------------');

      return hasComplainAndReservation;
    }
  }

  static Future<List<CarPartsModel>?> fetchCarParts(context) async {
    List<CarPartsModel> carParts = [];

    final response = await DioHelper.getData(
        url: EndPoints.CAR_PARTS, token: Utiles.token, context: context);
    print(response);
    if (response != null) {
      response.data['data']["parts"].forEach((e) {
        carParts.add(CarPartsModel.fromJson(e));
      });

      // List<ServicesModel> user =
      // response.data['data']["services"] as List<ServicesModel>;

      print(carParts);
      print('----------------------');

      return carParts;
    }
  }

  static Future<List<ServicesModel>?> fetchFinishedServices(context, id) async {
    List<ServicesModel> services = [];

    final response = await DioHelper.getData(
        url: EndPoints.GET_MY_CARS + id + '/services',
        token: Utiles.token,
        context: context,
        loading: true);
    print(response);
    if (response != null) {
      response.data['data']["services"].forEach((e) {
        services.add(ServicesModel.fromJson(e));
      });

      // List<ServicesModel> user =
      // response.data['data']["services"] as List<ServicesModel>;

      print(services);
      print('----------------------');

      return services;
    }
  }

  static sellCArRequest(id, email, phone) async {
    final response = await DioHelper.postData(
        url: EndPoints.GET_MY_CARS + id.toString() + '/sell',
        token: Utiles.token,
        loading: true,
        body: {'email': email, 'phone': phone},
        isForm: true);
    print(response);
    if (response != null) {
      return response;
    }
  }

  static addNewCar(AddCarModel carModel, File image) async {
    carModel.uploadImage = image;
    final response = await DioHelper.postData(
        url: EndPoints.ADD_MY_CARS,
        token: Utiles.token,
        loading: true,
        body: await carModel.toMap(),
        isForm: true);
    print(response);
    if (response != null) {
      return response;
    }
  }

  static updateMyCar(id, {File? image, AddCarModel? carModel}) async {
    UpdateCarModel? updateCarModel;
    if (image != null) {
      carModel?.uploadImage = image;
    }
    if (image == null) {
      carModel?.uploadImage = image;
      updateCarModel = UpdateCarModel(
        notes: carModel?.notes ?? '',
        kilometers: carModel?.kilometers ?? '',
        brand_id: carModel?.brand_id ?? '',
        model_id: carModel?.model_id ?? '',
        plate_number: carModel?.plate_number ?? '',
        year: carModel?.year ?? 0,
      );
    }

    final response = await DioHelper.postData(
        url: EndPoints.GET_MY_CARS + '$id/update',
        token: Utiles.token,
        loading: true,
        body: image != null
            ? await carModel?.toMap()
            : await updateCarModel?.toMap(),
        isForm: true);
    print(response);
    if (response != null) {
      return response;
    }
  }

  static deleteMyCar(id) async {
    final response = await DioHelper.postData(
      url: "${EndPoints.GET_MY_CARS}$id/delete",
      token: Utiles.token,
      loading: true,
    );
    if (response != null) {
      return response;
    }
  }

  static complainCarRequest(ComplainsModel complainsModel) async {
    final response = await DioHelper.postData(
        url: EndPoints.POST_COMPLAINS,
        token: Utiles.token,
        loading: true,
        isForm: true,
        body: await complainsModel.toJson());
    if (response != null) {
      print(response.data['data']['complain']['replies']);
      print("response.data['data']['complain']['images']");
      print(response.data['data']['complain']['images']);
      return response.data;
    }
  }

  static AcceptCar(id) async {
    final response = await DioHelper.postData(
      url: "${EndPoints.GET_MY_CARS}$id/accept",
      token: Utiles.token,
      loading: true,
    );
    if (response != null) {
      return response;
    }
  }

  static rejectCar(id) async {
    final response = await DioHelper.postData(
      url: "${EndPoints.GET_MY_CARS}$id/reject",
      token: Utiles.token,
      loading: true,
    );
    if (response != null) {
      return response;
    }
  }

  static fetchCarComplain(id, context) async {
    List<ComplainModel?> complainModel = [];
    final response = await DioHelper.getData(
      context: context,
      url: EndPoints.GET_MY_CARS + id + "/complaints",
      token: Utiles.token,
      loading: false,
    );
    if (response != null) {
      response.data['data']['complaints'].forEach((e) {
        complainModel.add(ComplainModel.fromJson(e));
      });

      return complainModel;
    }
  }
}

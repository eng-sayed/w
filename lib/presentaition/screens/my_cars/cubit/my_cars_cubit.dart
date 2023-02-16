import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:supa_kota/core/utiles/navigate.dart';
import 'package:supa_kota/domain/models/complains_model.dart';
import 'package:supa_kota/domain/models/my_cars_model.dart';
import 'package:supa_kota/domain/repositry/cars_repo/cars_repo.dart';

import '../../../../core/themes/colors.dart';
import '../../../../domain/models/car_parts_model.dart';
import '../../../../domain/models/services_model.dart';
import '../../call/call.dart';
import '../widget/car_complaint_dialog.dart';

part 'my_cars_state.dart';

class MyCarsCubit extends Cubit<MyCarsState> {
  MyCarsCubit() : super(MyCarsInitial());
  static MyCarsCubit get(context) => BlocProvider.of(context);
  List<MyCarsModel> myCars = [];
  getMyCars(context) async {
    emit(CarsLoadingState());
    final response = await CarsRepo.fetchMyCars(context);
    if (response != null) {
      myCars = response;
      print(myCars);
      emit(CarsSuccessState());
    } else {
      emit(CarsErrorState());
    }
  }

  // List<HasComplainAndReserVationsModel> hasComplainAndReservation = [];

  // getCarHasComplainAndReservation(context) async {
  //   hasComplainAndReservation = [];
  //   myCars.forEach((element) async {
  //     final response =
  //         await CarsRepo.fetchHasComplain(element.id.toString(), context);

  //     if (response != null) {
  //       hasComplainAndReservation.add(response);
  //     }
  //   });

  // }

  deleteCar(id, context) async {
    final response = await CarsRepo.deleteMyCar(id);
    if (response != null) {
      await getMyCars(context);
      emit(DeleteCarsSuccessState());

      return true;
    } else {
      emit(DeteteCarsErrorState());
      return false;
    }
  }

  accept(id, context) async {
    final response = await CarsRepo.AcceptCar(id);
    if (response != null) {
      await getMyCars(context);
    } else {
      emit(CarsErrorState());
    }
  }

  reject(id, context) async {
    final response = await CarsRepo.rejectCar(id);
    if (response != null) {
      await getMyCars(context);
    } else {
      emit(CarsErrorState());
    }
  }

  List<CarPartsModel> carParts = [];
  List<ServicesModel> services = [];

  Future getCarParts(context) async {
    final response = await CarsRepo.fetchCarParts(context);
    if (response != null) {
      carParts = response;
    } else {
      emit(GetCarPartsError());
    }
  }

  Future getEndedServices(context, id) async {
    final response = await CarsRepo.fetchFinishedServices(context, id);
    if (response != null) {
      services = response;
      print('yessssssService');
    } else {
      emit(GetEndedServicesError());
    }
  }

  Future<bool?> getCarPartsAndEndedService(context, id) async {
    Future.wait([getEndedServices(context, id), getCarParts(context)])
        .then((value) {
      if (services.isNotEmpty) {
        print('yessssss');
        resetComplainData();
        complainsModel?.car_id = int.tryParse(id);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CarComplaint();
            });
      } else {
        print('noooooooo');
        Fluttertoast.showToast(
            msg: 'NoFinishedReservations'.tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: AppColors.primiry,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      emit(SuccessState());
      return services.isNotEmpty ? true : false;
    }).catchError((e) {
      emit(ErrorState());
      return false;
    });
  }

  makeComplain(context) async {
    print(complainsModel?.images?.length);
    final response =
        await CarsRepo.complainCarRequest(complainsModel ?? ComplainsModel());
    if (response != null) {
      pickedImage.clear();

      navigateReplacement(
          context: context,
          route: CallScreen(
            index: 2,
          ));
    } else {
      emit(ComplainsErrorState());
    }
  }

  ComplainsModel? complainsModel;
  List<File> pickedImage = [];
  resetComplainData() {
    pickedImage.clear();
    complainsModel = ComplainsModel();
  }

  addImage(bool isGallery, context) async {
    pickedImage = [];
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = isGallery
        ? await _picker.pickMultiImage(imageQuality: 50)
        : await _picker.pickMultiImage(imageQuality: 50);
    print('image');
    print(images);
    if (images?.isNotEmpty ?? false)
      images?.forEach((element) {
        pickedImage.add(File(element.path));
      });

    complainsModel?.images = pickedImage;
    print('complainsModel?.images?.length');
    print(complainsModel?.images?.length);

    emit(AddedImageState());
  }

  changePartId(index) {
    complainsModel?.part_id = carParts[index].id;
    emit(ChangePartId());
  }

  changeServiceId(index) {
    complainsModel?.service_id = services[index].id;
    emit(ChangeServiceId());
  }
}

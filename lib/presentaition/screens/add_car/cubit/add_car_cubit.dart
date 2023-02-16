import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:supa_kota/core/utiles/navigate.dart';
import 'package:supa_kota/domain/models/add_car_model.dart';
import 'package:supa_kota/domain/repositry/cars_repo/cars_repo.dart';
import 'package:supa_kota/presentaition/screens/my_cars/cubit/my_cars_cubit.dart';
import 'package:supa_kota/presentaition/screens/start/start.dart';

import '../../../../cubit/app_cubit.dart';
import '../../../../domain/models/brands_model.dart';
import '../../../../domain/models/models_car_model.dart';
import '../../../../domain/models/my_cars_model.dart';
import '../../../../domain/repositry/brands_repo/brands_rebo.dart';

part 'add_car_state.dart';

class AddCarCubit extends Cubit<AddCarState> {
  AddCarCubit() : super(AddCarInitial());
  static AddCarCubit get(context) => BlocProvider.of(context);
  File? pickedImage;
  MyCarsModel? myCar;
  getData(id, context) {
    emit(EditMyCarLoadingState());
    Future.wait([getCarBrands(context), getOneCar(id, context)])
        .then((value) async {
      await getModelsOfBrand(context, myCar?.brand?.id.toString(),
          addCarLoading: true);
      await equal();

      emit(EditMyCarSuccessState());
      return true;
    }).catchError((e) => emit(EditMyCarErrorState()));
  }

  AddCarModel addCarModel = AddCarModel();
  final carKm = TextEditingController(),
      plateNumber = TextEditingController(),
      year = TextEditingController(),
      comment = TextEditingController();
  equal() {
    addCarModel = AddCarModel(
      notes: myCar?.notes ?? '',
      image: myCar?.image ?? '',
      plate_number: myCar?.plateNumber ?? '',
      brand_id: myCar?.brand?.id.toString(),
      model_id: myCar?.model?.id.toString(),
      kilometers: myCar?.kilometers.toString(),
      year: myCar?.year ?? 0,
    );
    carKm.text = addCarModel.kilometers.toString();
    plateNumber.text = addCarModel.plate_number.toString();
    comment.text = addCarModel.notes.toString();
    year.text = addCarModel.year.toString();
  }

  List<BrandsModel> brands = [];
  Future getBrands(
    context,
  ) async {
    pickedImage = null;
    emit(BrandsLoadingState());
    final response = await BrandsRepo.getBrands(context);
    if (response != null) {
      brands = response;

      print(brands);
      await getModelsOfBrand(context, brands.first.id.toString(),
          addCarLoading: false);
      emit(BrandsSuccessState());
    } else {
      emit(BrandsErrorState());
    }
  }

  Future getCarBrands(
    context,
  ) async {
    pickedImage = null;

    final response = await BrandsRepo.getBrands(context);
    if (response != null) {
      brands = response;

      print(brands);
    } else {}
  }

  addCar(AddCarModel carModel, File image, context,
      {bool fromRegistr = false}) async {
    final response = await CarsRepo.addNewCar(carModel, image);
    if (response != null) {
      if (!fromRegistr) {
        final addCarsCubit = MyCarsCubit.get(context);
        await addCarsCubit.getMyCars(context);
        Navigator.pop(context);
      } else {
        navigateReplacement(context: context, route: StartTotrial());
        brands = [];
        model = [];
        emit(EditMyCarLoadingState());
      }
    }
  }

  updateCar(id, context) async {
    print(addCarModel.toMap());
    print(addCarModel.year);
    final response = await CarsRepo.updateMyCar(carModel: addCarModel, id);
    if (response != null) {
      await getOneCar(id, context);
      final app = AppCubit.get(context);

      app.emit(ChangeStateApp());
    }
  }

  Future getOneCar(id, context) async {
    final response = await CarsRepo.fetchOneCar(id, context);
    if (response != null) {
      myCar = response;

      emit(MyCarSuccessState());
      return myCar;
    }
  }

  updateImageCar(
      id, File? image, AddCarModel carModel, context, bool isGallery) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = isGallery
        ? await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50)
        : await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    print(image);
    if (image != null) pickedImage = File(image.path);
    final response =
        await CarsRepo.updateMyCar(image: pickedImage, id, carModel: carModel);
    if (response != null) {
      await getOneCar(id, context);
      emit(AddedImageState());
    }
  }

  List<ModelsCarsModel> model = [];
  Future getModelsOfBrand(context, id, {bool? addCarLoading}) async {
    //emit(BrandsLoadingState());
    final response = await BrandsRepo.fetchModelsOfBrand(context, id,
        addCarLoading: addCarLoading ?? true);
    if (response != null) {
      model = response;

      print(model);
      emit(ModelBrandState());
    } else {
      emit(BrandsErrorState());
    }
  }

  Future getCarsModels(context) async {
    //emit(BrandsLoadingState());
    final response = await BrandsRepo.fetchCarModels(context);
    if (response != null) {
      model = response;

      print(model);
      //  emit(BrandsSuccessState());
    } else {
      //emit(BrandsErrorState());
    }
  }

  addImage(bool isGallery) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = isGallery
        ? await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50)
        : await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    print('image');
    print(image);
    if (image != null) pickedImage = File(image.path);
    emit(AddedImageState());
  }
}

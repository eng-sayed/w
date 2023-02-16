import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../domain/models/add_review.dart';
import '../../../../domain/models/complains_model.dart';
import '../../../../domain/models/my_cars_model.dart';
import '../../../../domain/models/reservations_model.dart';
import '../../../../domain/repositry/cars_repo/cars_repo.dart';
import '../../../../domain/repositry/reservation_repo/reservation_repo.dart';
import '../../../../domain/repositry/services_repo/services_repo.dart';
import '../../my_cars/cubit/my_cars_cubit.dart';

part 'car_details_state.dart';

class CarDetailsCubit extends Cubit<CarDetailsState> {
  CarDetailsCubit() : super(CarDetailsInitial());
  static CarDetailsCubit get(context) => BlocProvider.of(context);
  MyCarsModel? myCar;
  AddReviewModel? addReviewModel = AddReviewModel();

  int indexData = 0;
  bool firstChild = true;

  toggleChilds(bool show) {
    firstChild = show;
    print(show);
    show ? emit(ServicesFirstChild()) : emit(ServicesSecChild());
  }

  changeIndex(indexProgress, indexReservation, {bool isFinishedList = false}) {
    isFinishedList
        ? finishedIndexs[indexReservation] = indexProgress
        : progressIndexs[indexReservation] = indexProgress;
    emit(ChangeIndexReservations());
  }

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

  List<File> pickedImage = [];
  addImage(context) async {
    pickedImage = [];
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage(imageQuality: 50);
    print('image');
    print(images);
    if (images?.isNotEmpty ?? false) {
      images?.forEach((element) {
        pickedImage.add(File(element.path));
        print('pickedImage');
        print(pickedImage);
      });
      // addReviewModel ??= AddReviewModel();
      print('allpickedImage');
      print(pickedImage);
      addReviewModel?.images = pickedImage;
      print("pickedImage.length");
      print(pickedImage.length);
      print("addReviewModel?.images?.length");
      print(addReviewModel?.images?.length);
    }
    // pickedImage = File(image.path);

    emit(AddedImageState());
  }

  File? pickedVideo;
  addVideo(context, bool isgallery) async {
    pickedVideo = null;
    final ImagePicker _picker = ImagePicker();
    final XFile? video = isgallery
        ? await _picker.pickVideo(source: ImageSource.gallery)
        : await _picker.pickVideo(source: ImageSource.camera);
    print('video');
    print(video);
    if (video?.path.isNotEmpty ?? false)
    // images?.forEach((element) {
    //   pickedImage.add(File(element.path));
    // });
    {
      pickedVideo = File(video?.path ?? '');
      addReviewModel?.videos = pickedVideo;
      print(pickedVideo);
      print('addReviewModel?.videos');
      print(addReviewModel?.videos);
      // pickedImage = File(image.path);
    }
    emit(AddedImageState());
  }

  reviewService(id, context) async {
    print("addReviewModel?.comment");
    print(addReviewModel?.comment);
    print('addReviewModel?.score');
    print(addReviewModel?.score);
    print('addReviewModel?.videos?.path');
    print(addReviewModel?.videos?.path);
    print('addReviewModel?.images?.length');
    print(addReviewModel?.images?.length);
    final response = await ServicesRepo.postReviewServices(id,
        addReviewModel: addReviewModel);
    if (response != null) {
//reviewServices = response;
      //await getServiceAndReviews(id, context);
      // print(service.toJson());
      emit(SuccessReviewState());
    } else {
      emit(ErrorReviewState());
    }
  }

  List<int> progressIndexs = [], finishedIndexs = [];
  List<ReservationsModel>? finishedReservations = [], prgressReservation = [];
  getCarDetailes(id, context) async {
    emit(CarLoadingState());
    Future.wait([getOneCar(id, context), getCarComplains(id, context)])
        .then((value) {
      emit(CarSuccessState());
    }).catchError(() {
      emit(CarErrorState());
    });
  }

  Future getOneCar(id, context) async {
    //  emit(MyCarLoadingState());

    final response = await CarsRepo.fetchOneCar(id, context);
    if (response != null) {
      finishedReservations = [];
      prgressReservation = [];
      myCar = response;

      myCar?.reservations?.forEach((element) {
        if (element.status == 'ended') {
          finishedReservations?.add(element);
        } else {
          prgressReservation?.add(element);
        }
      });

      progressIndexs = List.filled(prgressReservation?.length ?? 0, 0);
      finishedIndexs = List.filled(finishedReservations?.length ?? 0, 0);

      // emit(MyCarSuccessState());
      return myCar;
    } else {
      // emit(MyCarErrorState());
    }
  }

  sellCar(id, context, email, phone) async {
    final response = await CarsRepo.sellCArRequest(id, email, phone);
    if (response != null) {
      final cubit = MyCarsCubit.get(context);
      await cubit.getMyCars(context);

      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  List<ComplainModel?> complainModel = [];
  int index = 0;

  Future getCarComplains(id, context) async {
    final response = await CarsRepo.fetchCarComplain(id.toString(), context);
    if (response != null) {
      complainModel = response;
    }
  }

  ReservationsModel? oneReservations;
  getOneReservation(id, context) async {
    emit(OneLoadingReservations());
    index = 0;
    final response = await ReservationRepo.fetchOneReservation(id, context);
    if (response != null) {
      oneReservations = response;
      for (Progress d in oneReservations?.progress ?? []) {
        d.status == 'finished' ? index += 1 : null;
        print(index);
      }
      emit(OneSuccessReservations());
    } else {
      emit(OneErrorReservations());
    }
  }

  changeIndexProgress(i) {
    indexData = i;
    emit(ChangeIndexReservations());
  }
}

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:supa_kota/core/utiles/navigate.dart';
import 'package:supa_kota/core/utiles/utiles.dart';
import 'package:supa_kota/domain/models/maintence_model.dart';
import 'package:supa_kota/presentaition/components/my_loading.dart';
import 'package:supa_kota/presentaition/screens/profile/cubit/profile_cubit.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/alerts.dart';
import '../../../../data/hive/local_hive.dart';
import '../../../../domain/models/branche_of_country_model.dart';
import '../../../../domain/models/branches_model.dart';
import '../../../../domain/models/countries_model.dart';
import '../../../../domain/models/my_cars_model.dart';
import '../../../../domain/models/promo_code_model.dart';
import '../../../../domain/models/review_model.dart';
import '../../../../domain/models/services_model.dart';
import '../../../../domain/repositry/cars_repo/cars_repo.dart';
import '../../../../domain/repositry/services_repo/services_repo.dart';
import '../../../components/custom_text.dart';
import '../../about_us/cubit/about_us_cubit.dart';
import '../../call/call.dart';
import '../widgets/select_car.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(ServicesInitial());
  static ServicesCubit get(context) => BlocProvider.of(context);
  bool firstChild = true;
  TextEditingController promoCodeController = TextEditingController();
  bool privacy = false;
  ChangePrivacy() {
    privacy = !privacy;
    emit(ChangePrivacyState());
  }

  toggleChilds(bool show) {
    firstChild = show;
    print(show);
    show ? emit(ServicesFirstChild()) : emit(ServicesSecChild());
  }

  bool showGpsBTN = true;
  Future<void> getCurrentPosition(context) async {
    final hasPermission = await _handleLocationPermission(context);
    if (!hasPermission) return;
    MyLoading.show();
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      mainReservation.lat = position.latitude;
      mainReservation.lng = position.longitude;
      showGpsBTN = false;
      emit(ChooseLocation());
      MyLoading.dismis();
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(
          msg:
              'Location services are disabled. Please enable the services'.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: AppColors.primiry,
          textColor: Colors.white,
          fontSize: 16.0);
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(
            msg: 'Location permissions are denied'.tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: AppColors.primiry,
            textColor: Colors.white,
            fontSize: 16.0);
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.'
                  .tr()
                  .tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: AppColors.primiry,
          textColor: Colors.white,
          fontSize: 16.0);
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  DateTime selectedDate = DateTime.now();

  selectDate(
    context,
    DateTime dateTime,
  ) {
    selectedDate = dateTime;
    mainReservation.reservationDate =
        '${dateTime.year}-${dateTime.month.toString().length == 1 ? '0${dateTime.month}' : dateTime.month}-${dateTime.day.toString().length == 1 ? '0${dateTime.day}' : dateTime.day} ${dateTime.hour.toString().length == 1 ? '0${dateTime.hour}' : dateTime.hour}:00:00';
    print('0${dateTime.day.bitLength}');

    emit(SelectDateState());
  }

  int? selectedCountry;
  selectCountry(context, int index) async {
    selectedCountry = index;
    await getBrancheCountries(
        countries[selectedCountry ?? 0].id.toString(), context);
    if (branchesOfCountry.isEmpty) mainReservation.branchId = null;
    delivery = false;

    // mainReservation.

    emit(SelectContryState());

    // return countries[index].hasDelivery == 1 ? true : false;
  }

  switchDelivery() {
    delivery = !delivery;
    if (delivery) mainReservation.branchId = null;
    emit(SwitchDelivery());
  }

  List<ServicesModel> services = [];
  List<SubServices>? bookingSubServices = [];
  ServicesModel service = ServicesModel();
  Future getServices(context) async {
    final response = await ServicesRepo.fetchServices(context);
    if (response != null) {
      services = response;
      print(services);
      // emit(ServicesSuccessState());
    } else {
      // emit(ServicesErrorState());
    }
  }

  getServicesAndNums(context) {
    final cubit = ProfileCubit.get(context);

    emit(ServicesLoadingState());
    Future.wait([
      getServices(context),
      // getPhoneCAll(context),
      cubit.getProfile(context, load: false),
    ])
        .then((value) => emit(ServicesSuccessState()))
        .catchError((e) => emit(ServicesErrorState()));
  }

  MyCarsModel? myCar;
  getDataToBookingServiceCar(id, context) async {
    emit(SuccessServicesBooking());
    Future.wait([getServices(context), getOneCar(id, context)])
        .then((value) => emit(SuccessServicesBooking()))
        .catchError((onError) {
      emit(ErrorServicesBooking());
    });
  }

  // List<MyCarsModel> myCars = [];
  // getMyCars(context) async {
  //  // emit(CarsLoadingState());
  //   final response = await CarsRepo.fetchMyCars(context);
  //   if (response != null) {
  //     myCars = response;
  //     //  await getCarHasComplainAndReservation(context);
  //     print(myCars);
  //    // emit(CarsSuccessState());
  //   } else {
  //   //  emit(CarsErrorState());
  //   }
  // }
  num total = 0;
  remove(SubServices subServices) {
    total = 0;

    (bookingSubServices ?? []).remove(subServices);
    for (SubServices e in bookingSubServices ?? []) {
      if (e.offer != null) {
        total += e.offer?.priceAfter ?? 0;
      } else {
        total += e.price ?? 0;
      }
    }
    print(total);
    emit(ChangeSubService());
  }

  selectSubSerVice(
      {required int i, required int index, required SubServices subService}) {
    total = 0;
    List<SubServices>? add = [];
    List<SubServices>? remove = [];

    if (bookingSubServices?.isNotEmpty ?? false) {
      (bookingSubServices ?? []).removeWhere((element) =>
          (element.id == subService.id ||
              element.parent_id == services[index].id));
      (bookingSubServices ?? []).add(subService);
    } else {
      bookingSubServices?.add(subService);
      print(4);
    }
    print(bookingSubServices);
    for (SubServices e in bookingSubServices ?? []) {
      if (e.offer != null) {
        total += e.offer?.priceAfter ?? 0;
      } else {
        total += e.price ?? 0;
      }
    }
    emit(ChangeSubService());
  }

  Future getOneCar(id, context) async {
    //emit(MyCarLoadingState());

    final response = await CarsRepo.fetchOneCar(id, context);
    if (response != null) {
      myCar = response;

      //  emit(MyCarSuccessState());
      return myCar;
    } else {
      //  emit(MyCarErrorState());
    }
  }

  Future getService(int id, context) async {
    //emit(ServiceLoadingState());
    final response = await ServicesRepo.fetchService(id, context);
    if (response != null) {
      service = response;

      print(service.toJson());
      //  emit(ServiceSuccessState());
    } else {
      //   emit(ServiceErrorState());
    }
  }

  List<ReviewModel> reviewServices = [];
  bool isRated = true;

  Future getReviewServices(int id, context) async {
    isRated = true;
    emit(ReviewLoadingState());

    final response = await ServicesRepo.fetchReviewServices(id, context);
    print('ddddddddddddddddddddd');
    // print(s.toJson());
    print(isRated);
    print(Utiles.UserId);
    if (response != null) {
      reviewServices = response;
      // reviewServices.forEach((e) {
      //   // if (e.user?.id == Utiles.UserId) {
      //   //   isRated = false;
      //   // }
      //   print(e.toJson());
      //   print(e.user?.id);
      //   print(isRated);
      // });
      //  isRated = s.user?.id == Utiles.UserId ? true : false;
      print('fffffffffffffffffffffffffffffffffffffff');
      // print(s.toJson());
      // print(isRated);
      // print(Utiles.UserId);
      emit(ServiceSuccessState());
    } else {
      // emit(ServiceErrorState());
    }
  }

  reviewService(id, score, comment, context) async {
    final response = await ServicesRepo.postReviewServices(
      id,
    );
    if (response != null) {
//reviewServices = response;
      await getServiceAndReviews(id, context);
      // print(service.toJson());
      emit(SuccessReviewState());
    } else {
      emit(ErrorReviewState());
    }
  }

  getServiceAndReviews(id, context) {
    emit(ServiceLoadingState());
    Future.wait([getService(id, context), getReviewServices(id, context)])
        .then((value) => emit(ServiceSuccessState()))
        .catchError((e) => emit(ServiceErrorState()));
  }

  reset() {
    promoCode = null;
    discount = 0;
  }

  List<BranchesDropDownModel> branches = [];
  List<BranchesOfCountriesModel> branchesOfCountry = [];
  List<CountriesModel> countries = [];

  Future getBranches(context) async {
    final response = await ServicesRepo.fetchBranchesDropdown(context);
    if (response != null) {
      branches = response;

      // print(branches.toJson());
      //  emit(ServiceSuccessState());
    } else {
      // emit(ServiceErrorState());
    }
  }

  Future getBrancheCountries(id, context) async {
    final response = await ServicesRepo.fetchBranchCountries(id, context);
    if (response != null) {
      branchesOfCountry = response;
      indexBranch = 0;
      // print(branches.toJson());
      //  emit(ServiceSuccessState());
    } else {
      // emit(ServiceErrorState());
    }
  }

  Future getCountries(context) async {
    final response = await ServicesRepo.fetchCountries(context);
    if (response != null) {
      countries = response;
      print('ccccc');

      // print(branches.toJson());
      //  emit(ServiceSuccessState());
    } else {
      // emit(ServiceErrorState());
    }
  }

  List<MyCarsModel> myCars = [];

  Future getMyCars(context, {bool? show}) async {
    final response = await CarsRepo.fetchMyCars(context);
    if (response != null) {
      myCars = response;
      if (show ?? false) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return SelectCarDialog();
            });
      }
    } else {}
  }

  Future<bool?> getData(context, {bool show = false}) async {
    emit(LoadingState());
    await Future.wait([getMyCars(context, show: false), getCountries(context)])
        .then((value) async {
      if (countries.isNotEmpty) selectedCountry = 0;
      if (countries.isNotEmpty)
        await getBrancheCountries(
            (countries.first.id ?? "0").toString(), context);
      if (branchesOfCountry.isNotEmpty && mainReservation.branchId != null)
        mainReservation.branchId = branchesOfCountry.first.id;
      emit(SuccessState());
      return true;
    }).catchError((e) {
      emit(ErrorState());
      return false;
    });
    return (myCars.isEmpty && state is SuccessState) ? true : false;
  }

  bool delivery = false;
  int indexBranch = 0;
  selectBranch(BranchesOfCountriesModel branch, int index) {
    delivery = false;
    mainReservation.branchId = branch.id;
    showGpsBTN = true;
    indexBranch = index;
    emit(SelectBranchState());
  }

  selectcar(MyCarsModel car) {
    mainReservation.carId = car.id;
    emit(SelectCarState());
  }

  deletePromoCode() {
    promoCode = null;
    discount = 0;
    emit(DeletePromoCOde());
  }

  MaintenanceModel mainReservation = MaintenanceModel();
  createMainReservations(carId, context) async {
    // mainReservation.subServices?.add(id);
    List<int>? Ids = [];
    bookingSubServices?.forEach((element) {
      Ids.add(element.id ?? 0);
    });
    mainReservation = mainReservation.copyWith(
      carId: carId,
      subServices: Ids,
      promo_code: promoCode?.code ?? '',
      notes: mainReservation.notes ?? '',
      lat: mainReservation.lat ?? 0,
      lng: mainReservation.lng ?? 0,
      address: mainReservation.address ?? '',
    );
    print(mainReservation.toJson());

    final response = await ServicesRepo.createMainReservation(mainReservation);
    if (response != null) {
      mainReservation = MaintenanceModel();
      navigateReplacement(context: context, route: CallScreen());
      // Navigator.pop(context);
      // Navigator.pop(context);
      promoCode = null;
      discount = 0;
      bookingSubServices?.clear();
    }
  }
// PromoCodeModel? promoCodeModel;
//   checkPromoCOde(code) async {
//     // mainReservation.subServices?.add(id);
//     final response = await ServicesRepo.checkPromoCodeRequest(code);
//     if (response != null) {}
//   }

  PromoCodeModel? promoCode;
  ckeckPromoCode(String code, context) async {
    final response = await ServicesRepo.checkPromoCode(code, context);
    if (response != null) {
      promoCode = response;
      discount = (promoCode?.type == 'constant')
          ? (promoCode?.value ?? 0)
          : ((100 - (promoCode?.value ?? 0)) / 100);
      print('discountssss');

      print(discount);

      emit(SuccessCodeState());
    } else {
      discount = 0;
      print('discount');
      print(discount);
      emit(ErrorCodeState());
    }
  }

  num discount = 0;
  List<String> phones = [];

  Future getPhoneCAll(context) async {
    final response = await ServicesRepo.phoneNum(context);
    if (response != null) {
      phones = response;
      Utiles.Allphones = phones;
      emit(SuccessCodeState());
    }
    emit(ErrorCodeState());
  }

  // deleteServiceFromCart(int index) {
  //   final response =
  //       ServicesRepo.deleteServicesFromCart(allSavedServices[index].id);
  //   if (response != null) {
  //     allSavedServices.removeWhere((element) => element.id == index);
  //     OverLays.snack(text: "deletecart", state: SnakState.success);
  //     emit(SuccessRemoveCartState());
  //   }
  //   print(allSavedServices);
  // }
}

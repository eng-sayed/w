import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:supa_kota/data/hive/local_hive.dart';
import 'package:supa_kota/domain/repositry/cart_repo/cart_repo.dart';

import '../../../../core/utiles/alerts.dart';
import '../../../../domain/models/branches_model.dart';
import '../../../../domain/models/countries_model.dart';
import '../../../../domain/models/maintence_model.dart';
import '../../../../domain/models/my_cars_model.dart';
import '../../../../domain/models/services_model.dart';
import '../../../../domain/repositry/cars_repo/cars_repo.dart';
import '../../../../domain/repositry/services_repo/services_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  static CartCubit get(context) => BlocProvider.of(context);
  List<int> ids = [];

  MaintenanceModel mainReservation = MaintenanceModel();
  createMainReservations(context) async {
    final response = await ServicesRepo.createMainReservation(
        mainReservation.copyWith(subServices: ids));
    if (response != null) {
      mainReservation = MaintenanceModel();

      Navigator.pop(context);
      emit(SuccessState());
    } else {}
  }

  List<BranchesDropDownModel> branches = [];

  Future getBranches(context) async {
    final response = await ServicesRepo.fetchBranchesDropdown(context);
    if (response != null) {
      branches = response;
    } else {}
  }

  List<MyCarsModel> myCars = [];

  Future getMyCars(context) async {
    final response = await CarsRepo.fetchMyCars(context);
    if (response != null) {
      myCars = response;
    } else {}
  }

  getData(context) {
    emit(LoadingState());
    Future.wait(
            [getMyCars(context), getBranches(context), getCountries(context)])
        .then((value) => emit(SuccessState()))
        .catchError((e) => emit(ErrorState()));
  }

  List<CountriesModel> countries = [];

  Future getCountries(context) async {
    final response = await ServicesRepo.fetchCountries(context);
    if (response != null) {
      countries = response;
    } else {}
  }

  selectBranch(BranchesDropDownModel branch) {
    mainReservation.branchId = branch.id;
    emit(SelectBranchState());
  }

  selectcar(MyCarsModel car) {
    mainReservation.carId = car.id;
    emit(SelectCarState());
  }

  DateTime selectedDate = DateTime.now();

  selectDate(
    context,
    DateTime dateTime,
  ) {
    selectedDate = dateTime;
    mainReservation.reservationDate =
        '${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:00:00';

    emit(SelectDateState());
  }

  int? selectedCountry;
  selectCountry(context, int index) {
    selectedCountry = index;

    emit(SelectContryState());
  }
}

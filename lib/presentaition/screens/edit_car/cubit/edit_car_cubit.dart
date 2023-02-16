import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/models/brands_model.dart';
import '../../../../domain/models/models_car_model.dart';
import '../../../../domain/repositry/brands_repo/brands_rebo.dart';

part 'edit_car_state.dart';

class EditCarCubit extends Cubit<EditCarState> {
  EditCarCubit() : super(EditCarInitial());
  static EditCarCubit get(context) => BlocProvider.of(context);

  // getData(context) {
  //   emit(DataLoadingState());
  //   Future.wait([getBrands(context), getCarsModels(context)])
  //       .then((value) => emit(DataSucessState()))
  //       .catchError((e) => emit(DataErrorState()));
  // }

  // List<BrandsModel> brands = [];
  // Future getBrands(context) async {
  //   //emit(BrandsLoadingState());
  //   final response = await BrandsRepo.getBrands(context);
  //   if (response != null) {
  //     brands = response;

  //     print(brands);
  //     //  emit(BrandsSuccessState());
  //   } else {
  //     //emit(BrandsErrorState());
  //   }
  // }

  // List<ModelsCarsModel> model = [];
  // Future getCarsModels(context) async {
  //   final response = await BrandsRepo.fetchCarModels(context);
  //   if (response != null) {
  //     model = response;

  //     print(model.length);
  //   } else {
  //   }
  // }
}

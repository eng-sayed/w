import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/utiles/utiles.dart';
import '../../../../data/local/sharedpref.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());
  static OnBoardingCubit get(context) => BlocProvider.of(context);
  late PageController controller;
  int currentPage = 0;
  saveOnBording() {
    CacheHelper.saveData(key: "onboard", value: true);
  }
}

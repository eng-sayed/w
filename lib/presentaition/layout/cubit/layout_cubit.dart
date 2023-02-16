import 'package:bloc/bloc.dart';
import 'package:bottom_bar_matu/bottom_bar_matu.dart';
// import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
// import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meta/meta.dart';
import 'package:supa_kota/core/themes/colors.dart';

import '../../../core/utiles/utiles.dart';
import '../../../domain/models/aboutus_model.dart';
import '../../../domain/repositry/aboutus_repo/abotus_repo.dart';
import '../../../domain/repositry/services_repo/services_repo.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);
  late TabController tabController;
  List<BottomBarItem> tabItems = List.of([
    BottomBarItem(
        iconBuilder: (color) => Image.asset(
              'assets/images/0.png',
              height: 30,
              width: 30,
            )),
    BottomBarItem(
        iconBuilder: (color) =>
            Image.asset('assets/images/1.png', height: 30, width: 30)),
    BottomBarItem(
        iconBuilder: (color) =>
            Image.asset('assets/images/2.png', height: 30, width: 30)),
    BottomBarItem(
        iconBuilder: (color) =>
            Image.asset('assets/images/3.png', height: 30, width: 30)),
    BottomBarItem(
        iconBuilder: (color) =>
            Image.asset('assets/images/4.png', height: 30, width: 30)),
  ]);
  List<String> phones = [];

  // Future getPhoneCAll(context) async {
  //   final response = await ServicesRepo.phoneNum(context);
  //   if (response != null) {
  //     phones = response;
  //     Utiles.Allphones = phones;
  //     print(Utiles.Allphones);
  //     emit(Sucess());
  //   }
  //   emit(Error());
  // }

  AboutUsModel? aboutUsModel;
  Future getAboutUs(context) async {
    final response = await AboutUsRepo.fetchAboutUs(context);
    if (response != null) {
      aboutUsModel = response['about'];
      phones = response['phones'];
      Utiles.Allphones = phones;
      Utiles.complaint_phone = aboutUsModel?.complaint_phone ?? '';
      print(Utiles.Allphones);
      emit(Sucess());
    } else {
      emit(Error());
    }
  }

  void changeTab(int tab) {
    switch (tab) {
      case 0:
        tabController.animateTo(0);
        break;
      case 1:
        tabController.animateTo(1);
        break;
      case 2:
        tabController.animateTo(2);
        break;
      case 3:
        tabController.animateTo(3);
        break;
      case 4:
        tabController.animateTo(4);
        break;
      default:
    }
    emit(HomeLayoutChangeScreenState());
  }
}

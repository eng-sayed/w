import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_kota/core/utiles/navigate.dart';
import 'package:supa_kota/presentaition/layout/layout.dart';
import 'package:supa_kota/presentaition/screens/auth/auth_screen.dart';
import 'package:supa_kota/presentaition/screens/on_boarding/on_boarding.dart';

import '../../../../core/utiles/utiles.dart';
import '../../../../cubit/app_cubit.dart';
import '../../../../data/local/sharedpref.dart';
import '../../../../domain/models/countries_model.dart';
import '../../../../domain/repositry/splash_repo/splash_repo.dart';
import '../../gallery/gallery_screen.dart';

part 'splach_state.dart';

class SplachCubit extends Cubit<SplachState> {
  SplachCubit() : super(SplachInitial());
  static SplachCubit get(context) => BlocProvider.of(context);

  getUserData(context) async {
    Utiles.token = await CacheHelper.loadData(key: "token") ?? "";
    Utiles.email = await CacheHelper.loadData(key: "email") ?? "";
    Utiles.UserId = await CacheHelper.loadData(key: "userid") ?? "";
    Utiles.phone = await CacheHelper.loadData(key: "phone") ?? "";
    Utiles.name = await CacheHelper.loadData(key: "name") ?? "";
    Utiles.onBoard = await CacheHelper.loadData(key: "onboard") ?? false;
    Utiles.start = await CacheHelper.loadData(key: "start") ?? false;
    if (Utiles.onBoard == false) {
      navigateReplacement(context: context, route: OnboardingScreen());
      Utiles.isLogin = false;
    } else {
      if (Utiles.token != '') {
        print(Utiles.token);
        Utiles.isLogin = true;
        navigateReplacement(context: context, route: HomeLayout());
      } else {
        navigateReplacement(context: context, route: AuthScreen());
      }
    }
  }

  List<CountriesModel> cites = [];
  List<CountriesModel> countries = [];

  Future getCountries(context) async {
    final response = await SplashRepo.fetchCountries(context, false);
    if (response != null) {
      countries = response;
    }
  }

  Future getCites(context, id, {bool loading = false}) async {
    final response = await SplashRepo.fetchCites(context, id, loading);
    if (response != null) {
      cites = response;
      final app = AppCubit.get(context);

      app.emit(ChangeStateApp());
    }
  }

  Future getCountriesAndCites(context) async {
    await getCountries(context).then((value) async {
      print(countries);
      if (countries.isNotEmpty)
        await getCites(context, countries.first.id.toString());
    }).catchError(() {});
  }
}

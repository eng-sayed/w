import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:supa_kota/core/utiles/navigate.dart';
import 'package:supa_kota/domain/models/partner_model.dart';
import 'package:supa_kota/domain/repositry/aboutus_repo/abotus_repo.dart';

import '../../../../cubit/app_cubit.dart';
import '../../../../domain/models/countries_model.dart';
import '../../../../domain/repositry/splash_repo/splash_repo.dart';
import '../../call/call.dart';

part 'become_partner_state.dart';

class BecomePartnerCubit extends Cubit<BecomePartnerState> {
  BecomePartnerCubit() : super(BecomePartnerInitial());
  static BecomePartnerCubit get(context) => BlocProvider.of(context);

  List<CountriesModel> cites = [];
  List<CountriesModel> countries = [];
  PartnerModel? partnerModel;
  bePartner(context) async {
    final response =
        await AboutUsRepo.becomePartner(partnerModel ?? PartnerModel());
    if (response != null) {
      navigate(context: context, route: CallScreen());
    }
  }

  Future getCountries(context) async {
    final response = await SplashRepo.fetchCountries(context, true);
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
    emit(LoadingCountries());
    await getCountries(context).then((value) async {
      print(countries);
      if (countries.isNotEmpty)
        await getCites(context, countries.first.id.toString());
      emit(SuccessCountries());
    }).catchError(() {
      emit(ErrorCountries());
    });
  }
}

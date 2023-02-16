import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:supa_kota/core/utiles/utiles.dart';
import 'package:supa_kota/domain/repositry/aboutus_repo/abotus_repo.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../../domain/models/aboutus_model.dart';
import '../../../../domain/models/branches_model.dart';
import '../../../../domain/models/branche_of_country_model.dart';
import '../../../../domain/models/countries_model.dart';
import '../../../../domain/repositry/services_repo/services_repo.dart';

part 'about_us_state.dart';

class AboutUsCubit extends Cubit<AboutUsState> {
  AboutUsCubit() : super(AboutUsInitial());
  static AboutUsCubit get(context) => BlocProvider.of(context);
  late VideoPlayerController controller;
  late Future<void> initializeVideoPlayerFuture;
  late YoutubePlayerController cont;

  AboutUsModel? aboutUsModel;
  Future getAboutUs(context) async {
    emit(AboutUsLoadingState());
    final response = await AboutUsRepo.fetchAboutUs(context);
    if (response != null) {
      aboutUsModel = response['about'];
      Utiles.privacy = aboutUsModel?.privacyPolicy ?? '';
      if (aboutUsModel?.youtube_video_link?.isNotEmpty ?? false) {
        cont = YoutubePlayerController.fromVideoId(
            videoId: getVideoID(aboutUsModel?.youtube_video_link ?? ''),
            autoPlay: false,
            params: const YoutubePlayerParams(showFullscreenButton: true));
      }

      emit(AboutUsSuccessState());
    } else {
      emit(AboutUsErrorState());
    }
  }

  int indexCrsoul = 0;
  changeSlider(index) {
    indexCrsoul = index;
    emit(ChangeSLiderState());
  }

  List<BranchesOfCountriesModel> branches = [];
  List<CountriesModel> countries = [];
  getData(context) {
    emit(AboutUsLoadingState());
    Future.wait([getAboutUs(context), getCountries(context)])
        .then((value) => emit(AboutUsSuccessState()))
        .catchError((e) => emit(AboutUsErrorState()));
  }

  Future getCountries(context) async {
    final response = await ServicesRepo.fetchCountries(context);
    if (response != null) {
      countries = response;
    } else {}
  }

  Future getBranches(id, context) async {
    branches = [];
    final response =
        await ServicesRepo.fetchBranchCountries(id.toString(), context);
    if (response != null) {
      branches = response;

      emit(BranchesSuccess());
      return branches.isEmpty ? false : true;
    } else {
      emit(BranchesError());
      return false;
    }
  }

  String getVideoID(String url) {
    url = url.replaceAll("https://www.youtube.com/watch?v=", "");
    url = url.replaceAll("https://m.youtube.com/watch?v=", "");
    return url;
  }
}

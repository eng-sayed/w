import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/models/brands_model.dart';
import '../../../../domain/models/models_car_model.dart';
import '../../../../domain/repositry/brands_repo/brands_rebo.dart';

part 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit() : super(GalleryInitial());
  static GalleryCubit get(context) => BlocProvider.of(context);
  List<BrandsModel> brands = [];
  List<ModelsCarsModel> models = [];
  List<String> allGalleryModels = [];
  List<String> images = [];

  getBrands(context) async {
    emit(BrandsLoadingState());
    final response = await BrandsRepo.getBrands(context);
    if (response != null) {
      brands = response;

      emit(BrandsSuccessState());
    } else {
      emit(BrandsErrorState());
    }
  }

  changeImage(index, bool all) {
    all ? images = allGalleryModels : images = models[index].gallery ?? [];
    emit(ChangeImageState());
  }

  getModelOfBrands(id, context) async {
    allGalleryModels = [];
    models = [];
    emit(ModelLoadingState());
    final response = await BrandsRepo.getModelOfBrands(id, context);
    if (response != null) {
      response.forEach((element) {
        if (element.gallery?.isNotEmpty ?? false) models.add(element);
      });
      for (var e in models) {
        for (var image in e.gallery ?? []) {
          allGalleryModels.add(image);
        }
      }

      images = allGalleryModels;

      emit(ModelSuccessState());
    } else {
      emit(ModelErrorState());
    }
  }
}

import '../../../core/utiles/utiles.dart';
import '../../../data/api/my_api.dart';
import '../../endpoints/endpoints.dart';
import '../../models/brands_model.dart';
import '../../models/models_car_model.dart';

class BrandsRepo {
  static getBrands(context) async {
    List<BrandsModel> brands = [];
    final response = await DioHelper.getData(
        context: context,
        url: EndPoints.GET_BRANDS,
        token: Utiles.token,
        loading: false);
    print(response);
    if (response != null) {
      response.data['data']["brands"].forEach((e) {
        brands.add(BrandsModel.fromJson(e));
      });

      print(brands);

      return brands;
    }
  }

  static Future<List<ModelsCarsModel>?> getModelOfBrands(id, context) async {
    List<ModelsCarsModel> models = [];
    final response = await DioHelper.getData(
        context: context,
        url: EndPoints.GET_BRANDS + id + '/models',
        token: Utiles.token,
        loading: true);
    print(response);
    if (response != null) {
      response.data['data']["models"].forEach((e) {
        models.add(ModelsCarsModel.fromJson(e));
      });

      print(models);

      return models;
    }
  }

  static fetchCarModels(context) async {
    List<ModelsCarsModel> models = [];
    final response = await DioHelper.getData(
        context: context,
        url: EndPoints.GET_CAR_MODELS,
        token: Utiles.token,
        loading: false);
    print(response);
    if (response != null) {
      response.data['data']["models"].forEach((e) {
        models.add(ModelsCarsModel.fromJson(e));
      });

      print(models);

      return models;
    }
  }

  static fetchModelsOfBrand(context, id, {bool? addCarLoading}) async {
    List<ModelsCarsModel> models = [];
    final response = await DioHelper.getData(
        context: context,
        url: EndPoints.GET_BRANDS + id + '/models',
        token: Utiles.token,
        loading: addCarLoading ?? true);
    print(response);
    if (response != null) {
      response.data['data']["models"].forEach((e) {
        models.add(ModelsCarsModel.fromJson(e));
      });

      print(models);

      return models;
    }
  }
}

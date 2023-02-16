import '../../../data/api/my_api.dart';
import '../../endpoints/endpoints.dart';
import '../../models/countries_model.dart';

class SplashRepo {
  static Future<List<CountriesModel>?> fetchCountries(
      context, bool isPartner) async {
    List<CountriesModel> countries = [];
    String point = isPartner ? '?partner=1' : '?registration=1';
    final response = await DioHelper.getData(
      context: context,
      url: '${EndPoints.GET_COUNTRIES}${point}',
      //  token: Utiles.token,
      // loading: true
    );
    print(response);
    if (response != null) {
      response.data['data']["countries"].forEach((e) {
        countries.add(CountriesModel.fromJson(e));
      });

      print(countries);
      print('----------------------');

      return countries;
    }
  }

  static Future<List<CountriesModel>?> fetchCites(context, id, loading) async {
    List<CountriesModel> cites = [];

    final response = await DioHelper.getData(
        context: context,
        url: EndPoints.GET_COUNTRIES + id + '/cities',
        //  token: Utiles.token,
        loading: loading);
    print(response);
    if (response != null) {
      response.data['data']["cities"].forEach((e) {
        cites.add(CountriesModel.fromJson(e));
      });

      print(cites);
      print('----------------------');

      return cites;
    }
  }
}

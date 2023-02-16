import 'package:supa_kota/domain/models/aboutus_model.dart';

import '../../../core/utiles/utiles.dart';
import '../../../data/api/my_api.dart';
import '../../endpoints/endpoints.dart';
import '../../models/partner_model.dart';

class AboutUsRepo {
  static fetchAboutUs(context) async {
    List<String> phones = [];
    final response = await DioHelper.getData(
        url: EndPoints.GET_Setting, context: context, loading: false);
    print(response);
    if (response != null) {
      AboutUsModel aboutUsModel =
          AboutUsModel.fromJson(response.data['data']["settings"]);
      phones = response.data['data']["settings"]["contact_phones"]
          .toString()
          .split(',');
      return {'about': aboutUsModel, 'phones': phones};
    }
  }

  static becomePartner(PartnerModel partnerModel) async {
    final response = await DioHelper.postData(
        url: EndPoints.BECOME_PARTNER,
        loading: true,
        token: Utiles.token,
        body: partnerModel.toMap());
    print(response);
    if (response != null) {
      return response.data['message'];
    }
  }
}

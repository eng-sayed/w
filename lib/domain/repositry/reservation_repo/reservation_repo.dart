import '../../../core/utiles/utiles.dart';
import '../../../data/api/my_api.dart';
import '../../endpoints/endpoints.dart';
import '../../models/reservations_model.dart';

class ReservationRepo {
  static fetchAllReservation(context) async {
    List<ReservationsModel> reservationsModel = [];
    final response = await DioHelper.getData(
        context: context,
        url: EndPoints.GET_RESERVATION,
        loading: true,
        token: Utiles.token);
    print(response);
    if (response != null) {
      response.data['data']["reservations"].forEach((e) {
        reservationsModel.add(ReservationsModel.fromJson(e));
      });

      return reservationsModel;
    }
  }

  static fetchOneReservation(id, context) async {
    ReservationsModel reservationsModel;
    final response = await DioHelper.getData(
        context: context,
        url: EndPoints.GET_RESERVATION + id.toString(),
        loading: false,
        token: Utiles.token);
    print(response);
    if (response != null) {
      reservationsModel =
          ReservationsModel.fromJson(response.data['data']["reservation"]);

      return reservationsModel;
    }
  }
}

import 'package:supa_kota/domain/models/notification_model.dart';

import '../../../core/utiles/utiles.dart';
import '../../../data/api/my_api.dart';
import '../../endpoints/endpoints.dart';

class NptificationRepo {
  static Future<List<NotificationModel>?> fetchMyNotification(context) async {
    List<NotificationModel> myNotifications = [];
    final response = await DioHelper.getData(
        context: context,
        url: EndPoints.GET_MY_NOTIFICATIONS,
        loading: true,
        token: Utiles.token);
    print(response);
    if (response != null) {
      response.data['data']["notifications"].forEach((s) {
        myNotifications.add(NotificationModel.fromJson(s));
      });

      return myNotifications;
    }
  }

  static Future<List<NotificationModel>?> fetchAllNotification(context) async {
    List<NotificationModel> notifications = [];
    final response = await DioHelper.getData(
        context: context,
        url: EndPoints.GET_NOTIFICATIONS,
        loading: true,
        token: Utiles.token);
    print(response);
    if (response != null) {
      response.data['data']["notifications"].forEach((s) {
        notifications.add(NotificationModel.fromJson(s));
      });

      return notifications;
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/models/notification_model.dart';
import '../../../../domain/repositry/notification_repo/notification_repo.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  static NotificationsCubit get(context) => BlocProvider.of(context);
  List<NotificationModel> allNotifications = [];
  List<NotificationModel> myNotifications = [];
  bool isAll = true;
  // allNotification(context) async {
  //   isAll = true;
  //   await getAllNotifications(context);
  // }

  // myNotification(context) async {
  //   isAll = false;
  //   await getMyNotifications(context);
  // }

  getAllNotifications(context) async {
    emit(NotificationsLoadingState());
    final response = await NptificationRepo.fetchAllNotification(context);
    if (response != null) {
      allNotifications = response;

      emit(NotificationsSuccessState());
    } else {
      emit(NotificationsErrorState());
    }
  }

  // getMyNotifications(context) async {
  //   emit(MyNotificationsLoadingState());
  //   final response = await NptificationRepo.fetchMyNotification(context);
  //   if (response != null) {
  //     myNotifications = response;

  //     emit(MyNotificationsSuccessState());
  //   } else {
  //     emit(MyNotificationsErrorState());
  //   }
  // }
}

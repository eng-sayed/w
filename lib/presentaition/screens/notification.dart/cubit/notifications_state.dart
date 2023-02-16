part of 'notifications_cubit.dart';

@immutable
abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsSuccessState extends NotificationsState {}

class NotificationsLoadingState extends NotificationsState {}

class MyNotificationsLoadingState extends NotificationsState {}

class MyNotificationsSuccessState extends NotificationsState {}

class NotificationsErrorState extends NotificationsState {}

class MyNotificationsErrorState extends NotificationsState {}

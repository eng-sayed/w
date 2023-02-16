part of 'car_details_cubit.dart';

@immutable
abstract class CarDetailsState {}

class CarDetailsInitial extends CarDetailsState {}

class MyCarSuccessState extends CarDetailsState {}

class MyCarErrorState extends CarDetailsState {}

class MyCarLoadingState extends CarDetailsState {}

class CarSuccessState extends CarDetailsState {}

class CarErrorState extends CarDetailsState {}

class CarLoadingState extends CarDetailsState {}

class ChangeIndexReservations extends CarDetailsState {}

class ServicesSecChild extends CarDetailsState {}

class ServicesFirstChild extends CarDetailsState {}

class DeteteCarsErrorState extends CarDetailsState {}

class DeleteCarsSuccessState extends CarDetailsState {}

class CarsErrorState extends CarDetailsState {}

class CarsSuccessState extends CarDetailsState {}

class CarsLoadingState extends CarDetailsState {}

class ErrorReviewState extends CarDetailsState {}

class SuccessReviewState extends CarDetailsState {}

class OneErrorReservations extends CarDetailsState {}

class OneSuccessReservations extends CarDetailsState {}

class OneLoadingReservations extends CarDetailsState {}

class AddedImageState extends CarDetailsState {}

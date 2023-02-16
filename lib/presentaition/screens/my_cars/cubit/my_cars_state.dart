part of 'my_cars_cubit.dart';

@immutable
abstract class MyCarsState {}

class MyCarsInitial extends MyCarsState {}

class CarsLoadingState extends MyCarsState {}

class CarsSuccessState extends MyCarsState {}

class CarsErrorState extends MyCarsState {}

class ComplainsErrorState extends MyCarsState {}

class DeleteCarsSuccessState extends MyCarsState {}

class DeteteCarsErrorState extends MyCarsState {}

class AddedImageState extends MyCarsState {}

class GetCarPartsError extends MyCarsState {}

class GetEndedServicesError extends MyCarsState {}

class SuccessState extends MyCarsState {}

class ErrorState extends MyCarsState {}

class ChangePartId extends MyCarsState {}

class ChangeServiceId extends MyCarsState {}

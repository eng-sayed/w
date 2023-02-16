part of 'add_car_cubit.dart';

@immutable
abstract class AddCarState {}

class AddCarInitial extends AddCarState {}

class BrandsSuccessState extends AddCarState {}

class BrandsErrorState extends AddCarState {}

class BrandsLoadingState extends AddCarState {}

class MyCarSuccessState extends AddCarState {}

class MyCarErrorState extends AddCarState {}

class MyCarLoadingState extends AddCarState {}

class AddedImageState extends AddCarState {}

class ModelBrandState extends AddCarState {}

class EditMyCarSuccessState extends AddCarState {}

class EditMyCarErrorState extends AddCarState {}

class EditMyCarLoadingState extends AddCarState {}

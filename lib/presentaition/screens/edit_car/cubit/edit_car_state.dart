part of 'edit_car_cubit.dart';

@immutable
abstract class EditCarState {}

class EditCarInitial extends EditCarState {}

class DataLoadingState extends EditCarState {}

class DataSucessState extends EditCarState {}

class DataErrorState extends EditCarState {}

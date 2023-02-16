part of 'about_us_cubit.dart';

@immutable
abstract class AboutUsState {}

class AboutUsInitial extends AboutUsState {}

class AboutUsErrorState extends AboutUsState {}

class AboutUsSuccessState extends AboutUsState {}

class AboutUsLoadingState extends AboutUsState {}

class ChangeSLiderState extends AboutUsState {}

class BranchesSuccess extends AboutUsState {}

class BranchesError extends AboutUsState {}

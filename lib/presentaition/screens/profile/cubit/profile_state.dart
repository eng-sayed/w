part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileSuccessState extends ProfileState {}

class ProfileErrorState extends ProfileState {}

class DeleteErrorState extends ProfileState {}

class DeleteSuccessState extends ProfileState {}

class AddedImageState extends ProfileState {}

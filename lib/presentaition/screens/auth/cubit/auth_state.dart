part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthChangeScreenState extends AuthState {}

// class LoginScreenState extends AuthState {}

class ChangePrivacyState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginErrorState extends AuthState {}

class RegisterErrorState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class AddedImageState extends AuthState {}

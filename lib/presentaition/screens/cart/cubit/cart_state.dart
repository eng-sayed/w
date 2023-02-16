part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class SuccessRemoveCartState extends CartState {}

class LoadingCartState extends CartState {}

class SuccessCartState extends CartState {}

class ErrorCartState extends CartState {}

class LoadingState extends CartState {}

class SuccessState extends CartState {}

class ErrorState extends CartState {}

class SelectBranchState extends CartState {}

class SelectCarState extends CartState {}

class SelectDateState extends CartState {}

class SelectContryState extends CartState {}

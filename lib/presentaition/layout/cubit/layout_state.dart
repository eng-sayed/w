part of 'layout_cubit.dart';

@immutable
abstract class LayoutState {}

class LayoutInitial extends LayoutState {}

class HomeLayoutChangeScreenState extends LayoutInitial {}

class Error extends LayoutInitial {}

class Sucess extends LayoutInitial {}

part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class BlogsErrorState extends NewsState {}

class BlogsSuccessState extends NewsState {}

class BlogsLoadingState extends NewsState {}

class ChangeSLiderState extends NewsState {}

class ChangeProfile extends NewsState {}

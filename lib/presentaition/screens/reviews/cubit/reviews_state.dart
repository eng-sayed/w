part of 'reviews_cubit.dart';

@immutable
abstract class ReviewsState {}

class ReviewsInitial extends ReviewsState {}

class ReviewsLoadingState extends ReviewsState {}

class ReviewsErrorState extends ReviewsState {}

class ReviewsSuccsessState extends ReviewsState {}

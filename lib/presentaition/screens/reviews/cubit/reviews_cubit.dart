import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:supa_kota/domain/repositry/reviews_repo/rewiews_repo.dart';

import '../../../../domain/models/review_model.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit() : super(ReviewsInitial());
  static ReviewsCubit get(context) => BlocProvider.of(context);
  List<ReviewModel> reviews = [];
  int? lastPage;
  bool isLoading = false;

  getReviews(context, page) async {
    page == 1 ? isLoading = false : isLoading = true;
    emit(ReviewsLoadingState());
    final response = await ReviewsRepo.fetchReviews(context, page);
    if (response != null) {
      page == 1
          ? (reviews = response['reviews'])
          : reviews.addAll(response['reviews']);
      lastPage = response['lastPage'];
      isLoading = false;
      print(reviews);
      emit(ReviewsSuccsessState());
      return reviews;
    } else {
      emit(ReviewsErrorState());
      return [];
    }
  }
}

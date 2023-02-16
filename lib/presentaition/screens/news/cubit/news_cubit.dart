import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:supa_kota/domain/models/blogs_model.dart';
import 'package:supa_kota/domain/repositry/blogs_repo/blogs_repo.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());
  static NewsCubit get(context) => BlocProvider.of(context);
  List<Blogs> blogs = [];
  List<String> gallery = [];
  int? lastPage;
  bool isLoading = false;
  getBlogs(context, page) async {
    if (page == 1) {
      isLoading = false;
      emit(BlogsLoadingState());
    } else {
      isLoading = true;
    }

    final response = await BlogsRepo.getAllBlogs(context, page);
    if (response != null) {
      if (page == 1) {
        blogs = response['blogs'].blogs?.reversed.toList() ?? [];
        // reversedBlogs = response.blogs ?? [];
      } else {
        blogs.addAll(response['blogs'].blogs);
      }

      lastPage = response['lastPage'];
      isLoading = false;

      gallery = response['blogs'].gallery ?? [];

      print(blogs);
      emit(BlogsSuccessState());
    } else {
      emit(BlogsErrorState());
    }
  }

  int indexCrsoul = 0;
  changeSlider(index) {
    indexCrsoul = index;
    emit(ChangeSLiderState());
  }
}

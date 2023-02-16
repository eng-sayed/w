import '../../../core/utiles/utiles.dart';
import '../../../data/api/my_api.dart';
import '../../endpoints/endpoints.dart';
import '../../models/review_model.dart';

class ReviewsRepo {
  static Future fetchReviews(context, page) async {
    // if (page == 1) {
    //   reviews.clear();
    // }
    List<ReviewModel> reviews = [];

    final response = await DioHelper.getData(
        context: context,
        url: EndPoints.GET_REVIEWS,
        token: Utiles.token,
        query: {'page': page, 'perPage': 7});
    print(response);
    if (response != null) {
      response.data['data']["reviews"].forEach((e) {
        reviews.add(ReviewModel.fromJson(e));
      });
      // List<ServicesModel> user =
      // response.data['data']["services"] as List<ServicesModel>;

      print(reviews);
      print('----------------------');

      // print(user);

      return {
        "reviews": reviews,
        'lastPage': response.data['pagination_info']['last_page']
      };
    }
  }
}

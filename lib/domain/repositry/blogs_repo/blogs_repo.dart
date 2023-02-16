import '../../../core/utiles/utiles.dart';
import '../../../data/api/my_api.dart';
import '../../endpoints/endpoints.dart';
import '../../models/blogs_model.dart';

class BlogsRepo {
  static Future getAllBlogs(context, page) async {
    List<Blogs> blogs = [];
    List<String> gallery = [];
    final response = await DioHelper.getData(
        url: EndPoints.GET_BLOGS,
        token: Utiles.token,
        context: context,
        query: {'page': page, 'perPage': 5});
    print(response);
    if (response != null) {
      response.data['data']["blogs"].forEach((e) {
        blogs.add(Blogs.fromJson(e));
      });
      response.data['data']["gallery"].forEach((e) {
        gallery.add(e);
      });

      print(blogs);
      AllDataBlogModel allDataBlogModel =
          AllDataBlogModel(blogs: blogs, gallery: gallery);
      return {
        "blogs": allDataBlogModel,
        'lastPage': response.data['pagination_info']['last_page']
      };
    }
    return null;
  }
}

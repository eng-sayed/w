import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_kota/core/themes/colors.dart';

import 'package:supa_kota/presentaition/components/background_image.dart';
import 'package:supa_kota/presentaition/components/custom_text.dart';
import 'package:supa_kota/presentaition/components/direction.dart';
import 'package:supa_kota/presentaition/components/loadinganderror.dart';
import 'package:supa_kota/presentaition/screens/news/cubit/news_cubit.dart';
import 'package:supa_kota/presentaition/screens/news/widget/first_blog.dart';

import 'widget/appbar_news.dart';
import 'widget/blog_widget.dart';
import 'widget/image_blog_widget.dart';
import 'widget/offers.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  ScrollController controller = ScrollController();
  @override
  @override
  void initState() {
    final blogCubit = NewsCubit.get(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await blogCubit.getBlogs(context, page);
    });
    controller.addListener(() async {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (((blogCubit.lastPage) ?? 1) >= page) {
          page += 1;
          await blogCubit.getBlogs(context, page);
        }
      }
    });
    super.initState();
  }

  CarouselController? carouselController;
  @override
  Widget build(BuildContext context) {
    final blogCubit = NewsCubit.get(context);
    double width = 50;
    return Scaffold(
      body: Background(
        child: BlocConsumer<NewsCubit, NewsState>(
            listener: (context, state) {},
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  page = 1;
                  await blogCubit.getBlogs(context, 1);
                },
                child: Direction(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBarNews(),
                      Expanded(
                        child: LoadingAndError(
                          function: () async {
                            await blogCubit.getBlogs(context, 1);
                          },
                          isError: state is BlogsErrorState,
                          isLoading: state is BlogsLoadingState,
                          child: ListView(
                            controller: controller,
                            padding: EdgeInsets.all(5),
                            children: [
                              if (blogCubit.blogs.isNotEmpty)
                                FirestBlog(blogCubit: blogCubit),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                color: AppColors.primiry,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: CustomText(
                                    'Offers'.tr(),
                                    fontsize: 20,
                                    weight: FontWeight.w200,
                                    color: AppColors.white,
                                    align: TextAlign.center,
                                  ),
                                ),
                              ),
                              Offers(blogCubit: blogCubit),
                              if (blogCubit.blogs.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: blogCubit.blogs.length - 1 > 4
                                        ? 4
                                        : blogCubit.blogs.length - 1,
                                    gridDelegate:
                                        new SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 5,
                                            mainAxisExtent: 250),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return BlogWidget(
                                          blogCubit: blogCubit, index: index);
                                    },
                                  ),
                                ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: blogCubit.blogs.length - 5 > 0
                                    ? blogCubit.blogs.length - 5
                                    : 0,
                                gridDelegate:
                                    new SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 0,
                                        mainAxisSpacing: 0,
                                        mainAxisExtent: 150),
                                itemBuilder: (BuildContext context, int index) {
                                  return ImageBlogWidget(
                                      blogCubit: blogCubit, index: index);
                                },
                              ),
                              if (blogCubit.isLoading)
                                Center(child: CircularProgressIndicator())
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

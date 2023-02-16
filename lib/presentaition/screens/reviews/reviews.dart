import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_kota/presentaition/components/background_image.dart';
import 'package:supa_kota/presentaition/screens/reviews/widgets/appbar_review.dart';
import 'cubit/reviews_cubit.dart';
import 'widgets/review_widget.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  ScrollController controller = ScrollController();
  @override
  void initState() {
    final reviewsCubit = ReviewsCubit.get(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await reviewsCubit.getReviews(context, page);
    });
    controller.addListener(() async {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (((reviewsCubit.lastPage) ?? 1) >= page) {
          page += 1;
          await reviewsCubit.getReviews(context, page);
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewsCubit, ReviewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          final reviewsCubit = ReviewsCubit.get(context);
          return Background(
            child: Scaffold(
                body: RefreshIndicator(
              onRefresh: () async {
                page = 1;
                await reviewsCubit.getReviews(context, 1);
              },
              child: Column(
                children: [
                  AppBarReview(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                          controller: controller,
                          padding: EdgeInsets.all(5),
                          itemCount: reviewsCubit.reviews.length,
                          itemBuilder: (context, index) {
                            return ReviewWidget(
                              reviewsCubit: reviewsCubit,
                              index: index,
                            );
                          }),
                    ),
                  ),
                  if (reviewsCubit.isLoading)
                    Center(child: CircularProgressIndicator())
                ],
              ),
            )),
          );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

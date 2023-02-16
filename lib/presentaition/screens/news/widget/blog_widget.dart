import 'package:flutter/material.dart';

import '../../../../core/utiles/navigate.dart';
import '../../../components/custom_text.dart';
import '../../../components/network_image.dart';
import '../blog_details.dart';
import '../cubit/news_cubit.dart';

class BlogWidget extends StatelessWidget {
  const BlogWidget({
    Key? key,
    required this.blogCubit,
    required this.index,
  }) : super(key: key);

  final NewsCubit blogCubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          navigate(
              context: context,
              route: BlogDetails(blogCubit: blogCubit, index: index + 1));
        },
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: NetworkImagesWidgets(
                  blogCubit.blogs[index + 1].image ?? '',
                  width: double.infinity,
                  height: 50,
                  fit: BoxFit.fill,
                  // width: double.infinity,
                ),
              ),
            ),
            CustomText(
              blogCubit.blogs[index + 1].title ?? '',
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}

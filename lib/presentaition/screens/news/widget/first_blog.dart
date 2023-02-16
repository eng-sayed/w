import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:supa_kota/core/utiles/utiles.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/navigate.dart';
import '../../../components/custom_text.dart';
import '../../../components/network_image.dart';
import '../blog_details.dart';
import '../cubit/news_cubit.dart';

class FirestBlog extends StatelessWidget {
  const FirestBlog({
    Key? key,
    required this.blogCubit,
  }) : super(key: key);

  final NewsCubit blogCubit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigate(
            context: context,
            route: BlogDetails(
              blogCubit: blogCubit,
              index: blogCubit.blogs.indexOf(blogCubit.blogs.first),
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  blogCubit.blogs.first.title ?? "",
                  fontsize: 20,
                ),
                CustomText(
                  (blogCubit.blogs.first.createdAt ?? '').parseDateTime(),
                  color: AppColors.primiry,
                  fontsize: 17,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: NetworkImagesWidgets(
              blogCubit.blogs.first.image ?? '',
              fit: BoxFit.fill,
              height: 320,
              width: 500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReadMoreText(
                  blogCubit.blogs[0].content ?? '',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'readMore'.tr(),
                  trimExpandedText: 'readLess'.tr(),
                  moreStyle: TextStyle(fontSize: 15, color: AppColors.primiry),
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

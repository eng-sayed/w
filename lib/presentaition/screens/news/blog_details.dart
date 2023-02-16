import 'package:flutter/material.dart';
import 'package:supa_kota/core/utiles/responsive.dart';
import 'package:supa_kota/core/utiles/utiles.dart';
import 'package:supa_kota/presentaition/components/background_image.dart';
import 'package:supa_kota/presentaition/components/direction.dart';
import 'package:supa_kota/presentaition/screens/news/cubit/news_cubit.dart';
import 'package:supa_kota/presentaition/screens/news/widget/appbar_news.dart';

import '../../../core/themes/colors.dart';
import '../../components/custom_text.dart';
import '../../components/network_image.dart';

class BlogDetails extends StatelessWidget {
  BlogDetails({super.key, this.blogCubit, required this.index});
  NewsCubit? blogCubit;
  int index;
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primiry,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.white,
                      )),
                  Expanded(
                    child: CustomText(
                      blogCubit!.blogs[index].title ?? "",
                      textStyleEnum: TextStyleEnum.title,
                      color: AppColors.white,
                      fontsize: 22,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Direction(
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 300.w,
                            child: CustomText(
                              blogCubit!.blogs[index].title ?? "",
                              fontsize: 20,
                            ),
                          ),
                          CustomText(
                            blogCubit!.blogs[index].createdAt!
                                    .parseDateTime() ??
                                '',
                            color: AppColors.primiry,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: NetworkImagesWidgets(
                          blogCubit!.blogs[index].image ?? '',
                          fit: BoxFit.cover,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: CustomText(
                        blogCubit!.blogs[index].content ?? '',
                        // textDirection: TextDirection.rtl,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

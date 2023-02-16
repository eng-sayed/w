import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:supa_kota/core/utiles/responsive.dart';
import 'package:supa_kota/presentaition/screens/reviews/widgets/video_of_review.dart';

import '../../../../core/themes/colors.dart';
import '../../../components/custom_text.dart';
import '../../../components/default_button.dart';
import '../../../components/network_image.dart';
import '../cubit/reviews_cubit.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    Key? key,
    required this.reviewsCubit,
    required this.index,
  }) : super(key: key);

  final ReviewsCubit reviewsCubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  reviewsCubit.reviews[index].user != null
                      ? CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.white,
                          backgroundImage: Image.network(
                            reviewsCubit.reviews[index].user?.avatar ?? '',
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset('assets/images/user1.png');
                            },
                          ).image,
                        )
                      : CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.white,
                          backgroundImage: Image.asset(
                            'assets/images/user1.png',
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset('assets/images/user1.png');
                            },
                          ).image,
                        ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reviewsCubit.reviews[index].user != null
                            ? CustomText(
                                reviewsCubit.reviews[index].user?.name ?? '',
                                fontsize: 18,
                              )
                            : CustomText(
                                reviewsCubit.reviews[index].user_name ?? '',
                                fontsize: 18,
                              ),
                        RatingBar.builder(
                          initialRating:
                              (reviewsCubit.reviews[index].score ?? 0)
                                  .toDouble(),
                          itemSize: 18,
                          minRating: 1,

                          direction: Axis.horizontal,
                          // allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20,
                          ),
                          ignoreGestures: true,
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              //TODO  CustomText('1 day ago')
            ],
          ),
          subtitle: ReadMoreText(
            // 'Who We Are Supa Koto Is A Trusted Name In Protection FieldUPA KOTO SUPAKOTO IS AN AUTOMOTIVE FILM & COATING COMPANY PRODUCING HIGH-PERFORMANCE PRODUCTS. OUR FILMS&COATING ALLOW PROFESSIONAL DETAILERS TO FULLY UTIIZE THEIR SKILLS, WHILE LETTING CAR OWNERS APPRECIATE THE HIGH QUALITY OUR MISSION IS NOT ONLY TO SATISFY THE DEMANDS OF OUR CUSTOMERS BUT ALSO TO CONTINUE DEVELOPING NEW PRODUCTS 2'
            reviewsCubit.reviews[index].comment ?? '',

            trimLines: 3,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'readMore'.tr(),
            trimExpandedText: 'readLess'.tr(),
            moreStyle: TextStyle(fontSize: 15, color: AppColors.primiry),
            style: TextStyle(fontSize: 15),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: reviewsCubit.reviews[index].videos?.isNotEmpty ?? false,
              child: MyButton(
                weight: FontWeight.normal,
                height: 40,
                radius: 30,
                color: AppColors.primiry,
                width: 90,
                text: 'Car video'.tr(),
                fontSize: 14,
                function: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return VideoReview(
                            reviewsCubit: reviewsCubit, index: index);
                      });
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Visibility(
              visible: reviewsCubit.reviews[index].images?.isNotEmpty ?? false,
              child: MyButton(
                weight: FontWeight.normal,
                height: 40,
                radius: 30,
                color: AppColors.primiry,
                width: 90,
                text: 'Car photo'.tr(),
                fontSize: 14,
                function: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          backgroundColor: AppColors.lightGreybackgound,
                          child: Container(
                            height: 320,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  height: 250,
                                  autoPlay: true,
                                  viewportFraction: 1,
                                  enableInfiniteScroll: false,
                                  aspectRatio: 1.5,
                                  enlargeCenterPage: true,
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.scale,
                                ),
                                items: List.generate(
                                  reviewsCubit.reviews[index].images?.length ??
                                      0,
                                  (indexImage) => NetworkImagesWidgets(
                                    reviewsCubit.reviews[index]
                                            .images?[indexImage] ??
                                        '',
                                    height: 312,
                                    width: 820,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 3,
        ),
        if (index + 1 != reviewsCubit.reviews.length)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 450.w,
                child: Divider(color: AppColors.primiry),
              ),
            ],
          )
      ],
    );
  }
}

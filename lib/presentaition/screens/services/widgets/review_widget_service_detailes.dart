import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../core/themes/colors.dart';
import '../../../components/custom_text.dart';
import '../cubit/services_cubit.dart';

class ReviewWidgetServiceDetailes extends StatelessWidget {
  const ReviewWidgetServiceDetailes({
    Key? key,
    required this.servDetailsCubit,
    required this.i,
  }) : super(key: key);

  final ServicesCubit servDetailsCubit;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Row(
            // mainAxisAlignment:
            //     MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.white,
                radius: 15,
                backgroundImage:
                    servDetailsCubit.reviewServices[i].user?.avatar == null
                        ? Image.asset(
                            'assets/images/user1.png',
                          ).image
                        : Image.network(
                            servDetailsCubit.reviewServices[i].user?.avatar ??
                                '',
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset('assets/images/user1.png'),
                          ).image,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        servDetailsCubit.reviewServices[i].user?.name == null
                            ? servDetailsCubit.reviewServices[i].user_name ?? ''
                            : (servDetailsCubit.reviewServices[i].user?.name) ??
                                ''),
                    RatingBar.builder(
                      ignoreGestures: true,
                      initialRating:
                          (servDetailsCubit.reviewServices[i].score ?? 1)
                              .toDouble(),
                      itemSize: 18,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          subtitle:
              CustomText(servDetailsCubit.reviewServices[i].comment ?? ''),
        ),
        if (i + 1 != servDetailsCubit.reviewServices.length)
          SizedBox(
            width: double.infinity,
            child: Divider(color: AppColors.grey),
          )
      ],
    );
  }
}

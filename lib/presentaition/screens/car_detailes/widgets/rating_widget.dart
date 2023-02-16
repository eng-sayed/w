import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/utiles.dart';
import '../../../../domain/models/reservations_model.dart';
import '../../../components/cam_or_gallery.dart';
import '../../../components/custom_text.dart';
import '../../../components/default_button.dart';
import '../../../components/default_text_field.dart';
import '../../../components/direction.dart';
import '../cubit/car_details_cubit.dart';

class RatingReservationWidget extends StatelessWidget {
  RatingReservationWidget(
      {super.key, required this.cubit, required this.subServices});
  CarDetailsCubit cubit;

  SubServices subServices;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarDetailsCubit, CarDetailsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final myCubit = CarDetailsCubit.get(context);

        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Container(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Direction(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            'Rating'.tr(),
                            textStyleEnum: TextStyleEnum.title,
                            color: AppColors.primiry,
                          ),
                          ListTile(
                            title: Row(
                              children: [
                                Utiles.UserImage == ''
                                    ? CircleAvatar(
                                        radius: 22,
                                        backgroundImage: Image.asset(
                                          'assets/images/user1.png',
                                        ).image,
                                      )
                                    : CircleAvatar(
                                        radius: 15,
                                        backgroundImage: Image.network(
                                          Utiles.UserImage,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                                      'assets/images/user.png'),
                                        ).image,
                                      ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      RatingBar.builder(
                                        // ignoreGestures: true,
                                        initialRating: 1,
                                        itemSize: 18,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 20,
                                        ),
                                        onRatingUpdate: (rating) {
                                          myCubit.addReviewModel?.score =
                                              rating;

                                          print(myCubit.addReviewModel?.score);
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextFeildWithCustomValidation(
                                  height: 60,
                                  keyboardType: TextInputType.multiline,
                                  maxlines: 3,
                                  validate: (p) {},
                                  onChange: (p) {
                                    myCubit.addReviewModel?.comment = p;
                                  },
                                  hintText: 'levecomment'.tr(),
                                ),
                                Row(
                                  children: [
                                    MyButton(
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
                                              return GalleryORCamera(
                                                fun0: () async {
                                                  await myCubit.addVideo(
                                                    context,
                                                    true,
                                                  );
                                                },
                                                fun1: () async {
                                                  await myCubit.addVideo(
                                                    context,
                                                    false,
                                                  );
                                                },
                                              );
                                            });
                                        //  cubit.addVideo(context, true);
                                      },
                                    ),
                                    MyButton(
                                      weight: FontWeight.normal,
                                      height: 40,
                                      radius: 30,
                                      color: AppColors.primiry,
                                      width: 90,
                                      text: 'Car photo'.tr(),
                                      fontSize: 14,
                                      function: () {
                                        myCubit.addImage(context);
                                      },
                                    ),
                                  ],
                                ),
                                MyButton(
                                    width: 70,
                                    height: 40,
                                    color: AppColors.primiry,
                                    fontSize: 14,
                                    function: () async {
                                      print(subServices.parent_id);
                                      await cubit.reviewService(
                                          subServices.id, context);
                                    },
                                    text: 'Rate'.tr())
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}

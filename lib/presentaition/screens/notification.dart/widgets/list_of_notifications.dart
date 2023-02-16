import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supa_kota/core/utiles/responsive.dart';
import 'package:supa_kota/core/utiles/utiles.dart';
import 'package:supa_kota/presentaition/components/default_button.dart';

import '../../../../core/themes/colors.dart';
import '../../../components/custom_text.dart';
import '../cubit/notifications_cubit.dart';

class ListOfMyNotification extends StatelessWidget {
  const ListOfMyNotification({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final NotificationsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: cubit.myNotifications.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              cubit.myNotifications[index].title ?? '',
                              textStyleEnum: TextStyleEnum.title,
                              color: AppColors.primiry,
                            ),
                            CustomText(
                              cubit.myNotifications[index].createdAt!
                                  .parseDateTime(),
                              textStyleEnum: TextStyleEnum.normal,
                              // maxLines: 3
                              color: AppColors.primiry,
                              fontsize: 14,
                            ),
                            CustomText(
                              cubit.myNotifications[index].msg ?? '',
                              textStyleEnum: TextStyleEnum.title,
                              // maxLines: 3,
                              fontsize: 20,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300.w,
                      child: Divider(color: AppColors.primiry),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class ListOfAllNotification extends StatelessWidget {
  const ListOfAllNotification({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final NotificationsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
          itemCount: cubit.allNotifications.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Expanded(
                    //   child: Image.asset(
                    //     'assets/images/icon.png',
                    //     width: 50,
                    //     // height: 40,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    Expanded(
                      // flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  cubit.allNotifications[index].title ?? '',
                                  textStyleEnum: TextStyleEnum.title,
                                  color: AppColors.primiry,
                                ),
                                if ((cubit.allNotifications[index].label ??
                                        '') ==
                                    'mine')
                                  MyButton(
                                    function: () {
                                      null;
                                    },
                                    text: 'For you'.tr(),
                                    fontSize: 12,
                                    color: AppColors.green,
                                    height: 30,
                                    width: 60,
                                  )
                              ],
                            ),
                            CustomText(
                              cubit.allNotifications[index].createdAt!
                                  .parseDateTime(),
                              textStyleEnum: TextStyleEnum.normal,
                              color: AppColors.primiry,
                              fontsize: 14,
                              // maxLines: 3,
                            ),
                            CustomText(
                              cubit.allNotifications[index].msg ?? '',
                              textStyleEnum: TextStyleEnum.title,
                              fontsize: 20,
                              //  maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300.w,
                      child: Divider(color: AppColors.primiry),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}

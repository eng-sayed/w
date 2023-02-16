import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/navigate.dart';
import '../../../../core/utiles/utiles.dart';
import '../../../components/custom_text.dart';
import '../../notification.dart/notification.dart';
import '../../profile/profie_screen.dart';

class AppBarNews extends StatelessWidget {
  const AppBarNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primiry,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                navigate(context: context, route: ProfieScreen());
              },
              child: CircleAvatar(
                radius: 22,
                backgroundImage: Image.network(
                  Utiles.UserImage,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset('assets/images/user1.png'),
                ).image,
              ),
            ),
            CustomText(
              'Daily News'.tr(),
              textStyleEnum: TextStyleEnum.title,
              color: AppColors.white,
              fontsize: 26,
            ),
            GestureDetector(
              onTap: () {
                navigate(context: context, route: NotificationScreen());
              },
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade300.withOpacity(.4),
                radius: 22,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Image.asset('assets/images/notification1.png')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

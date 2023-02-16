import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utiles/navigate.dart';
import '../../../../core/utiles/utiles.dart';
import '../../../components/default_app_bar.dart';
import '../../notification.dart/notification.dart';
import '../../profile/profie_screen.dart';

class AppBarReview extends StatefulWidget {
  const AppBarReview({super.key});

  @override
  State<AppBarReview> createState() => _AppBarReviewState();
}

class _AppBarReviewState extends State<AppBarReview> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultAppBar(
          icon: 'review',
          title: 'Reviews'.tr(),
          desc: 'You can see all reviews here'.tr(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 53, left: 30, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  navigate(context: context, route: ProfieScreen());
                },
                child: Utiles.UserImage == ''
                    ? CircleAvatar(
                        radius: 22,
                        backgroundImage: Image.asset(
                          'assets/images/user1.png',
                        ).image,
                      )
                    : CircleAvatar(
                        radius: 22,
                        backgroundImage: Image.network(
                          Utiles.UserImage,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset('assets/images/user1.png'),
                        ).image,
                      ),
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
        )
      ],
    );
  }
}

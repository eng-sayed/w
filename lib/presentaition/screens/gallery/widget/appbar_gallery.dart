import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utiles/navigate.dart';
import '../../../../core/utiles/utiles.dart';
import '../../../components/default_app_bar.dart';
import '../../notification.dart/notification.dart';
import '../../profile/profie_screen.dart';

class AppBarGallery extends StatelessWidget {
  const AppBarGallery({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultAppBar(
          icon: 'gallery',
          title: 'Protected Cars'.tr(),
          desc: 'Best car you can see here'.tr(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
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

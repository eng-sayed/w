import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/navigate.dart';
import '../../../../core/utiles/utiles.dart';
import '../../../components/default_app_bar.dart';
import '../../../components/default_button.dart';
import '../../add_car/add_car.dart';
import '../../notification.dart/notification.dart';
import '../../profile/profie_screen.dart';

class AppBarMyCars extends StatelessWidget {
  const AppBarMyCars({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultAppBar(
          title: 'My Cars'.tr(),
          desc: 'see All information about your car'.tr(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 55, left: 30, right: 30),
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 200.0, right: 30),
              child: MyButton(
                weight: FontWeight.w600,
                height: 45,
                radius: 30,
                color: AppColors.secondary,
                textColor: AppColors.primiry,
                width: 120,
                text: 'Add Car'.tr(),
                fontSize: 18,
                function: () {
                  navigateHero(
                      context: context,
                      route: AddCar(
                        fromRegister: false,
                      ));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

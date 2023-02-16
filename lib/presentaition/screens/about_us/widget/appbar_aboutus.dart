import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/navigate.dart';
import '../../../components/default_app_bar.dart';
import '../../notification.dart/notification.dart';

class appBarAboutUs extends StatelessWidget {
  const appBarAboutUs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultAppBar(
          icon: 'about',
          title: 'About us'.tr(),
          desc: 'see All details about supa koto'.tr(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
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
              GestureDetector(
                onTap: () async {
                  navigate(context: context, route: NotificationScreen());
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade300.withOpacity(.4),
                  radius: 25,
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

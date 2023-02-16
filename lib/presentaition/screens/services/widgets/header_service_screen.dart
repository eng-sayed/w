import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/navigate.dart';
import '../../../../core/utiles/utiles.dart';
import '../../../components/default_button.dart';
import '../../../components/toggle_clickable_container.dart';
import '../../../layout/cubit/layout_cubit.dart';
import '../../about_us/aboutus_screen.dart';
import '../../become_partener/becomePartener.dart';
import '../../splash_screen/splash_screen.dart';

class HeaderServiceScreen extends StatelessWidget {
  const HeaderServiceScreen({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final LayoutCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClickableContainer(
                text: 'ع',
                color: context.locale == Locale('ar', 'EG')
                    ? AppColors.primiry
                    : AppColors.white,
                function: () async {
                  await context.setLocale(Locale('ar', 'EG'));
                  navigateReplacement(context: context, route: SplashScreen());
                },
                textColor: context.locale == Locale('ar', 'EG')
                    ? AppColors.white
                    : AppColors.primiry,
                borderColor: AppColors.primiry,
                isSelect: context.locale == Locale('ar', 'EG') ? true : false,
                isRight: false,
              ),
              ClickableContainer(
                text: 'En',
                color: context.locale == Locale('en', 'US')
                    ? AppColors.primiry
                    : AppColors.white,
                function: () async {
                  await context.setLocale(Locale('en', 'US'));
                  navigateReplacement(context: context, route: SplashScreen());
                  //  Restart.restartApp();
                  // foryou = !foryou;
                  // all = !all;
                },
                textColor: context.locale == Locale('en', 'US')
                    ? AppColors.white
                    : AppColors.primiry,
                borderColor: AppColors.primiry,
                isSelect: context.locale == Locale('en', 'US') ? true : false,
                isRight: true,
              ),
            ],
          ),
          Row(
            children: [
              if (cubit.aboutUsModel?.facebookLink != null)
                GestureDetector(
                  onTap: () async {
                    final url = cubit.aboutUsModel?.facebookLink;
                    if (!await launchUrl(Uri.parse(url ?? ''))) {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Icon(
                    FontAwesomeIcons.facebook,
                    size: 25.0,
                    color: Colors.blue,
                  ),
                ),
              SizedBox(
                width: 5,
              ),
              if (cubit.aboutUsModel?.instagramLink != null)
                GestureDetector(
                  onTap: () async {
                    final url = cubit.aboutUsModel?.instagramLink;
                    if (!await launchUrl(Uri.parse(url ?? ''))) {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Icon(
                    FontAwesomeIcons.instagram,
                    size: 25.0,
                    color: AppColors.primiry,
                  ),
                ),
              MyButton(
                function: () {
                  navigate(context: context, route: AboutUsScreen());
                  // navigate(
                  //     context: context,
                  //     route: ServicesDetails(id: 12));
                },
                text: 'About us'.tr(),
                radius: 30,
                color: AppColors.primiry,
                width: 115,
                fontSize: 13,
              ),
              if (!Utiles.isPartner)
                MyButton(
                  padding: 0,
                  function: () async {
                    navigateHero(context: context, route: BecomePartener());
                  },
                  text: 'Become Partner'.tr(),
                  radius: 30,
                  color: AppColors.primiry,
                  width: 115,
                  fontSize: 13,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

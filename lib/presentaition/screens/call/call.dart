import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utiles/navigate.dart';
import '../../components/custom_text.dart';
import '../../layout/layout.dart';
import '../on_boarding/on_boarding.dart';

class CallScreen extends StatelessWidget {
  CallScreen({
    super.key,
    this.index,
  });
  int? index;
  // String? message;
  @override
  Widget build(BuildContext context) {
    _navigateToHome(context, index);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Image.asset("assets/images/call.gif",
                height: double.infinity,
                width: double.infinity,
                gaplessPlayback: true,
                fit: BoxFit.cover),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 170),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          'your Request Completed'.tr(),
                          color: AppColors.greyText,
                          fontsize: 30,
                          align: TextAlign.center,
                          textStyleEnum: TextStyleEnum.title,
                        ),
                      ],
                    ),
                  ),
                  CustomText(
                    'Our Customer Service Will Contact you Soon'.tr(),
                    color: AppColors.greyText,
                    fontsize: 25,
                    align: TextAlign.center,
                    textStyleEnum: TextStyleEnum.title,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _navigateToHome(context, int? index) async {
    await Future.delayed(
      const Duration(milliseconds: 5000),
      () {},
    );
    navigateReplacement(context: context, route: HomeLayout(index: index ?? 2));
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/utiles.dart';
import '../../../components/custom_nav_bar.dart';
import '../../../components/custom_text.dart';
import '../../../components/direction.dart';
import 'communication_wiget.dart';

class BottomNavBarServiceDetailes extends StatelessWidget {
  const BottomNavBarServiceDetailes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Direction(
              child: GestureDetector(
                onTap: () {
                  Utiles.makeCall(Utiles.Allphones.first);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      'Contactteam'.tr(),
                      color: AppColors.primiry,
                      fontsize: 19,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    CommuicationWidget(
                      size: 16,
                      num: Utiles.Allphones.first,
                      color: AppColors.black,
                      colorIcon: AppColors.green,
                    )
                  ],
                ),
              ),
            ),
          ),
          CustomNavBar(),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/themes/colors.dart';
import 'custom_text.dart';

class GalleryORCamera extends StatelessWidget {
  const GalleryORCamera({
    Key? key,
    required this.fun0,
    required this.fun1,
  }) : super(key: key);

  final Function fun0, fun1;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: AppColors.lightGreybackgound,
      child: Container(
        height: 150,
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () async {
                await fun0();
                Navigator.pop(context);

                // profileCubit.addImage(true, context);
              },
              child: Container(
                width: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/gallerybtn.png',
                      width: 50,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      'Gallery'.tr(),
                      color: AppColors.primiry,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
                height: 50,
                child: VerticalDivider(
                  thickness: .5,
                  color: AppColors.primiry,
                )),
            InkWell(
              onTap: () async {
                await fun1();
                Navigator.pop(context);

                // profileCubit.addImage(false, context);
              },
              child: Container(
                width: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/camerabtn.png',
                      width: 50,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      'Camera'.tr(),
                      color: AppColors.primiry,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

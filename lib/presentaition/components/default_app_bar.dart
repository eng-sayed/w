import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:supa_kota/core/themes/colors.dart';
import 'package:supa_kota/core/utiles/responsive.dart';
import 'package:supa_kota/presentaition/components/custom_text.dart';
import 'package:supa_kota/presentaition/components/direction.dart';
import 'dart:ui' as ui;

import 'background_image.dart';

class DefaultAppBar extends StatelessWidget {
  DefaultAppBar({super.key, this.icon, this.title, this.desc});
  String? icon, title, desc;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/appbar.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/white-logo.png',
                      width: 90,
                      height: 70,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      'assets/images/japan.png',
                      width: 50,
                      height: 25,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (title != null)
                              Direction(
                                child: Container(
                                  width: 350,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 30.w,
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: CustomText(
                                        '${title}',
                                        fontsize: 20,
                                        color: AppColors.white,
                                        maxLines: 2,
                                        textDirection:
                                            // TextDirection.ltr,
                                            context.locale == Locale('en', 'US')
                                                ? TextDirection.ltr
                                                : TextDirection.rtl,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (desc != null)
                              Padding(
                                padding: EdgeInsets.only(
                                    right: 30.w, left: 30.w, bottom: 22.h),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    width: 250,
                                    child: CustomText(
                                      '${desc}',
                                      fontsize: 18,
                                      color: AppColors.secondary,
                                      textDirection: TextDirection.ltr,
                                      // maxLines: 3,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (icon != null)
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 30, top: 0),
                              child: Image.asset(
                                'assets/images/${icon}.png',
                                width: 160,
                                height: 135,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

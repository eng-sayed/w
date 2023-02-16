import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utiles/validation.dart';
import '../../components/background_image.dart';
import '../../components/custom_text.dart';
import '../../components/default_app_bar.dart';

import '../auth/cubit/auth_cubit.dart';

class OTPPin extends StatelessWidget {
  OTPPin({super.key});
  String code = '';
  @override
  Widget build(BuildContext context) {
    final cubit = AuthCubit.get(context);
    return Background(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                DefaultAppBar(
                  icon: 'message',
                  title: 'Verify Your Email'.tr(),
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
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    'Please Enter The 4 Digit Code Sent To '.tr(),
                    fontsize: 20,
                    align: TextAlign.center,
                    textStyleEnum: TextStyleEnum.title,
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  OtpTextField(
                    numberOfFields: 6,
                    borderColor: AppColors.primiry,
                    enabledBorderColor: AppColors.greyText,
                    disabledBorderColor: AppColors.primiry,
                    focusedBorderColor: AppColors.primiry,
                    showFieldAsBox: true,
                    onCodeChanged: (String codee) {
                      code = codee;
                    },
                    onSubmit: (String verificationCode) async {
                      await cubit.checkCode(verificationCode, context);
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

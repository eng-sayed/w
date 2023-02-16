import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/validation.dart';
import '../../../components/custom_text.dart';
import '../../../components/default_button.dart';
import '../../../components/default_text_field.dart';
import '../cubit/auth_cubit.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final formKey = GlobalKey<FormState>();
  String? emailToForgetPass;

  @override
  Widget build(BuildContext context) {
    final cubit = AuthCubit.get(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              'our Protect CarsPlease Enter Your Email Address To Receive a Verification Code'
                  .tr(),
              fontsize: 20,
              align: TextAlign.center,
              textStyleEnum: TextStyleEnum.title,
            ),
            SizedBox(
              height: 20,
            ),
            TextFeildWithCustomValidation(
              onChange: (p) {
                emailToForgetPass = p;
              },
              hintText: 'Email'.tr(),
              keyboardType: TextInputType.emailAddress,
              validate: Validation().emailValidation,
              prefix: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Image.asset(
                  'assets/images/gmail.png',
                  width: 15,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MyButton(
              radius: 30,
              color: AppColors.primiry,
              width: 147,
              text: 'Send'.tr(),
              fontSize: 18,
              function: () {
                if (formKey.currentState!.validate()) {
                  print(emailToForgetPass);
                  cubit.forgetPass(emailToForgetPass, context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

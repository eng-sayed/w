import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supa_kota/presentaition/components/custom_text.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/validation.dart';
import '../../../components/default_button.dart';
import '../../../components/default_text_field.dart';
import '../../../components/direction.dart';
import '../cubit/profile_cubit.dart';

class ChangePassWidget extends StatelessWidget {
  ChangePassWidget({
    required this.profileCubit,
  });

  final _formKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return Direction(
      child: Form(
        key: _formKey,
        child: Container(
          height: 320,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      'changepass'.tr(),
                      textStyleEnum: TextStyleEnum.title,
                      fontsize: 20,
                      color: AppColors.primiry,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomText(
                              'NewPassword'.tr(),
                            ),
                          ),
                        ],
                      ),
                      TextFeildWithCustomValidation(
                        controller: password,
                        // suffixIcon: Icon(
                        //   Icons.edit_outlined,
                        //   color: AppColors.primiry,
                        // ),
                        hintText: 'enterNewPass'.tr(),
                        keyboardType: TextInputType.visiblePassword,
                        validate: Validation().passwordValidation,
                        prefix: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Image.asset(
                            'assets/images/lock.png',
                            width: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomText('confirmnewpass'.tr()),
                          ),
                        ],
                      ),
                      TextFeildWithCustomValidation(
                        controller: confirmpassword,
                        // suffixIcon: Icon(
                        //   Icons.edit_outlined,
                        //   color: AppColors.primiry,
                        // ),
                        hintText: 'enterconfirmnewpass'.tr(),
                        keyboardType: TextInputType.visiblePassword,
                        validate: (s) {
                          return Validation()
                              .confirmPasswordValidation(s, password.text);
                        },
                        prefix: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Image.asset(
                            'assets/images/lock.png',
                            width: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: MyButton(
                    radius: 30,
                    color: AppColors.primiry,
                    width: 145,
                    text: 'changepass'.tr(),
                    fontSize: 15,
                    function: () async {
                      if (_formKey.currentState!.validate()) {
                        // print(userModel.);
                        // if (_formKey.currentState!.validate()) {
                        await profileCubit.changePadd(password, context);
                      }
                      //}
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

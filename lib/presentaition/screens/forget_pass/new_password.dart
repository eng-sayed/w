import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supa_kota/presentaition/screens/auth/auth_screen.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utiles/navigate.dart';
import '../../../core/utiles/validation.dart';
import '../../components/background_image.dart';
import '../../components/custom_text.dart';
import '../../components/default_app_bar.dart';
import '../../components/default_button.dart';
import '../../components/default_text_field.dart';
import '../auth/cubit/auth_cubit.dart';

class NewPassword extends StatefulWidget {
  NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = AuthCubit.get(context);

    return Background(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    DefaultAppBar(
                      icon: 'forget password',
                      title: 'Create New Password'.tr(),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 50, left: 30, right: 30),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        'Your New Password Must Be Different From Previously Used Password'
                            .tr(),
                        fontsize: 20,
                        align: TextAlign.center,
                        textStyleEnum: TextStyleEnum.title,
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      TextFeildWithCustomValidation(
                        controller: password,
                        hintText: 'Password'.tr(),
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
                      TextFeildWithCustomValidation(
                        controller: confirmpassword,
                        hintText: 'Confirm Password'.tr(),
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
                      SizedBox(
                        height: 70,
                      ),
                      defaultButton(
                        radius: 30,
                        color: AppColors.primiry,
                        width: 147,
                        text: 'Confirm'.tr(),
                        fontSize: 18,
                        function: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.newPassword(password.text, context);
                          }
                        },
                      ),
                    ],
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

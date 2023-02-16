import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/validation.dart';
import '../../../components/custom_text.dart';
import '../../../components/default_button.dart';
import '../../../components/default_text_field.dart';
import '../cubit/profile_cubit.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final formDeleteAccount = GlobalKey<FormState>();
  String pass = '';
  @override
  Widget build(BuildContext context) {
    final profileCubit = ProfileCubit.get(context);

    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
        ),
        height: 250,
        child: Form(
          key: formDeleteAccount,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomText('Are you sure you want to delete Your Account?'.tr()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextFeildWithCustomValidation(
                  hintText: 'Please, Enter Your Password'.tr(),
                  keyboardType: TextInputType.visiblePassword,
                  validate: Validation().passwordValidation,
                  onChange: (p) {
                    pass = p;
                  },
                ),
              ),
              CustomText('Enter your password to submit'.tr()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  defaultButton(
                      textColor: AppColors.white,
                      radius: 30,
                      color: AppColors.primiry,
                      width: 147,
                      fontSize: 18,
                      function: () async {
                        if (formDeleteAccount.currentState!.validate()) {
                          print(pass);
                          await profileCubit.deleteAccount(pass, context);
                        }
                      },
                      text: 'Yes'.tr()),
                  defaultButton(
                      textColor: AppColors.primiry,
                      radius: 30,
                      color: AppColors.white,
                      width: 147,
                      fontSize: 18,
                      function: () {
                        Navigator.pop(context);
                      },
                      text: 'No'.tr()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

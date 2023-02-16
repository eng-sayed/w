import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supa_kota/core/themes/colors.dart';
import 'package:supa_kota/core/utiles/validation.dart';
import 'package:supa_kota/presentaition/components/default_text_field.dart';

import '../../../components/default_button.dart';
import '../cubit/auth_cubit.dart';
import 'forget_pass.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with AutomaticKeepAliveClientMixin {
  String? phone, password, emailToForgetPass;

  final _formKeyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = AuthCubit.get(context);

    return Form(
      key: _formKeyLogin,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children: [
              TextFeildWithCustomValidation(
                onChange: (ph) {
                  phone = ph;
                },
                hintText: 'Phonenumber'.tr(),
                keyboardType: TextInputType.phone,
                validate: Validation().phoneValidation,
                prefix: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.phone,
                    size: 20,
                    color: AppColors.primiry,
                  ),
                ),
              ),
              TextFeildWithCustomValidation(
                onChange: (ph) {
                  password = ph;
                },
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyTextButton(
                    size: 18,
                    text: 'forgetpass'.tr(),
                    function: () {
                      // ignore: avoid_single_cascade_in_expression_statements
                      AwesomeDialog(
                          context: context,
                          animType: AnimType.bottomSlide,
                          dialogType: DialogType.noHeader,
                          body: ForgetPass())
                        ..show();

                      //  navigate(context: context, route: ForgetPassword());
                    },
                    color: AppColors.grey,
                  )
                ],
              ),
              SizedBox(
                height: 100,
              ),
              MyButton(
                radius: 30,
                color: AppColors.primiry,
                width: 147,
                text: 'login'.tr(),
                fontSize: 18,
                function: () async {
                  if (_formKeyLogin.currentState!.validate()) {
                    await cubit.login(phone, password, context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

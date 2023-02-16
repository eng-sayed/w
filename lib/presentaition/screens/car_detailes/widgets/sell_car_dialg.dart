import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/validation.dart';
import '../../../components/default_button.dart';
import '../../../components/default_text_field.dart';
import '../cubit/car_details_cubit.dart';

class SellCarDialog extends StatelessWidget {
  SellCarDialog({super.key, required this.cubit});
  final _formKey = GlobalKey<FormState>();
  final CarDetailsCubit cubit;
  String email = '', phone = '';
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: AppColors.lightGreybackgound,
      child: Form(
        key: _formKey,
        child: Container(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFeildWithCustomValidation(
                  //  controller: password,
                  suffixIcon: Icon(
                    Icons.edit_outlined,
                    color: AppColors.primiry,
                  ),
                  hintText: 'phonebuyer'.tr(),
                  keyboardType: TextInputType.phone,
                  validate: Validation().defaultValidation,
                  onChange: (p) {
                    phone = p;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFeildWithCustomValidation(
                  //  controller: password,
                  suffixIcon: Icon(
                    Icons.edit_outlined,
                    color: AppColors.primiry,
                  ),
                  onChange: (p) {
                    email = p;
                  },
                  hintText: 'email buyer'.tr(),
                  keyboardType: TextInputType.emailAddress,
                  validate: Validation().defaultValidation,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: MyButton(
                  radius: 30,
                  color: AppColors.primiry,
                  width: 147,
                  text: 'Sell car'.tr(),
                  fontSize: 18,
                  function: () async {
                    if (_formKey.currentState!.validate()) {
                      await cubit.sellCar(
                          cubit.myCar?.id, context, email, phone);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

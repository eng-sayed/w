import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_kota/core/utiles/validation.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/utiles.dart';
import '../../../components/custom_text.dart';
import '../../../components/default_button.dart';
import '../../../components/default_text_field.dart';
import '../../../components/network_image.dart';
import '../cubit/cart_cubit.dart';
import 'check_branch.dart';
import 'check_car.dart';
import 'date_time.dart';

class DialogItem extends StatelessWidget {
  DialogItem({
    Key? key,
    required this.date,
  }) : super(key: key);

  final DateTime date;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = CartCubit.get(context);
    return BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Container(
                height: 600,
                child: Directionality(
                  textDirection: context.locale == Locale('en', 'US')
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          'Select Contery'.tr(),
                          color: AppColors.primiry,
                          textStyleEnum: TextStyleEnum.title,
                          fontsize: 20,
                        ),
                        Container(
                          height: 45,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.countries.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  cubit.selectCountry(context, index);
                                },
                                child: Card(
                                  color: cubit.selectedCountry == index
                                      ? AppColors.primiry.withOpacity(.2)
                                      : AppColors.lightGrey.withOpacity(1),
                                  clipBehavior: Clip.hardEdge,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        NetworkImagesWidgets(
                                          cubit.countries[index].flag ?? '',
                                          height: 20,
                                          width: 35,
                                          fit: BoxFit.fill,
                                          //TODO errorBuilder:
                                          //     (context, error, stackTrace) {
                                          //   return Image.asset(
                                          //     'assets/images/logo2.png',
                                          //     height: 20,
                                          //     width: 35,
                                          //     fit: BoxFit.fill,
                                          //   );
                                          // },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: CustomText(
                                            cubit.countries[index].name ?? '',
                                            color:
                                                cubit.selectedCountry == index
                                                    ? AppColors.white
                                                    : AppColors.black
                                                        .withOpacity(.3),
                                            fontsize: 20,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        CustomText(
                          'My Cars'.tr(),
                          color: AppColors.primiry,
                          textStyleEnum: TextStyleEnum.title,
                          fontsize: 20,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cubit.myCars.length,
                          itemBuilder: (context, index) {
                            return CheckBoxCar(
                              car: cubit.myCars[index],
                            );
                          },
                        ),
                        CustomText(
                          'Branches'.tr(),
                          color: AppColors.primiry,
                          textStyleEnum: TextStyleEnum.title,
                          fontsize: 20,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 100),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.branches.length,
                            itemBuilder: (context, index) {
                              return CheckBoxBranch(
                                branch: cubit.branches[index],
                              );
                            },
                          ),
                        ),
                        CustomText(
                          'What Date you want your services?'.tr(),
                          color: AppColors.primiry,
                          textStyleEnum: TextStyleEnum.title,
                          fontsize: 20,
                        ),
                        SizedBox(
                          height: 85,
                          child: Center(
                            child: ListView.builder(
                              itemCount: 7,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                print(index);
                                return DateItem(
                                  dateTime: date.add(Duration(days: index)),
                                );
                              },
                            ),
                          ),
                        ),
                        CustomText(
                          'Notes'.tr(),
                          textStyleEnum: TextStyleEnum.title,
                          fontsize: 20,
                        ),
                        TextFeildWithCustomValidation(
                          keyboardType: TextInputType.multiline,
                          validate: Validation().defaultValidation,
                          onChange: (p) {
                            cubit.mainReservation.notes = p;
                          },
                        ),
                        Center(
                          child: defaultButton(
                              function: () async {
                                if (_formKey.currentState!.validate()) {
                                  await cubit.createMainReservations(context);
                                }
                              },
                              text: 'Send Request'.tr(),
                              color: AppColors.primiry,
                              textColor: AppColors.white,
                              height: 50,
                              width: 150,
                              weight: FontWeight.normal,
                              radius: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

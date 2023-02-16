import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supa_kota/core/utiles/validation.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/navigate.dart';
import '../../../../core/utiles/utiles.dart';
import '../../../components/custom_text.dart';
import '../../../components/default_button.dart';
import '../../../components/default_text_field.dart';
import '../../../components/direction.dart';
import '../../privacy_policy/privacy_policy.dart';
import '../cubit/services_cubit.dart';
import 'check_branch.dart';
import 'check_car.dart';
import 'date_time_widget.dart';
import 'delivery_check.dart';

class DialogItem extends StatelessWidget {
  DialogItem({Key? key, required this.date, this.carId}) : super(key: key);

  final DateTime date;
  int? carId;
  final _formKey = GlobalKey<FormState>();
  bool delivery = false;
  String promocode = '';
  @override
  Widget build(BuildContext context) {
    final cubit = ServicesCubit.get(context);
    return BlocConsumer<ServicesCubit, ServicesState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Directionality(
                textDirection: context.locale == Locale('en', 'US')
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                child: SingleChildScrollView(
                  child: Container(
                    // height: 700,
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
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.network(
                                              cubit.countries[index].flag ?? '',
                                              width: 25,
                                              height: 25,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  'assets/images/logo2.png',
                                                  height: 20,
                                                  width: 35,
                                                  fit: BoxFit.fill,
                                                );
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: CustomText(
                                              cubit.countries[index].name ?? '',
                                              color:
                                                  cubit.selectedCountry == index
                                                      ? AppColors.white
                                                      : AppColors.black,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                // visible: cubit.branchesOfCountry.isNotEmpty,
                                child: CustomText(
                                  'SelectBranche'.tr(),
                                  color: AppColors.primiry,
                                  textStyleEnum: TextStyleEnum.title,
                                  fontsize: 20,
                                ),
                              ),
                              Row(
                                children: [
                                  Visibility(
                                      visible: cubit
                                              .countries[
                                                  cubit.selectedCountry ?? 0]
                                              .hasDelivery ==
                                          1,
                                      child: DeliveryCheck()),
                                  Expanded(
                                    child: Visibility(
                                      visible:
                                          cubit.branchesOfCountry.isNotEmpty,
                                      child: Column(
                                        children: [
                                          ConstrainedBox(
                                            constraints:
                                                BoxConstraints(maxHeight: 50),
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: cubit
                                                  .branchesOfCountry.length,
                                              itemBuilder: (context, index) {
                                                return CheckBoxBranch(
                                                  branch: cubit
                                                      .branchesOfCountry[index],
                                                  index: index,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          if ((cubit.branchesOfCountry.isNotEmpty) &&
                              !(cubit.delivery))
                            ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 70),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CustomText('Start Time'.tr() + ' '),
                                      CustomText(cubit
                                              .branchesOfCountry[
                                                  cubit.indexBranch]
                                              .open_time ??
                                          ''),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CustomText('close Time'.tr() + ' '),
                                      CustomText(cubit
                                              .branchesOfCountry[
                                                  cubit.indexBranch]
                                              .close_time ??
                                          ''),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          Visibility(
                              visible: cubit.delivery,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Visibility(
                                        visible: cubit.showGpsBTN,
                                        child: MyButton(
                                          width: 300,
                                          function: () {
                                            cubit.getCurrentPosition(context);
                                          },
                                          text: 'ClickHereToGetLoction'.tr(),
                                          color: AppColors.primiry,
                                        ),
                                      ),
                                    ],
                                  ),
                                  CustomText(
                                    'Address'.tr(),
                                    color: AppColors.primiry,
                                    textStyleEnum: TextStyleEnum.title,
                                    fontsize: 20,
                                  ),
                                  TextFeildWithCustomValidation(
                                    height: 50,
                                    keyboardType: TextInputType.streetAddress,
                                    validate: Validation().defaultValidation,
                                    onChange: (p) {
                                      cubit.mainReservation.address = p;
                                    },
                                  ),
                                  CustomText(
                                    'addtionalphone'.tr(),
                                    color: AppColors.primiry,
                                    textStyleEnum: TextStyleEnum.title,
                                    fontsize: 20,
                                  ),
                                  TextFeildWithCustomValidation(
                                    height: 50,
                                    keyboardType: TextInputType.phone,
                                    validate: (s) {},
                                    onChange: (p) {
                                      cubit.mainReservation.phone = p;
                                    },
                                  ),
                                ],
                              )),
                          CustomText(
                            'SelectDate'.tr(),
                            color: AppColors.primiry,
                            textStyleEnum: TextStyleEnum.title,
                            fontsize: 20,
                          ),
                          SizedBox(
                            height: 85,
                            child: ListView.builder(
                              itemCount: 7,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                print(index);
                                return DateItem(
                                  dateTime: date.add(Duration(days: index)),
                                  context: context,
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Visibility(
                            visible: !(cubit.promoCode != null &&
                                cubit.discount > 0),
                            replacement: Card(
                              color: Colors.grey[200],
                              clipBehavior: Clip.hardEdge,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomText(cubit.promoCode?.name ?? ''),
                                    CustomText(
                                        "- ${cubit.promoCode?.value ?? 0}${cubit.promoCode?.type == 'constant' ? '' : "%"} "),
                                    GestureDetector(
                                      onTap: () {
                                        cubit.deletePromoCode();
                                      },
                                      child: Icon(
                                        Icons.cancel_sharp,
                                        color: AppColors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextFeildWithCustomValidation(
                                    controller: cubit.promoCodeController,
                                    height: 50,
                                    keyboardType: TextInputType.multiline,
                                    validate: Validation().defaultValidation,
                                    onChange: (p) {
                                      promocode = p;
                                    },
                                    hintText: 'promocode'.tr(),
                                  ),
                                ),
                                Expanded(
                                  child: MyButton(
                                      function: () async {
                                        if (_formKey.currentState!.validate()) {
                                          await cubit.ckeckPromoCode(
                                              promocode, context);
                                        }
                                      },
                                      text: 'Check'.tr(),
                                      color: AppColors.primiry,
                                      textColor: AppColors.white,
                                      height: 50,
                                      width: 120,
                                      weight: FontWeight.normal,
                                      radius: 20),
                                ),
                              ],
                            ),
                          ),
                          CustomText(
                            'Notes'.tr(),
                            textStyleEnum: TextStyleEnum.title,
                            fontsize: 20,
                          ),
                          TextFeildWithCustomValidation(
                            height: 100,
                            maxlines: 10,
                            keyboardType: TextInputType.multiline,
                            validate: (s) {},
                            onChange: (p) {
                              cubit.mainReservation.notes = p;
                            },
                          ),
                          Container(
                            child: Direction(
                              child: Row(
                                children: [
                                  Container(
                                    width: 250,
                                    child: CheckboxListTile(
                                      title: Text("agreePrivacy?".tr()),
                                      value: cubit.privacy,
                                      onChanged: (newValue) {
                                        cubit.ChangePrivacy();
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      navigate(
                                          context: context,
                                          route: PrivacyPolicy());
                                    },
                                    child: CustomText(
                                      'readit'.tr(),
                                      color: AppColors.primiry,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: defaultButton(
                                function: () async {
                                  if (cubit.privacy == false) {
                                    Fluttertoast.showToast(
                                        msg: 'mustagreePrivacy'.tr(),
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: AppColors.primiry,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else {
                                    await cubit.createMainReservations(
                                        carId, context);
                                  }
                                },
                                text: 'Send Request'.tr(),
                                color: AppColors.primiry,
                                textColor: AppColors.white,
                                height: 50,
                                width: 200,
                                weight: FontWeight.normal,
                                radius: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_kota/presentaition/components/background_image.dart';
import 'package:supa_kota/presentaition/components/loadinganderror.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utiles/validation.dart';
import '../../../domain/models/countries_model.dart';
import '../../components/custom_text.dart';
import '../../components/default_app_bar.dart';
import '../../components/default_button.dart';
import '../../components/default_text_field.dart';
import 'cubit/become_partner_cubit.dart';

class BecomePartener extends StatefulWidget {
  BecomePartener({super.key});

  @override
  State<BecomePartener> createState() => _BecomePartenerState();
}

class _BecomePartenerState extends State<BecomePartener> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final cubit = BecomePartnerCubit.get(context);

      await cubit.getCountriesAndCites(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                DefaultAppBar(
                  // icon: 'home',
                  title: 'Become Partner'.tr(),
                  //desc: 'Find perfect services for car'.tr(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 53, left: 30, right: 30),
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
            BlocConsumer<BecomePartnerCubit, BecomePartnerState>(
              listener: (context, state) {},
              builder: (context, state) {
                final cubit = BecomePartnerCubit.get(context);

                return Expanded(
                  child: LoadingAndError(
                    isError: state is ErrorCountries,
                    isLoading: state is LoadingCountries,
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 50, horizontal: 20),
                          child: Column(
                            children: [
                              TextFeildWithCustomValidation(
                                height: 40,
                                hintText: 'companyName'.tr(),
                                keyboardType: TextInputType.name,
                                validate: Validation().defaultValidation,
                                onChange: (p) {
                                  cubit.partnerModel?.company_name = p;
                                  //   authModel.name = p;
                                },
                              ),
                              TextFeildWithCustomValidation(
                                height: 40,
                                hintText: 'Phonenumber'.tr(),
                                keyboardType: TextInputType.phone,
                                validate: Validation().phoneValidation,
                                onChange: (p) {
                                  cubit.partnerModel?.phone = p;

                                  // authModel.phone = p;
                                },
                              ),
                              TextFeildWithCustomValidation(
                                height: 40,
                                hintText: 'enteremail'.tr(),
                                keyboardType: TextInputType.emailAddress,
                                validate: Validation().emailValidation,
                                onChange: (p) {
                                  cubit.partnerModel?.email = p;
                                },
                              ),
                              Row(
                                children: [
                                  if (cubit.countries.isNotEmpty)
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              'Country'.tr(),
                                              color: AppColors.primiry,
                                            ),
                                            Container(
                                              height: 39,
                                              child: DropdownButtonFormField<
                                                  CountriesModel>(
                                                icon: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10,
                                                      top: 7,
                                                      left: 10),
                                                  child: Icon(
                                                    Icons.arrow_drop_down,
                                                    // color: AppColors.primiry,
                                                  ),
                                                ),
                                                style: TextStyle(
                                                    color: AppColors.primiry,
                                                    fontSize: 18),
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Select Contery'.tr(),
                                                  //prefix: prefixIcon,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColors.greyText),
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                ),
                                                dropdownColor: Colors.white,
                                                value: cubit.countries.first,
                                                onChanged: (newValue) async {
                                                  await cubit.getCites(context,
                                                      newValue?.id.toString(),
                                                      loading: true);
                                                  cubit.partnerModel?.country =
                                                      newValue?.name ?? '';
                                                },
                                                items: cubit.countries
                                                    .map((CountriesModel item) {
                                                  return DropdownMenuItem(
                                                    value: item,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 7,
                                                              // bottom: 5,
                                                              right: 10,
                                                              left: 10),
                                                      child: CustomText(
                                                          item.name!),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  if (cubit.cites.isNotEmpty)
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              'City'.tr(),
                                              color: AppColors.primiry,
                                            ),
                                            Container(
                                              height: 40,
                                              child: DropdownButtonFormField<
                                                  CountriesModel>(
                                                icon: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10,
                                                      top: 7,
                                                      left: 10),
                                                  child: Icon(
                                                    Icons.arrow_drop_down,
                                                    // color: AppColors.primiry,
                                                  ),
                                                ),
                                                style: TextStyle(
                                                    color: AppColors.primiry,
                                                    fontSize: 18),
                                                decoration: InputDecoration(
                                                  hintText: 'Select City'.tr(),
                                                  //prefix: prefixIcon,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    borderSide: BorderSide(
                                                      color: AppColors.greyText,
                                                    ),
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                ),
                                                dropdownColor: Colors.white,
                                                value: cubit.cites.first,
                                                onChanged: (newValue) async {
                                                  // authModel.city_id =
                                                  //     newValue?.id;
                                                  cubit.partnerModel?.city =
                                                      newValue?.name ?? '';
                                                },
                                                items: cubit.cites
                                                    .map((CountriesModel item) {
                                                  return DropdownMenuItem(
                                                    value: item,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 7,
                                                              // bottom: 5,
                                                              right: 10,
                                                              left: 10),
                                                      child: CustomText(
                                                          item.name!),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              TextFeildWithCustomValidation(
                                height: 100,
                                maxlines: 10,
                                hintText: 'enterMessage'.tr(),
                                keyboardType: TextInputType.emailAddress,
                                validate: Validation().defaultValidation,
                                onChange: (p) {
                                  cubit.partnerModel?.message = p;
                                  // authModel.email = p;
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              MyButton(
                                radius: 30,
                                color: AppColors.primiry,
                                width: 147,
                                text: 'Become Partner'.tr(),
                                fontSize: 18,
                                function: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await cubit.bePartner(context);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

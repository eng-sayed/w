import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_kota/domain/models/auth_model.dart';
import 'package:supa_kota/presentaition/components/background_image.dart';
import 'package:supa_kota/presentaition/components/custom_text.dart';
import 'package:supa_kota/presentaition/components/direction.dart';
import 'package:supa_kota/presentaition/screens/profile/cubit/profile_cubit.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utiles/navigate.dart';
import '../../../core/utiles/validation.dart';
import '../../components/default_app_bar.dart';
import '../../components/default_button.dart';
import '../../components/default_text_field.dart';
import '../notification.dart/notification.dart';
import '../../components/cam_or_gallery.dart';
import 'widgets/appbar_profile.dart';
import 'widgets/change_pass_dialog.dart';
import 'widgets/delete_account_dialog.dart';

class ProfieScreen extends StatefulWidget {
  ProfieScreen({super.key});

  @override
  State<ProfieScreen> createState() => _ProfieScreenState();
}

class _ProfieScreenState extends State<ProfieScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController(),
      name = TextEditingController(),
      phone = TextEditingController(),
      birth = TextEditingController(),
      password = TextEditingController(),
      confirmpassword = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final profileCubit = ProfileCubit.get(context);
      await profileCubit.getProfile(context);
      name.text = profileCubit.user?.name ?? '';
      phone.text = profileCubit.user?.phone ?? '';
      email.text = profileCubit.user?.email ?? '';
      birth.text = profileCubit.user?.birth_date ?? '';
    });
    super.initState();
  }

  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1920, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birth.text = selectedDate.toString().replaceAll(' 00:00:00.000', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileCubit = ProfileCubit.get(context);

    return BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Background(
            child: Scaffold(
                body: Column(
              children: [
                AppBarProfile(profileCubit: profileCubit),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 30),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        CustomText('Full Name'.tr()),
                        TextFeildWithCustomValidation(
                          suffixIcon: Icon(
                            Icons.edit_outlined,
                            color: AppColors.primiry,
                          ),
                          controller: name,
                          hintText: 'entername'.tr(),
                          keyboardType: TextInputType.name,
                          validate: Validation().defaultValidation,
                          prefix: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(
                              Icons.person,
                              color: AppColors.primiry,
                            ),
                          ),
                          onChange: (p) {
                            profileCubit.emit(ProfileSuccessState());
                          },
                        ),
                        CustomText('Email'.tr()),
                        TextFeildWithCustomValidation(
                          controller: email,
                          suffixIcon: Icon(
                            Icons.edit_outlined,
                            color: AppColors.primiry,
                          ),
                          hintText: 'enterEmail'.tr(),
                          keyboardType: TextInputType.emailAddress,
                          validate: Validation().emailValidation,
                          prefix: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Image.asset(
                              'assets/images/gmail.png',
                              width: 20,
                            ),
                          ),
                          onChange: (p) {
                            profileCubit.emit(ProfileSuccessState());
                          },
                        ),
                        CustomText('Phonenumber'.tr()),
                        TextFeildWithCustomValidation(
                          controller: phone,
                          suffixIcon: Icon(
                            Icons.edit_outlined,
                            color: AppColors.primiry,
                          ),
                          hintText: 'enterPhone'.tr(),
                          keyboardType: TextInputType.phone,
                          validate: Validation().phoneValidation,
                          prefix: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(
                              Icons.phone,
                              color: AppColors.primiry,
                            ),
                          ),
                          onChange: (p) {
                            profileCubit.emit(ProfileSuccessState());
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    await selectDate(context);
                                    profileCubit.emit(ProfileSuccessState());
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: AppColors.grey.withOpacity(.2),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: AppColors.primiry)),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Image.asset(
                                            'assets/images/calendar1.png',
                                            width: 20,
                                          ),
                                        ),
                                        CustomText(birth.text.isEmpty
                                            ? 'changebirth'.tr()
                                            : birth.text)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColors.primiry),
                                      color: AppColors.grey.withOpacity(.3),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.0))),
                                              backgroundColor:
                                                  AppColors.lightGreybackgound,
                                              child: ChangePassWidget(
                                                  profileCubit: profileCubit),
                                            );
                                          });
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Image.asset(
                                            'assets/images/lock.png',
                                            width: 20,
                                          ),
                                        ),
                                        CustomText('changepass'.tr())
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyButton(
                              radius: 30,
                              color: AppColors.primiry,
                              width: 130,
                              text: (name.text != profileCubit.user?.name ||
                                      phone.text != profileCubit.user?.phone ||
                                      email.text != profileCubit.user?.email ||
                                      (birth.text != "" &&
                                          birth.text !=
                                              profileCubit.user?.birth_date))
                                  ? 'Update'.tr()
                                  : 'Logout'.tr(),
                              fontSize: 18,
                              function: () async {
                                if (name.text != profileCubit.user?.name ||
                                    phone.text != profileCubit.user?.phone ||
                                    email.text != profileCubit.user?.email ||
                                    (birth.text != "" &&
                                        birth.text !=
                                            profileCubit.user?.birth_date)) {
                                  final userModel = User(
                                      email: email.text,
                                      name: name.text,
                                      phone: phone.text,
                                      birth_date: birth.text);

                                  await profileCubit.updateProfile(userModel);
                                } else {
                                  await profileCubit.LogOut(context);
                                }
                                //}
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext contexts) {
                                        return DeleteAccount();
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.delete_sweep_sharp,
                                          size: 20,
                                          color: AppColors.black,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        CustomText(
                                          'Delete Account'.tr(),
                                          fontsize: 15,
                                          color: AppColors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
          );
        });
  }
}

import 'package:csc_picker/csc_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supa_kota/core/utiles/alerts.dart';
import 'package:supa_kota/core/utiles/navigate.dart';
import 'package:supa_kota/domain/models/auth_model.dart';
import 'package:supa_kota/presentaition/components/custom_text.dart';
import 'package:supa_kota/presentaition/components/default_text_field.dart';
import 'package:supa_kota/presentaition/screens/privacy_policy/privacy_policy.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/validation.dart';
import '../../../../domain/models/countries_model.dart';
import '../../../components/cam_or_gallery.dart';
import '../../../components/default_button.dart';
import '../../../components/direction.dart';
import '../../splash_screen/cubit/splach_cubit.dart';
import '../cubit/auth_cubit.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

final authModel = User();
final _formKey = GlobalKey<FormState>();

class _SignUpState extends State<SignUp> with AutomaticKeepAliveClientMixin {
  DateTime selectedDate = DateTime.now();
  TextEditingController date = TextEditingController();
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1920, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        date.text = selectedDate.toString().replaceAll(' 00:00:00.000', '');
        authModel.birth_date = date.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = AuthCubit.get(context);
        final splashCubit = SplachCubit.get(context);

        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return GalleryORCamera(fun0: () async {
                              await cubit.addImage(true);
                            }, fun1: () async {
                              await cubit.addImage(false);
                            });
                          });
                    },
                    child: cubit.pickedImage == null
                        ? Column(
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Container(
                                    // width: 60,
                                    // height: 60,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        // borderRadius: BorderRadius.circular(45),
                                        border: Border.all(
                                            color: AppColors.primiry)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Icon(
                                        Icons.image,
                                        size: 70,
                                        color:
                                            AppColors.primiry.withOpacity(.2),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 0, bottom: 5),
                                    child: CircleAvatar(
                                      backgroundColor: AppColors.primiry,
                                      child: Icon(
                                        Icons.file_upload_outlined,
                                        size: 25,
                                        color: AppColors.white,
                                      ),
                                      radius: 15,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              CustomText(
                                'uploadProfPic'.tr(),
                                fontsize: 15,
                                color: AppColors.grey,
                              )
                            ],
                          )
                        : CircleAvatar(
                            radius: 70,
                            backgroundImage: Image.file(
                              cubit.pickedImage!,
                              width: 150,
                              fit: BoxFit.contain,
                            ).image,
                          ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFeildWithCustomValidation(
                    hintText: 'entername'.tr(),
                    keyboardType: TextInputType.name,
                    validate: Validation().defaultValidation,
                    prefix: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Image.asset(
                        'assets/images/user.png',
                        width: 20,
                      ),
                    ),
                    onChange: (p) {
                      authModel.name = p;
                    },
                  ),
                  TextFeildWithCustomValidation(
                    hintText: 'Phonenumber'.tr(),
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
                      authModel.phone = p;
                    },
                  ),
                  TextFeildWithCustomValidation(
                    hintText: 'enteremail'.tr(),
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
                      authModel.email = p;
                    },
                  ),
                  TextFeildWithCustomValidation(
                    readOnly: true,
                    function: () {
                      selectDate(context);
                    },
                    controller: date,
                    // enabled: false,
                    // function: () {
                    // },
                    hintText: 'selectbirth'.tr(),
                    keyboardType: TextInputType.emailAddress,
                    // validate: Validation().defaultValidation,
                    validate: (s) {},
                    prefix: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Image.asset(
                        'assets/images/calendar1.png',
                        width: 20,
                      ),
                    ),
                    onChange: (p) {
                      authModel.birth_date = p;
                      print(p);
                    },
                  ),
                  Row(
                    children: [
                      if (splashCubit.countries.isNotEmpty)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  'Country'.tr(),
                                  color: AppColors.primiry,
                                ),
                                Container(
                                  height: 40,
                                  child:
                                      DropdownButtonFormField<CountriesModel>(
                                    icon: Padding(
                                      padding: EdgeInsets.only(
                                          right: 10, top: 10, left: 10),
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        // color: AppColors.primiry,
                                      ),
                                    ),
                                    style: TextStyle(
                                        color: AppColors.primiry, fontSize: 18),
                                    decoration: InputDecoration(
                                      hintText: 'Select Contery'.tr(),
                                      //prefix: prefixIcon,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        borderSide: BorderSide(
                                            color: AppColors.greyText),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    dropdownColor: Colors.white,
                                    value: splashCubit.countries.first,
                                    onChanged: (newValue) async {
                                      await splashCubit.getCites(
                                          context, newValue?.id.toString(),
                                          loading: true);
                                    },
                                    items: splashCubit.countries
                                        .map((CountriesModel item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10,
                                              // bottom: 5,
                                              right: 10,
                                              left: 10),
                                          child: CustomText(item.name!),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (splashCubit.cites.isNotEmpty)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  'City'.tr(),
                                  color: AppColors.primiry,
                                ),
                                Container(
                                  height: 40,
                                  child:
                                      DropdownButtonFormField<CountriesModel>(
                                    icon: Padding(
                                      padding: EdgeInsets.only(
                                          right: 10, top: 10, left: 10),
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        // color: AppColors.primiry,
                                      ),
                                    ),
                                    style: TextStyle(
                                        color: AppColors.primiry, fontSize: 18),
                                    decoration: InputDecoration(
                                      hintText: 'Select City'.tr(),
                                      //prefix: prefixIcon,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        borderSide: BorderSide(
                                          color: AppColors.greyText,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    dropdownColor: Colors.white,
                                    value: splashCubit.cites.first,
                                    onChanged: (newValue) async {
                                      authModel.city_id = newValue?.id;
                                    },
                                    items: splashCubit.cites
                                        .map((CountriesModel item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10,
                                              // bottom: 5,
                                              right: 10,
                                              left: 10),
                                          child: CustomText(item.name!),
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
                    onChange: (p) {
                      authModel.password = p;
                    },
                  ),
                  TextFeildWithCustomValidation(
                    hintText: 'confirmpass'.tr(),
                    keyboardType: TextInputType.visiblePassword,
                    validate: (s) {
                      return Validation().confirmPasswordValidation(
                          s, authModel.password ?? '');
                    },
                    prefix: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Image.asset(
                        'assets/images/lock.png',
                        width: 20,
                      ),
                    ),
                  ),
                  Container(
                    child: Direction(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              width: 400,
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
                          ),
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () {
                                navigate(
                                    context: context, route: PrivacyPolicy());
                              },
                              child: CustomText(
                                'readit'.tr(),
                                color: AppColors.primiry,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MyButton(
                    radius: 30,
                    color: AppColors.primiry,
                    width: 147,
                    text: 'signupbtn'.tr(),
                    fontSize: 18,
                    function: () async {
                      if (_formKey.currentState!.validate()) {
                        if (cubit.pickedImage == null) {
                          Fluttertoast.showToast(
                              msg: 'selectImage'.tr(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              backgroundColor: AppColors.primiry,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else if (cubit.privacy == false) {
                          Fluttertoast.showToast(
                              msg: 'mustagreePrivacy'.tr(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              backgroundColor: AppColors.primiry,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                        print(authModel.toJson());
                        if (cubit.pickedImage != null && cubit.privacy)
                          await cubit.register(
                              authModel, context, cubit.pickedImage);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

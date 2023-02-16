import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:supa_kota/core/themes/colors.dart';
import 'package:supa_kota/core/utiles/navigate.dart';
import 'package:supa_kota/domain/repositry/auth_repo/auth_repo.dart';
import 'package:supa_kota/presentaition/components/custom_text.dart';
import 'package:supa_kota/presentaition/layout/layout.dart';
import 'package:supa_kota/presentaition/screens/add_car/add_car.dart';
import 'package:supa_kota/presentaition/screens/auth/widget/signup.dart';
import 'package:supa_kota/presentaition/screens/start/start.dart';

import '../../../../core/utiles/utiles.dart';
import '../../../../data/local/sharedpref.dart';
import '../../../../domain/models/auth_model.dart';
import '../../add_car/add_car_register.dart';
import '../../forget_pass/new_password.dart';
import '../../forget_pass/otp_pin.dart';
import '../auth_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  late TabController tabController;
  int tabindex = 0;
  bool privacy = false;
  ChangePrivacy() {
    privacy = !privacy;
    emit(ChangePrivacyState());
  }

  changeHeaderAuthScreen() {
    if (tabindex == 0) {
      emit(AuthChangeScreenState());
    } else if (tabindex == 1) {
      emit(AuthChangeScreenState());
    }
  }

  String token = '';
  forgetPass(email, context) async {
    final response = await AuthRepo.forgetPasswordRequest(email, context);
    if (response != null) {
      final snackBar = SnackBar(
        backgroundColor: AppColors.primiry,
        content: CustomText(
          'Check Your Email'.tr(),
          color: AppColors.white,
        ),
      );

      await ScaffoldMessenger.of(context).showSnackBar(snackBar);

      navigate(context: context, route: OTPPin());
    } else {}
  }

  checkCode(code, context) async {
    final response = await AuthRepo.checkCodeRequest(code, context);
    if (response != null) {
      token = response;

      navigate(context: context, route: NewPassword());
    } else {}
  }

  newPassword(pass, context) async {
    final response = await AuthRepo.changePassRequest(pass, token, context);
    if (response != null) {
      navigateReplacement(context: context, route: AuthScreen());
    } else {}
  }

  login(phone, password, BuildContext context) async {
    final response = await AuthRepo.login(phone: phone, password: password);
    if (response != null) {
      await saveToken();

      navigateReplacement(context: context, route: HomeLayout());

      emit(LoginSuccessState());
    } else {
      emit(LoginErrorState());
    }
  }

  register(User user, BuildContext context, image) async {
    // print(user)
    final response = await AuthRepo.register(user, image);
    if (response != null) {
      await saveToken();

      navigateReplacement(
          context: context,
          route: AddCar(
            fromRegister: true,
          ));
      pickedImage = null;

      pickedImage = null;
      // }
      emit(RegisterSuccessState());
    } else {
      emit(RegisterErrorState());
    }
  }

  File? pickedImage;
  CroppedFile? croppedFile;
  addImage(bool isGallery) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = isGallery
        ? await _picker.pickImage(source: ImageSource.gallery, imageQuality: 20)
        : await _picker.pickImage(source: ImageSource.camera, imageQuality: 20);

    if (image != null)
      croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: AppColors.primiry,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
    if (croppedFile != null) pickedImage = File(croppedFile?.path ?? '');
    emit(AddedImageState());
  }

  resetData() {
    pickedImage = null;
  }

  saveToken() {
    CacheHelper.saveData(key: "token", value: Utiles.token);
    CacheHelper.saveData(key: "userid", value: Utiles.UserId);
    CacheHelper.saveData(key: "email", value: Utiles.email);
    CacheHelper.saveData(key: "phone", value: Utiles.phone);
    CacheHelper.saveData(key: "name", value: Utiles.name);
  }
}

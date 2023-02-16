import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:supa_kota/core/themes/colors.dart';
import 'package:supa_kota/core/utiles/navigate.dart';
import 'package:supa_kota/core/utiles/utiles.dart';
import 'package:supa_kota/cubit/app_cubit.dart';
import 'package:supa_kota/data/hive/local_hive.dart';
import 'package:supa_kota/data/local/sharedpref.dart';
import 'package:supa_kota/domain/models/auth_model.dart';
import 'package:supa_kota/domain/repositry/profile_repo/profile_repo.dart';
import 'package:supa_kota/presentaition/screens/auth/auth_screen.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  User? user;
  Future getProfile(context, {bool? load}) async {
    final response = await ProfileRepo.fetchProfile(context, load: load);
    if (response != null) {
      print("Profile");
      user = response;

      print(user);
      emit(ProfileSuccessState());
    } else {
      emit(ProfileErrorState());
    }
  }

  updateProfile(User user) async {
    final response = await ProfileRepo.UpdateDataProfile(user);
    if (response != null) {
      print("Profile");
      user = response;
      print(user);
      emit(ProfileSuccessState());
    } else {
      emit(ProfileErrorState());
    }
  }

  changePadd(pass, context) async {
    final response = await ProfileRepo.UpdatePassword(pass, context);
    if (response != null) {
      print("Profile");
      user = response;
      print(user);
      emit(ProfileSuccessState());
    } else {
      emit(ProfileErrorState());
    }
  }

  updateImageUser(File image, context) async {
    final response = await ProfileRepo.UpdateImageProfile(image);
    if (response != null) {
      print("Profile");
      user = response;
      Utiles.UserImage = user?.avatar ?? '';
      print(user);
      // Navigator.pop(context);
      emit(ProfileSuccessState());
    } else {
      emit(ProfileErrorState());
    }
  }

  CroppedFile? croppedFile;

  addImage(bool isGalery, context) async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = isGalery
        ? await _picker.pickImage(source: ImageSource.gallery, imageQuality: 20)
        : await _picker.pickImage(source: ImageSource.camera, imageQuality: 20);
    print(image);
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
          WebUiSettings(
            context: context,
          ),
        ],
      );
    if (croppedFile != null)
      await updateImageUser(File(croppedFile?.path ?? ''), context);
    final app = AppCubit.get(context);

    app.emit(ChangeStateApp());

    emit(AddedImageState());
  }

  deleteAccount(password, context) async {
    final response = await ProfileRepo.deleteAccount(password);
    if (response != null) {
      print("Profile");
      await CacheHelper.cleanData();
      await CacheHelper.saveData(key: "onboard", value: true);

      // user = response;
      print(user);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => AuthScreen()),
          (route) => false);
      emit(DeleteSuccessState());
    } else {
      emit(DeleteErrorState());
    }
  }

  LogOut(context) async {
    await CacheHelper.cleanData();
    await CacheHelper.saveData(key: "onboard", value: true);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => AuthScreen()),
        (route) => false);
  }
}

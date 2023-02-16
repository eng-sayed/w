import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supa_kota/core/utiles/navigate.dart';
import 'package:supa_kota/presentaition/components/direction.dart';
import 'package:supa_kota/presentaition/layout/layout.dart';
import 'package:supa_kota/presentaition/screens/call/call.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/utiles.dart';
import '../../../../core/utiles/validation.dart';
import '../../../../domain/models/complains_model.dart';
import '../../../components/cam_or_gallery.dart';
import '../../../components/custom_text.dart';
import '../../../components/default_button.dart';
import '../../../components/default_text_field.dart';
import '../../services/widgets/communication_wiget.dart';
import '../cubit/my_cars_cubit.dart';
import 'package:image_picker/image_picker.dart';

class CarComplaint extends StatelessWidget {
  CarComplaint({
    Key? key,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyCarsCubit, MyCarsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = MyCarsCubit.get(context);

        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: AppColors.lightGreybackgound,
            child: Direction(
              child: Container(
                  height: 500,
                  alignment: Alignment.center,
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  'SelectCarParts'.tr(),
                                  color: AppColors.black,
                                  fontsize: 18,
                                ),
                                Container(
                                  // height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: AppColors.greyText)),
                                  child: Center(
                                      child: Wrap(
                                    children: List.generate(
                                        cubit.carParts.length,
                                        (index) => Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  cubit.changePartId(index);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: AppColors.black),
                                                    color: cubit.carParts[index]
                                                                .id ==
                                                            cubit.complainsModel
                                                                ?.part_id
                                                        ? AppColors.primiry
                                                            .withOpacity(.8)
                                                        : AppColors.white,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: CustomText(
                                                      cubit.carParts[index]
                                                              .name ??
                                                          '',
                                                      color: cubit
                                                                  .carParts[
                                                                      index]
                                                                  .id ==
                                                              cubit
                                                                  .complainsModel
                                                                  ?.part_id
                                                          ? AppColors.white
                                                          : AppColors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )),
                                  )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  'SelectService'.tr(),
                                  color: AppColors.black,
                                  fontsize: 18,
                                ),
                                Container(
                                  // height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: AppColors.greyText)),
                                  child: Center(
                                      child: Wrap(
                                    children: List.generate(
                                        cubit.services.length,
                                        (index) => Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  cubit.changeServiceId(index);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: AppColors.black),
                                                    color: cubit.services[index]
                                                                .id ==
                                                            cubit.complainsModel
                                                                ?.service_id
                                                        ? AppColors.primiry
                                                            .withOpacity(.8)
                                                        : AppColors.white,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: CustomText(
                                                      cubit.services[index]
                                                              .name ??
                                                          '',
                                                      color: cubit
                                                                  .services[
                                                                      index]
                                                                  .id ==
                                                              cubit
                                                                  .complainsModel
                                                                  ?.service_id
                                                          ? AppColors.white
                                                          : AppColors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )),
                                  )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  'Complaint Photo'.tr(),
                                  color: AppColors.black,
                                  fontsize: 18,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await cubit.addImage(true, context);
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (BuildContext context) {
                                    //       return GalleryORCamera(fun0: () async {
                                    //         await cubit.addImage(true, context);
                                    //       }, fun1: () async {
                                    //         await cubit.addImage(false, context);
                                    //       });
                                    //     });
                                  },
                                  child: Container(
                                      // height: 150,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: AppColors.greyText)),
                                      child: cubit.pickedImage.isEmpty
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 40),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.cloud_upload_rounded,
                                                    size: 50,
                                                    color: AppColors.primiry,
                                                  ),
                                                  CustomText(
                                                    'Click her to upload'.tr(),
                                                    color: AppColors.primiry,
                                                  )
                                                ],
                                              ),
                                            )
                                          : Center(
                                              child: Wrap(
                                                children: List.generate(
                                                  cubit.pickedImage.length,
                                                  (index) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Image.file(
                                                      cubit.pickedImage[index],
                                                      fit: BoxFit.fill,
                                                      width: 70,
                                                      height: 70,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  'Complaint Reason'.tr(),
                                  color: AppColors.black,
                                  fontsize: 18,
                                ),
                                TextFeildWithCustomValidation(
                                  onChange: (p0) {
                                    cubit.complainsModel?.notes = p0;
                                  },
                                  hintText: 'Complaint disc'.tr(),
                                  height: 100,
                                  hintColor: AppColors.primiry,
                                  // height: 4,
                                  keyboardType: TextInputType.multiline,
                                  validate: Validation().defaultValidation,
                                  maxlines: 4,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyButton(
                                  function: () async {
                                    // ComplainsModel complainsModel =
                                    //     ComplainsModel(
                                    //         images: cubit.pickedImage,
                                    //         notes: notes);

                                    if (formKey.currentState!.validate() &&
                                        cubit.complainsModel?.car_id != null &&
                                        cubit.complainsModel?.part_id != null &&
                                        cubit.complainsModel?.images != null &&
                                        cubit.complainsModel?.service_id !=
                                            null) {
                                      await cubit.makeComplain(context);
                                    } else {
                                      print(cubit.complainsModel?.car_id);
                                      print(cubit.complainsModel?.part_id);
                                      print(cubit.complainsModel?.images);
                                      print(cubit.complainsModel?.service_id);
                                      Fluttertoast.showToast(
                                          msg: 'MustChooseData'.tr(),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 3,
                                          backgroundColor: AppColors.primiry,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }

                                    // navigate(
                                    //     context: context,
                                    //     route: CallScreen(
                                    //       index: 3,
                                    //     ));
                                  },
                                  weight: FontWeight.normal,
                                  height: 40,
                                  text: 'Provide Complaint'.tr(),
                                  radius: 30,
                                  color: AppColors.primiry,
                                  width: 160,
                                  fontSize: 15,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Utiles.makeCall(Utiles.complaint_phone);
                                  },
                                  child: CommuicationWidget(
                                    size: 16,
                                    num: Utiles.complaint_phone,
                                    color: AppColors.black,
                                    colorIcon: AppColors.green,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ));
      },
    );
  }
}

class ImagePickerDialog extends StatefulWidget {
  @override
  _ImagePickerDialogState createState() => _ImagePickerDialogState();
}

class _ImagePickerDialogState extends State<ImagePickerDialog> {
  final TextEditingController _notesController = TextEditingController();
  List<PickedFile> _imageFiles = [];
  Map<PickedFile, String> _notes = {};

  void _openImagePicker() async {
    _imageFiles = (await ImagePicker().getMultiImage())!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Images and Notes'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            for (var imageFile in _imageFiles)
              Row(
                children: <Widget>[
                  Image.file(
                    File(imageFile.path),
                    width: 100,
                    height: 100,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Add a note'),
                      controller: _notesController,
                      onChanged: (text) {
                        _notes[imageFile] = text;
                      },
                    ),
                  ),
                ],
              ),
            TextButton(
              child: Text('Select Images'),
              onPressed: _openImagePicker,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () {
            // Save the images and notes here
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

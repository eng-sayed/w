import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supa_kota/presentaition/components/background_image.dart';
import 'package:supa_kota/presentaition/components/direction.dart';
import 'package:supa_kota/presentaition/screens/add_car/cubit/add_car_cubit.dart';
import 'package:widget_mask/widget_mask.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utiles/validation.dart';
import '../../../domain/models/add_car_model.dart';
import '../../../domain/models/brands_model.dart';
import '../../../domain/models/models_car_model.dart';
import '../../../domain/models/my_cars_model.dart';
import '../../components/cam_or_gallery.dart';
import '../../components/custom_text.dart';
import '../../components/default_app_bar.dart';
import '../../components/default_button.dart';
import '../../components/default_text_field.dart';
import '../../components/loadinganderror.dart';

class EditMyCar extends StatefulWidget {
  EditMyCar({super.key, required this.id});
  String id;
  @override
  State<EditMyCar> createState() => _EditMyCarState();
}

class _EditMyCarState extends State<EditMyCar> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final editCarsCubit = AddCarCubit.get(context);

      await editCarsCubit.getData(widget.id, context);
    });

    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  File? pickedImage;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCarCubit, AddCarState>(
        listener: (context, state) {},
        builder: (context, state) {
          final editCarsCubit = AddCarCubit.get(context);

          return Background(
              child: Scaffold(
            body: Form(
              key: _formKey,
              child: LoadingAndError(
                function: () async {
                  await editCarsCubit.getData(widget.id, context);
                },
                isLoading: state is EditMyCarLoadingState,
                isError: state is EditMyCarErrorState,
                child: Column(
                  children: [
                    Stack(
                      fit: StackFit.passthrough,
                      children: [
                        DefaultAppBar(
                          // icon: 'addcar',
                          title: 'Edit Car'.tr(),
                          desc: 'see All information about your car'.tr(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 53, left: 30, right: 30),
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
                              CircleAvatar(
                                backgroundColor:
                                    Colors.grey.shade300.withOpacity(.4),
                                radius: 22,
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Image.asset(
                                        'assets/images/notification1.png')),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 140.0, left: 30, right: 25),
                                child: InkWell(
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return GalleryORCamera(
                                              fun0: () async {
                                            await editCarsCubit.updateImageCar(
                                                widget.id,
                                                pickedImage,
                                                editCarsCubit.addCarModel,
                                                context,
                                                true);
                                          }, fun1: () async {
                                            await editCarsCubit.updateImageCar(
                                                widget.id,
                                                pickedImage,
                                                editCarsCubit.addCarModel,
                                                context,
                                                false);
                                          });
                                        });
                                  },
                                  child: WidgetMask(
                                    blendMode: BlendMode.srcATop,
                                    childSaveLayer: true,
                                    mask: Image.network(
                                      editCarsCubit.myCar?.image ?? '',
                                      width: 170,
                                      height: 180,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          ((context, error, stackTrace) =>
                                              Image.asset(
                                                'assets/images/addcar.png',
                                                width: 160,
                                                height: 145,
                                                fit: BoxFit.contain,
                                              )),
                                    ),
                                    child: Image.asset(
                                      'assets/images/shi.png',
                                      width: 170,
                                      height: 180,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 30),
                        child: LoadingAndError(
                          isLoading: state is MyCarLoadingState,
                          isError: state is MyCarErrorState,
                          child: Direction(
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                if (editCarsCubit.brands.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          'Car Brand'.tr(),
                                          color: AppColors.primiry,
                                        ),
                                        Container(
                                          height: 40,
                                          child: DropdownButtonFormField<
                                              BrandsModel>(
                                            icon: Padding(
                                              padding: EdgeInsets.only(
                                                  right: 10, top: 7, left: 10),
                                              child: Icon(
                                                Icons.arrow_drop_down,
                                                // color: AppColors.primiry,
                                              ),
                                            ),
                                            style: TextStyle(
                                                color: AppColors.primiry,
                                                fontSize: 18),
                                            decoration: InputDecoration(
                                              hintText: 'Select Car Brand'.tr(),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                borderSide: BorderSide(
                                                    color: AppColors.greyText,
                                                    width: 1),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                            ),
                                            dropdownColor: Colors.white,
                                            value: editCarsCubit.brands.isEmpty
                                                ? null
                                                : editCarsCubit.brands
                                                    .firstWhere(
                                                    (element) =>
                                                        element.id ==
                                                        editCarsCubit
                                                            .myCar?.brand?.id,
                                                  ),
                                            onChanged: (newValue) async {
                                              editCarsCubit
                                                      .addCarModel.brand_id =
                                                  newValue?.id.toString();
                                              await editCarsCubit
                                                  .getModelsOfBrand(context,
                                                      newValue?.id.toString());
                                            },
                                            items: editCarsCubit.brands
                                                .map((BrandsModel item) {
                                              return DropdownMenuItem(
                                                value: item,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 7,
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (editCarsCubit.model.isNotEmpty)
                                        CustomText(
                                          'Car Model'.tr(),
                                          color: AppColors.primiry,
                                        ),
                                      if (editCarsCubit.model.isNotEmpty)
                                        Container(
                                          height: 45,
                                          child: DropdownButtonFormField<
                                              ModelsCarsModel>(
                                            icon: Padding(
                                              padding: EdgeInsets.only(
                                                  right: 10, top: 7, left: 10),
                                              child: Icon(
                                                Icons.arrow_drop_down,
                                                // color: AppColors.primiry,
                                              ),
                                            ),
                                            style: TextStyle(
                                                color: AppColors.primiry,
                                                fontSize: 18),
                                            decoration: InputDecoration(
                                              hintText: 'Select Car Model'.tr(),
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
                                                    width: 1),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                            ),
                                            dropdownColor: Colors.white,
                                            value:
                                                (editCarsCubit.model.firstWhere(
                                              (element) {
                                                bool x = element.id ==
                                                    editCarsCubit
                                                        .myCar?.model?.id;
                                                return x
                                                    ? element.id ==
                                                        editCarsCubit
                                                            .myCar?.model?.id
                                                    : element.id ==
                                                        editCarsCubit
                                                            .model.first.id;
                                              },
                                              orElse: () => ModelsCarsModel(),
                                            )),
                                            onChanged: (newValue) {
                                              editCarsCubit
                                                      .addCarModel.model_id =
                                                  newValue?.id.toString();
                                            },
                                            items: editCarsCubit.model
                                                .map((ModelsCarsModel item) {
                                              return DropdownMenuItem(
                                                value: item,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 7,
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
                                CustomText(
                                  'Car Model Year: '.tr(),
                                  color: AppColors.primiry,
                                ),
                                TextFeildWithCustomValidation(
                                  controller: editCarsCubit.year,
                                  height: 45,
                                  hintText: 'Entetr Model Year'.tr(),
                                  keyboardType: TextInputType.number,
                                  validate: (s) {},
                                  onChange: (p) {
                                    editCarsCubit.addCarModel.year =
                                        int.tryParse(p);
                                  },
                                ),
                                CustomText(
                                  'Car KM: '.tr(),
                                  color: AppColors.primiry,
                                ),
                                TextFeildWithCustomValidation(
                                  height: 45,
                                  controller: editCarsCubit.carKm,
                                  hintText: 'Entetr Car KM'.tr(),
                                  keyboardType: TextInputType.number,
                                  validate: (s) {},
                                  onChange: (p) {
                                    editCarsCubit.addCarModel.kilometers = p;
                                  },
                                ),
                                CustomText(
                                  'Plate Number'.tr(),
                                  color: AppColors.primiry,
                                ),
                                TextFeildWithCustomValidation(
                                  height: 45,
                                  controller: editCarsCubit.plateNumber,
                                  hintText: 'Enter Plate Number'.tr(),
                                  keyboardType: TextInputType.multiline,
                                  validate: (s) {},
                                  onChange: (p) {
                                    editCarsCubit.addCarModel.plate_number = p;
                                  },
                                ),
                                CustomText(
                                  'Color'.tr(),
                                  color: AppColors.primiry,
                                ),
                                TextFeildWithCustomValidation(
                                  height: 45,
                                  controller: editCarsCubit.comment,
                                  hintText: 'Enter Your Color'.tr(),
                                  keyboardType: TextInputType.multiline,
                                  validate: (s) {},
                                  //maxlines: 3,
                                  onChange: (p) {
                                    editCarsCubit.addCarModel.notes = p;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyButton(
                                      radius: 30,
                                      color: AppColors.primiry,
                                      width: 100,
                                      height: 50,
                                      text: 'Update'.tr(),
                                      fontSize: 18,
                                      function: () async {
                                        if (_formKey.currentState!.validate()) {
                                          print(editCarsCubit.addCarModel
                                              .toMap());
                                          await editCarsCubit.updateCar(
                                              widget.id, context);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
        });
  }
}

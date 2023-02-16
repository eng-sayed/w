// import 'dart:io';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:supa_kota/domain/models/add_car_model.dart';
// import 'package:supa_kota/domain/models/brands_model.dart';
// import 'package:supa_kota/domain/models/models_car_model.dart';
// import 'package:supa_kota/presentaition/components/background_image.dart';
// import 'package:supa_kota/presentaition/components/cam_or_gallery.dart';
// import 'package:supa_kota/presentaition/components/direction.dart';
// import 'package:supa_kota/presentaition/components/loadinganderror.dart';
// import 'package:widget_mask/widget_mask.dart';

// import '../../../core/themes/colors.dart';
// import '../../../core/utiles/alerts.dart';
// import '../../../core/utiles/validation.dart';
// import '../../../domain/models/my_cars_model.dart';
// import '../../components/custom_text.dart';
// import '../../components/default_app_bar.dart';
// import '../../components/default_button.dart';
// import '../../components/default_text_field.dart';
// import 'cubit/add_car_cubit.dart';

// class AddCarRegister extends StatefulWidget {
//   AddCarRegister({
//     super.key,
//   });
//   @override
//   State<AddCarRegister> createState() => _AddCarRegisterState();
// }

// class _AddCarRegisterState extends State<AddCarRegister> {
//   String? dropdownvalue;

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       final addCarsCubit = AddCarCubit.get(context);
//       await addCarsCubit.getBrands(context).then((value) {
//         if (addCarsCubit.brands.isNotEmpty)
//           addCarModel.brand_id = addCarsCubit.brands.first.id.toString();
//         if (addCarsCubit.model.isNotEmpty)
//           addCarModel.model_id = addCarsCubit.model.first.id.toString();
//       });
//     });
//     final dates = List<DateTime>.generate(
//         200,
//         (i) => DateTime.utc(
//               DateTime.now().year - 200,
//             ).add(Duration(days: i * 365)));
//     print(dates.first.year);
//     super.initState();
//   }

//   final _formKey = GlobalKey<FormState>();
//   final addCarModel = AddCarModel();

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AddCarCubit, AddCarState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           final addCarsCubit = AddCarCubit.get(context);

//           return Background(
//             child: Scaffold(
//                 body: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   Stack(
//                     fit: StackFit.passthrough,
//                     children: [
//                       DefaultAppBar(
//                         title: 'Add Car'.tr(),
//                         desc: 'see All information about your car'.tr(),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 100.0, left: 30, right: 30),
//                               child: InkWell(
//                                 onTap: () async {
//                                   showDialog(
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return GalleryORCamera(fun0: () async {
//                                           await addCarsCubit.addImage(true);
//                                         }, fun1: () async {
//                                           await addCarsCubit.addImage(false);
//                                         });
//                                       });
//                                 },
//                                 child: addCarsCubit.pickedImage == null
//                                     ? Image.asset(
//                                         'assets/images/addcar.png',
//                                         width: 190,
//                                         height: 180,
//                                         fit: BoxFit.contain,
//                                       )
//                                     : WidgetMask(
//                                         blendMode: BlendMode.srcATop,
//                                         childSaveLayer: true,
//                                         mask: Image.file(
//                                           addCarsCubit.pickedImage!,
//                                           width: 190,
//                                           height: 180,
//                                           fit: BoxFit.fill,
//                                           errorBuilder:
//                                               ((context, error, stackTrace) =>
//                                                   Image.asset(
//                                                     'assets/images/addcar.png',
//                                                     width: 190,
//                                                     height: 180,
//                                                     fit: BoxFit.contain,
//                                                   )),
//                                         ),
//                                         child: Image.asset(
//                                           'assets/images/shi.png',
//                                           width: 180,
//                                           height: 170,
//                                           fit: BoxFit.contain,
//                                         ),
//                                       ),
//                               )),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Direction(
//                     child: Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 30, horizontal: 50),
//                         child: LoadingAndError(
//                           isLoading: state is BrandsLoadingState,
//                           isError: state is BrandsErrorState,
//                           child: ListView(
//                             // crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               if (addCarsCubit.brands.isNotEmpty)
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       CustomText(
//                                         'Car Brand'.tr(),
//                                         color: AppColors.primiry,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         child: DropdownButtonFormField<
//                                             BrandsModel>(
//                                           icon: Padding(
//                                             padding: EdgeInsets.only(
//                                                 right: 10, top: 7, left: 10),
//                                             child: Icon(
//                                               Icons.arrow_drop_down,
//                                               color: AppColors.black,
//                                             ),
//                                           ),
//                                           style: TextStyle(
//                                               color: AppColors.primiry,
//                                               fontSize: 18),
//                                           decoration: InputDecoration(
//                                             hintText: 'Select Car Brand'.tr(),
//                                             //prefix: prefixIcon,
//                                             enabledBorder: OutlineInputBorder(
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(20)),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(20)),
//                                               borderSide: BorderSide(
//                                                   color: AppColors.greyText,
//                                                   width: 2),
//                                             ),
//                                             filled: true,
//                                             fillColor: Colors.white,
//                                           ),
//                                           dropdownColor: Colors.white,
//                                           value: addCarsCubit.brands.first,
//                                           onChanged: (newValue) async {
//                                             addCarModel.brand_id =
//                                                 newValue?.id.toString();
//                                             await addCarsCubit.getModelsOfBrand(
//                                                 context, addCarModel.brand_id);
//                                           },
//                                           items: addCarsCubit.brands
//                                               .map((BrandsModel item) {
//                                             return DropdownMenuItem(
//                                               value: item,
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     top: 7,
//                                                     right: 10,
//                                                     left: 10),
//                                                 child: CustomText(item.name!),
//                                               ),
//                                             );
//                                           }).toList(),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               if (addCarsCubit.model.isNotEmpty)
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       CustomText(
//                                         'Car Model'.tr(),
//                                         color: AppColors.primiry,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         child: DropdownButtonFormField<
//                                             ModelsCarsModel>(
//                                           icon: Padding(
//                                             padding: EdgeInsets.only(
//                                                 right: 10, top: 7, left: 7),
//                                             child: Icon(
//                                               Icons.arrow_drop_down,
//                                               color: AppColors.black,
//                                             ),
//                                           ),
//                                           style: TextStyle(
//                                               color: AppColors.primiry,
//                                               fontSize: 18),
//                                           decoration: InputDecoration(
//                                             hintText: 'Select Car Model'.tr(),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(20)),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(20)),
//                                               borderSide: BorderSide(
//                                                   color: AppColors.greyText,
//                                                   width: 2),
//                                             ),
//                                             filled: true,
//                                             fillColor: Colors.white,
//                                           ),
//                                           dropdownColor: Colors.white,
//                                           value: addCarsCubit.model.first,
//                                           onChanged: (newValue) {
//                                             addCarModel.model_id =
//                                                 newValue?.id.toString();
//                                           },
//                                           items: addCarsCubit.model
//                                               .map((ModelsCarsModel item) {
//                                             return DropdownMenuItem(
//                                               value: item,
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     top: 7,
//                                                     right: 10,
//                                                     left: 10),
//                                                 child: CustomText(item.name!),
//                                               ),
//                                             );
//                                           }).toList(),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               CustomText(
//                                 'Car Model Year: '.tr(),
//                                 color: AppColors.primiry,
//                               ),
//                               TextFeildWithCustomValidation(
//                                 height: 40,
//                                 hintText: 'Entetr Model Year'.tr(),
//                                 keyboardType: TextInputType.number,
//                                 validate: (value) {
//                                   if (value!.isEmpty) {
//                                     return ("emptyfield".tr());
//                                   } else if (value.length != 4) {
//                                     return ('must be 4'.tr());
//                                   } else {
//                                     return null;
//                                   }
//                                 },
//                                 onChange: (p) {
//                                   addCarModel.year = int.tryParse(p);
//                                 },
//                               ),
//                               CustomText(
//                                 'Car KM: '.tr(),
//                                 color: AppColors.primiry,
//                               ),
//                               TextFeildWithCustomValidation(
//                                 height: 40,
//                                 hintText: '1250 Km'.tr(),
//                                 keyboardType: TextInputType.number,
//                                 validate: Validation().defaultValidation,
//                                 onChange: (p) {
//                                   addCarModel.kilometers = p;
//                                 },
//                               ),
//                               CustomText(
//                                 'Plate Number'.tr(),
//                                 color: AppColors.primiry,
//                               ),
//                               TextFeildWithCustomValidation(
//                                 height: 40,
//                                 hintText: 'Enter Plate Number'.tr(),
//                                 keyboardType: TextInputType.multiline,
//                                 validate: Validation().defaultValidation,
//                                 onChange: (p) {
//                                   addCarModel.plate_number = p;
//                                 },
//                               ),
//                               CustomText(
//                                 'Color'.tr(),
//                                 color: AppColors.primiry,
//                               ),
//                               TextFeildWithCustomValidation(
//                                 height: 40, hintText: 'Enter Your Color'.tr(),
//                                 keyboardType: TextInputType.multiline,
//                                 validate: Validation().defaultValidation,
//                                 // maxlines: 3,
//                                 onChange: (p) {
//                                   addCarModel.notes = p;
//                                 },
//                               ),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   MyButton(
//                                     height: 50,
//                                     radius: 30,
//                                     color: AppColors.primiry,
//                                     width: 100,
//                                     text: 'add'.tr(),
//                                     fontSize: 18,
//                                     function: () async {
//                                       if (_formKey.currentState!.validate()) {
//                                         if (addCarsCubit.pickedImage == null)
//                                           Fluttertoast.showToast(
//                                               msg: "selectImage".tr(),
//                                               toastLength: Toast.LENGTH_SHORT,
//                                               gravity: ToastGravity.BOTTOM,
//                                               timeInSecForIosWeb: 3,
//                                               backgroundColor:
//                                                   AppColors.primiry,
//                                               textColor: Colors.white,
//                                               fontSize: 16.0);

//                                         if (addCarsCubit.pickedImage != null)
//                                           await addCarsCubit.addCar(
//                                               addCarModel,
//                                               addCarsCubit.pickedImage!,
//                                               context,
//                                               fromRegistr: true);
//                                       }
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             )),
//           );
//         });
//   }
// }

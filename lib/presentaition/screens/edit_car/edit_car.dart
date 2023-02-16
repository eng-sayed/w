// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:supa_kota/presentaition/screens/edit_car/cubit/edit_car_cubit.dart';

// import '../../../core/themes/colors.dart';
// import '../../../core/utiles/validation.dart';
// import '../../../domain/models/add_car_model.dart';
// import '../../../domain/models/brands_model.dart';
// import '../../../domain/models/models_car_model.dart';
// import '../../../domain/models/my_cars_model.dart';
// import '../../components/background_image.dart';
// import '../../components/custom_text.dart';
// import '../../components/default_app_bar.dart';
// import '../../components/default_button.dart';
// import '../../components/default_text_field.dart';
// import '../../components/loadinganderror.dart';
// import '../../components/network_image.dart';
// import '../add_car/cubit/add_car_cubit.dart';
// import 'appbar_editcar.dart';

// class EditCar extends StatefulWidget {
//   EditCar(this.carDetails);
//   MyCarsModel carDetails;
//   @override
//   State<EditCar> createState() => _EditCarState();
// }

// class _EditCarState extends State<EditCar> {
//   AddCarModel addCarModel = AddCarModel();
//   final carKm = TextEditingController(),
//       plateNumber = TextEditingController(),
//       comment = TextEditingController();
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       final editCarsCubit = EditCarCubit.get(context);
//       await editCarsCubit.getData(context);
//       print('objectssssssss');
//       print(editCarsCubit.brands.length);
//       addCarModel = AddCarModel(
//         notes: widget.carDetails.notes ?? '',
//         image: widget.carDetails.image ?? '',
//         plate_number: widget.carDetails.plateNumber ?? '',
//         brand_id: widget.carDetails.brand?.id.toString(),
//         model_id: widget.carDetails.model?.id.toString(),
//         kilometers: widget.carDetails.kilometers.toString(),
//       );
//       carKm.text = addCarModel.kilometers.toString();
//       plateNumber.text = addCarModel.plate_number.toString();
//       comment.text = addCarModel.notes.toString();
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

//   File? pickedImage;
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<EditCarCubit, EditCarState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           final editCarsCubit = EditCarCubit.get(context);
//           print(state);
//           return Background(
//             child: Scaffold(
//                 body: Form(
//               key: _formKey,
//               child: LoadingAndError(
//                 isLoading: state is DataLoadingState,
//                 isError: state is DataErrorState,
//                 child: Column(
//                   children: [
//                     AppbarEditCar(),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 30, horizontal: 50),
//                         child: ListView(
//                           // crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (!editCarsCubit.brands.isNotEmpty)
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     CustomText(
//                                       'Car Brand',
//                                       color: AppColors.primiry,
//                                     ),
//                                     Container(
//                                       height: 60,
//                                       child:
//                                           DropdownButtonFormField<BrandsModel>(
                                      
//                                         style: TextStyle(
//                                             color: AppColors.primiry,
//                                             fontSize: 18),
//                                         decoration: InputDecoration(
//                                           hintText: 'Select Car Brand',
//                                           //prefix: prefixIcon,
//                                           enabledBorder: OutlineInputBorder(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(20)),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(20)),
//                                             borderSide: BorderSide(
//                                                 color: AppColors.greyText,
//                                                 width: 2),
//                                           ),
//                                           filled: true,
//                                           fillColor: Colors.white,
//                                         ),
//                                         dropdownColor: Colors.white,
//                                         value: editCarsCubit.brands.first
//                                         // Where(
//                                         //     (element) =>
//                                         //         element.id ==
//                                         //         addCarModel.brand_id)
//                                         ,
//                                         onChanged: (newValue) {
//                                           widget.carDetails.brand?.id =
//                                               newValue?.id;
//                                         },
//                                         items: editCarsCubit.brands
//                                             .map((BrandsModel item) {
//                                           return DropdownMenuItem(
//                                             value: item,
//                                             child: Padding(
//                                               padding: const EdgeInsets.only(
//                                                   bottom: 5,
//                                                   right: 10,
//                                                   left: 10),
//                                               child: CustomText(item.name!),
//                                             ),
//                                           );
//                                         }).toList(),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
                            
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   CustomText(
//                                     'Car Model',
//                                     color: AppColors.primiry,
//                                   ),
//                                   if (editCarsCubit.model.isNotEmpty)
//                                     Container(
//                                       height: 60,
//                                       child: DropdownButtonFormField<
//                                           ModelsCarsModel>(
//                                         // icon: Padding(
//                                         //   padding: EdgeInsets.only(right: 10),
//                                         //   child: Icon(
//                                         //     icon ?? Icons.arrow_drop_down,
//                                         //     color: AppColors.primiry,
//                                         //   ),
//                                         // ),
//                                         style: TextStyle(
//                                             color: AppColors.primiry,
//                                             fontSize: 18),
//                                         decoration: InputDecoration(
//                                           hintText: 'Select Car Model',
//                                           //prefix: prefixIcon,
//                                           enabledBorder: OutlineInputBorder(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(20)),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(20)),
//                                             borderSide: BorderSide(
//                                                 color: AppColors.greyText,
//                                                 width: 2),
//                                           ),
//                                           filled: true,
//                                           fillColor: Colors.white,
//                                         ),
//                                         dropdownColor: Colors.white,
//                                         value: editCarsCubit.model.firstWhere(
//                                             (element) =>
//                                                 element.id ==
//                                                 addCarModel.model_id),
//                                         onChanged: (newValue) {
//                                           addCarModel.model_id =
//                                               newValue?.id.toString();
//                                         },
//                                         items: editCarsCubit.model
//                                             .map((ModelsCarsModel item) {
//                                           return DropdownMenuItem(
//                                             value: item,
//                                             child: Padding(
//                                               padding: const EdgeInsets.only(
//                                                   bottom: 5,
//                                                   right: 10,
//                                                   left: 10),
//                                               child: CustomText(item.name!),
//                                             ),
//                                           );
//                                         }).toList(),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   CustomText(
//                                     'Model Year',
//                                     color: AppColors.primiry,
//                                   ),
//                                   //if (editCarsCubit.model.isNotEmpty)
//                                   Container(
//                                     height: 60,
//                                     child: DropdownButtonFormField<DateTime>(
                                      
//                                       style: TextStyle(
//                                           color: AppColors.primiry,
//                                           fontSize: 18),
//                                       decoration: InputDecoration(
//                                         hintText: 'Select Model Year',
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(20)),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(20)),
//                                           borderSide: BorderSide(
//                                               color: AppColors.greyText,
//                                               width: 2),
//                                         ),
//                                         filled: true,
//                                         fillColor: Colors.white,
//                                       ),
//                                       dropdownColor: Colors.white,
//                                       value: List<DateTime>.generate(
//                                               102,
//                                               (i) => DateTime.utc(
//                                                     DateTime.now().year - 100,
//                                                   ).add(
//                                                       Duration(days: i * 365)))
//                                           .last,
//                                       onChanged: (newValue) {
                                        
//                                       },
//                                       items: List<DateTime>.generate(
//                                               102,
//                                               (i) => DateTime.utc(
//                                                     DateTime.now().year - 100,
//                                                   ).add(
//                                                       Duration(days: i * 365)))
//                                           .map((DateTime item) {
//                                         return DropdownMenuItem(
//                                           value: item,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 bottom: 5, right: 10, left: 10),
//                                             child: CustomText(
//                                                 item.year.toString()),
//                                           ),
//                                         );
//                                       }).toList(),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),

                            
//                             CustomText(
//                               'Car Kilometers',
//                               color: AppColors.primiry,
//                             ),
//                             LoginTextField(
//                               controller: carKm,
//                               hintText: 'Entetr Car KM',
//                               keyboardType: TextInputType.multiline,
//                               validate: Validation().defaultValidation,
//                               onChange: (p) {
//                                 addCarModel.kilometers = p;
//                               },
//                             ),
//                             CustomText(
//                               'Plate Number',
//                               color: AppColors.primiry,
//                             ),
//                             LoginTextField(
//                               controller: plateNumber,
//                               hintText: 'Entetr Plate Number',
//                               keyboardType: TextInputType.multiline,
//                               validate: Validation().defaultValidation,
//                               onChange: (p) {
//                                 addCarModel.plate_number = p;
//                               },
//                             ),
                           
//                             CustomText(
//                               'Comment',
//                               color: AppColors.primiry,
//                             ),
//                             LoginTextField(
//                               controller: comment,
//                               hintText: 'Enter Your Comment',
//                               keyboardType: TextInputType.multiline,
//                               validate: Validation().defaultValidation,
//                               maxlines: 3,
//                               onChange: (p) {
//                                 addCarModel.notes = p;
//                               },
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             defaultButton(
//                               radius: 30,
//                               color: AppColors.primiry,
//                               width: 147,
//                               text: 'Update',
//                               fontSize: 18,
//                               function: () async {
//                                 if (_formKey.currentState!.validate()) {
//                                     if (pickedImage != null)
//                                       await editCarsCubit.addCar(
//                                           addCarModel, pickedImage!);
//                                 }
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             )),
//           );
//         });
//   }
// }

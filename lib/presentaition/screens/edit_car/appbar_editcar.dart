// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../../core/themes/colors.dart';
// import '../../components/default_app_bar.dart';
// import '../../components/network_image.dart';

// class AppbarEditCar extends StatelessWidget {
//   const AppbarEditCar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//                       fit: StackFit.passthrough,
//                       children: [
//                         DefaultAppBar(
//                           // icon: 'addcar',
//                           title: 'Edit Car',
//                           desc: 'see All information about your car ',
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               top: 53, left: 30, right: 30),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               IconButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   icon: Icon(
//                                     Icons.arrow_back_ios,
//                                     color: AppColors.white,
//                                   )),
//                               CircleAvatar(
//                                 backgroundColor:
//                                     Colors.grey.shade300.withOpacity(.4),
//                                 radius: 25,
//                                 child: Padding(
//                                     padding: EdgeInsets.all(10),
//                                     child: Image.asset(
//                                         'assets/images/notification1.png')),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Padding(
//                                 padding: const EdgeInsets.only(
//                                     top: 160.0, left: 30, right: 30),
//                                 child: InkWell(
//                                   onTap: () async {
//                                     final ImagePicker _picker = ImagePicker();
//                                     final XFile? image =
//                                         await _picker.pickImage(
//                                             source: ImageSource.gallery,
//                                             imageQuality: 50);
//                                     print(image);
//                                     pickedImage = File(image?.path ?? '');
                                  
//                                   },
//                                   child: NetworkImagesWidgets(
//                                     widget.carDetails.image ?? '',
//                                     width: 160,
//                                     height: 145,
//                                     fit: BoxFit.contain,
                                    
//                                   ),
//                                 )),
//                           ],
//                         ),
//                       ],
//                     ),;
//   }
// }
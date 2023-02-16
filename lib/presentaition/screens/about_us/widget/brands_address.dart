// import 'package:flutter/material.dart';

// import '../../../../core/themes/colors.dart';
// import '../../../../core/utiles/utiles.dart';
// import '../../../components/custom_text.dart';
// import '../../services/widgets/communication_wiget.dart';

// class BrandsAddress extends StatelessWidget {
//   BrandsAddress({Key? key, required this.index}) : super(key: key);
//   int index;

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(20.0))),
//         backgroundColor: AppColors.lightGreybackgound,
//         child: Container(
//           height: 400,
//           child: Stack(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: Icon(
//                           Icons.close,
//                           color: AppColors.primiry,
//                           size: 35,
//                         )),
//                   ],
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 60, bottom: 40),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           'assets/images/flag${index}.png',
//                           height: 30,
//                           width: 50,
//                           fit: BoxFit.fill,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5),
//                           child: CustomText(
//                             Utiles.flags[index],
//                             textStyleEnum: TextStyleEnum.title,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 20,
//                     ),
//                     child: Row(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CustomText('Address',
//                                 color: AppColors.primiry,
//                                 fontsize: 19,
//                                 align: TextAlign.left),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.location_on,
//                                     color: AppColors.secondary,
//                                   ),
//                                   Container(
//                                     width: 300,
//                                     child: CustomText(
//                                       'Inside Skoda Maadi Center, 199 Wadi Degla Street, Zahraa Al Maadi, Cairo Governorate 11742',
//                                       maxLines: 2,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.location_on,
//                                     color: AppColors.secondary,
//                                   ),
//                                   Container(
//                                     width: 300,
//                                     child: CustomText(
//                                       'Inside Skoda Maadi Center, 199 Wadi Degla Street, Zahraa Al Maadi, Cairo Governorate 11742',
//                                       maxLines: 2,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             CustomText(
//                               'Contact Our Sales Team',
//                               color: AppColors.primiry,
//                               fontsize: 19,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   CommuicationWidget(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     size: 16,
//                                     num: '01224464637',
//                                     color: AppColors.black,
//                                     colorIcon: AppColors.green,
//                                   ),
//                                   CommuicationWidget(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     size: 16,
//                                     num: '01224464637',
//                                     color: AppColors.black,
//                                     colorIcon: AppColors.red,
//                                   ),
//                                   CommuicationWidget(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     size: 16,
//                                     icon: Icons.email,
//                                     num: '01224464637',
//                                     color: AppColors.black,
//                                     colorIcon: AppColors.secondary,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         )
//         // title: Text("Success"),
//         // content: Text("Saved successfully"),
//         );
//   }
// }

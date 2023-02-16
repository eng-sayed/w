// import 'package:easy_localization/easy_localization.dart' hide TextDirection;
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:supa_kota/presentaition/components/background_image.dart';
// import 'package:supa_kota/presentaition/screens/reservation/reservation.dart';
// import 'package:widget_mask/widget_mask.dart';

// import '../../../core/themes/colors.dart';
// import '../../../core/utiles/navigate.dart';
// import '../../components/custom_text.dart';
// import '../../components/default_app_bar.dart';
// import '../../components/default_button.dart';
// import 'cubit/reservation_cubit.dart';

// class AllReservation extends StatefulWidget {
//   const AllReservation({super.key});

//   @override
//   State<AllReservation> createState() => _AllReservationState();
// }

// class _AllReservationState extends State<AllReservation> {
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       final cubit = ReservationCubit.get(context);
//       await cubit.getAllReservation(context);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Background(
//         child: Scaffold(
//       body: BlocConsumer<ReservationCubit, ReservationState>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             final cubit = ReservationCubit.get(context);
//             return RefreshIndicator(
//               onRefresh: () async {
//                 await cubit.getAllReservation(context);
//               },
//               child: Column(
//                 children: [
//                   Stack(
//                     children: [
//                       DefaultAppBar(
//                         title: 'reservations'.tr(),
//                         // desc: 'see All information about your car'.tr(),
//                       ),
//                       Padding(
//                         padding:
//                             const EdgeInsets.only(top: 20, left: 30, right: 30),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             IconButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 icon: Icon(
//                                   Icons.arrow_back_ios,
//                                   color: AppColors.white,
//                                 )),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Directionality(
//                     textDirection: context.locale == Locale('en', 'US')
//                         ? TextDirection.ltr
//                         : TextDirection.rtl,
//                     child: Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: ListView.builder(
//                             itemCount: cubit.reservationsModel.length,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Card(
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(20.0),
//                                               child: WidgetMask(
//                                                 blendMode: BlendMode.srcATop,
//                                                 childSaveLayer: true,
//                                                 mask: Image.network(
//                                                   cubit.reservationsModel[index]
//                                                           .car?.image ??
//                                                       "",
//                                                   fit: BoxFit.cover,
//                                                   errorBuilder: ((context,
//                                                           error, stackTrace) =>
//                                                       Image.asset(
//                                                         'assets/images/logo2.png',
//                                                         fit: BoxFit.cover,
//                                                       )),
//                                                 ),
//                                                 child: Image.asset(
//                                                   'assets/images/shi.png',
//                                                   // width: 400,
//                                                   // height: 250,
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           Expanded(
//                                             flex: 2,
//                                             child: Column(
//                                               children: [
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     CustomText(
//                                                         'Car Brand: '.tr()),
//                                                     CustomText(cubit
//                                                             .reservationsModel[
//                                                                 index]
//                                                             .car
//                                                             ?.brand
//                                                             ?.name ??
//                                                         ''),
//                                                   ],
//                                                 ),
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     CustomText(
//                                                         'Car Model: '.tr()),
//                                                     CustomText(cubit
//                                                             .reservationsModel[
//                                                                 index]
//                                                             .car
//                                                             ?.model
//                                                             ?.name ??
//                                                         ''),
//                                                   ],
//                                                 ),
//                                                 // Row(
//                                                 //   mainAxisAlignment:
//                                                 //       MainAxisAlignment
//                                                 //           .spaceBetween,
//                                                 //   children: [
//                                                 //     CustomText('Model year: '),
//                                                 //     CustomText('2020'),
//                                                 //   ],
//                                                 // ),
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     CustomText('Car KM: '.tr()),
//                                                     CustomText(
//                                                         '${cubit.reservationsModel[index].car?.kilometers ?? ''}'),
//                                                   ],
//                                                 ),
//                                                 defaultButton(
//                                                   function: () {
//                                                     navigateHero(
//                                                         context: context,
//                                                         route: MyReservation(
//                                                             id: cubit
//                                                                 .reservationsModel[
//                                                                     index]
//                                                                 .id
//                                                                 .toString()));
//                                                   },
//                                                   weight: FontWeight.normal,
//                                                   height: 50,
//                                                   text: 'reservation Details'
//                                                       .tr(),
//                                                   radius: 30,
//                                                   color: AppColors.primiry,
//                                                   width: 200,
//                                                   fontSize: 15,
//                                                 ),
//                                               ],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                       // Padding(
//                                       //   padding: const EdgeInsets.all(8.0),
//                                       //   child: Row(
//                                       //     mainAxisAlignment:
//                                       //         MainAxisAlignment.spaceAround,
//                                       //     children: [
//                                       //       defaultButton(
//                                       //         function: () {
//                                       //           // navigateHero(
//                                       //           //     context: context,
//                                       //           //     route: CarDetailes(
//                                       //           //         id: cubit.myCars[index].id
//                                       //           //             .toString()));
//                                       //         },
//                                       //         weight: FontWeight.normal,
//                                       //         height: 50,
//                                       //         text: 'reservation Details'.tr(),
//                                       //         radius: 30,
//                                       //         color: AppColors.primiry,
//                                       //         width: 200,
//                                       //         fontSize: 15,
//                                       //       ),
//                                       //       // defaultButton(
//                                       //       //   function: () {
//                                       //       //     showDialog(
//                                       //       //         context: context,
//                                       //       //         builder:
//                                       //       //             (BuildContext context) {
//                                       //       //           return CarComplaint();
//                                       //       //         });
//                                       //       //   },
//                                       //       //   weight: FontWeight.normal,
//                                       //       //   textColor: AppColors.primiry,
//                                       //       //   height: 40,
//                                       //       //   text: 'Compiant'.tr(),
//                                       //       //   radius: 30,
//                                       //       //   color: AppColors.white,
//                                       //       //   width: 100,
//                                       //       //   fontSize: 15,
//                                       //       // )
//                                       //     ],
//                                       //   ),
//                                       // ),
//                                       // Row(
//                                       //   mainAxisAlignment:
//                                       //       MainAxisAlignment.end,
//                                       //   children: [
//                                       //     IconButton(
//                                       //         onPressed: () {
//                                       //           showDialog(
//                                       //               context: context,
//                                       //               builder: (BuildContext
//                                       //                   contexts) {
//                                       //                 return Dialog(
//                                       //                   child: Container(
//                                       //                     decoration:
//                                       //                         BoxDecoration(
//                                       //                       shape:
//                                       //                           BoxShape.circle,
//                                       //                       color:
//                                       //                           AppColors.white,
//                                       //                     ),
//                                       //                     height: 350,
//                                       //                     child: Column(
//                                       //                       mainAxisAlignment:
//                                       //                           MainAxisAlignment
//                                       //                               .spaceAround,
//                                       //                       children: [
//                                       //                         Image.asset(
//                                       //                             'assets/images/bin.png'),
//                                       //                         CustomText(
//                                       //                             'Are you sure you want to delete this car?'
//                                       //                                 .tr()),
//                                       //                         Row(
//                                       //                           mainAxisAlignment:
//                                       //                               MainAxisAlignment
//                                       //                                   .spaceAround,
//                                       //                           children: [
//                                       //                             defaultButton(
//                                       //                                 textColor:
//                                       //                                     AppColors
//                                       //                                         .white,
//                                       //                                 radius:
//                                       //                                     30,
//                                       //                                 color: AppColors
//                                       //                                     .primiry,
//                                       //                                 width:
//                                       //                                     147,
//                                       //                                 fontSize:
//                                       //                                     18,
//                                       //                                 function:
//                                       //                                     () async {
//                                       //                                   await cubit.deleteCar(
//                                       //                                       cubit.myCars[index].id,
//                                       //                                       context);
//                                       //                                 },
//                                       //                                 text: 'Yes'
//                                       //                                     .tr()),
//                                       //                             defaultButton(
//                                       //                                 textColor:
//                                       //                                     AppColors
//                                       //                                         .primiry,
//                                       //                                 radius:
//                                       //                                     30,
//                                       //                                 color: AppColors
//                                       //                                     .white,
//                                       //                                 width:
//                                       //                                     147,
//                                       //                                 fontSize:
//                                       //                                     18,
//                                       //                                 function:
//                                       //                                     () {
//                                       //                                   Navigator.pop(
//                                       //                                       context);
//                                       //                                 },
//                                       //                                 text: 'No'
//                                       //                                     .tr()),
//                                       //                           ],
//                                       //                         )
//                                       //                       ],
//                                       //                     ),
//                                       //                   ),
//                                       //                 );
//                                       //               });
//                                       //         },
//                                       //         icon: Icon(
//                                       //           Icons.delete,
//                                       //           color: AppColors.red,
//                                       //         ))
//                                       //   ],
//                                       // )
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             );
//           }),
//     ));
//   }
// }

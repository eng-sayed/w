// // import 'package:another_flushbar/flushbar.dart';
// import 'package:easy_localization/easy_localization.dart' hide TextDirection;
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:readmore/readmore.dart';
// import 'package:supa_kota/core/utiles/navigate.dart';
// import 'package:supa_kota/data/hive/local_hive.dart';
// import 'package:supa_kota/presentaition/components/default_text_field.dart';
// import 'package:supa_kota/presentaition/screens/services/services_screen%20.dart';

// import '../../../../core/themes/colors.dart';
// import '../../../../core/utiles/alerts.dart';
// import '../../../../core/utiles/utiles.dart';
// import '../../../../domain/models/branches_model.dart';
// import '../../../../domain/models/my_cars_model.dart';
// import '../../../../domain/models/services_model.dart';
// import '../../../components/custom_text.dart';
// import '../../../components/default_button.dart';
// import '../../about_us/widget/brands_address.dart';
// import '../../call/call.dart';
// import '../cubit/services_cubit.dart';
// import 'add_to_cart.dart';
// import 'check_branch.dart';
// import 'check_car.dart';
// import 'communication_wiget.dart';
// import 'date_time.dart';
// import 'dialog_request.dart';

// class DescriptionServicesDetails extends StatelessWidget {
//   DescriptionServicesDetails({super.key});
//   // Flushbar? flush;
//   // bool? _wasButtonClicked;
//   double score = 1;
//   String comment = '';
//   @override
//   Widget build(BuildContext context) {
//     final cubit = ServicesCubit.get(context);

//     return BlocConsumer<ServicesCubit, ServicesState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           return Column(
//             // crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Visibility(
//               //   visible: cubit.service.description?.isNotEmpty ?? false,
//               //   child: Column(
//               //     crossAxisAlignment: CrossAxisAlignment.start,
//               //     children: [
//               //       CustomText(
//               //         'Description'.tr(),
//               //         textStyleEnum: TextStyleEnum.title,
//               //         color: AppColors.primiry,
//               //       ),
//               //       SizedBox(
//               //         height: 15,
//               //       ),
//               //       ReadMoreText(
//               //         cubit.service.description ?? '',
//               //         trimLines: 2,
//               //         trimMode: TrimMode.Line,
//               //         trimCollapsedText: 'readMore'.tr(),
//               //         trimExpandedText: 'readLess'.tr(),
//               //         moreStyle:
//               //             TextStyle(fontSize: 15, color: AppColors.primiry),
//               //         style: TextStyle(fontSize: 15),
//               //       ),
//               //     ],
//               //   ),
//               // ),
//               SizedBox(
//                 height: 8,
//               ),
//               Visibility(
//                 visible: cubit.service.subServices?.isNotEmpty ?? false,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomText(
//                       'srvceinclude'.tr(),
//                       textStyleEnum: TextStyleEnum.title,
//                       color: AppColors.primiry,
//                     ),
//                     ConstrainedBox(
//                       constraints: BoxConstraints(maxHeight: 200),
//                       child: ListView.builder(
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: cubit.service.subServices?.length,
//                           itemBuilder: (context, i) {
//                             return Row(
//                               children: [
//                                 Icon(
//                                   Icons.check,
//                                   color: AppColors.yellow,
//                                 ),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 CustomText(
//                                   cubit.service.subServices?[i].name ?? '',
//                                   // textStyleEnum: TextStyleEnum.title,
//                                   // color: AppColors.primiry,
//                                 ),
//                               ],
//                             );
//                           }),
//                     ),
//                   ],
//                 ),
//               ),
//               ConstrainedBox(
//                 constraints: BoxConstraints(maxHeight: 100),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: cubit.service.subServices?.length,
//                         scrollDirection: Axis.horizontal,
//                         itemBuilder: (context, i) {
//                           return MyButton(
//                               function: () {
//                                 cubit.service.subServices?[i].offer == null
//                                     ? null
//                                     : showDialog(
//                                         context: context,
//                                         builder: (BuildContext contexts) {
//                                           return Dialog(
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(32.0))),
//                                             child: Directionality(
//                                               textDirection: context.locale ==
//                                                       Locale('en', 'US')
//                                                   ? TextDirection.ltr
//                                                   : TextDirection.rtl,
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                   shape: BoxShape.circle,
//                                                   color: AppColors.white,
//                                                 ),
//                                                 //  height: 350,
//                                                 child: SingleChildScrollView(
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             12.0),
//                                                     child: Column(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceAround,
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceBetween,
//                                                           children: [
//                                                             CustomText(
//                                                               cubit
//                                                                       .service
//                                                                       .subServices?[
//                                                                           i]
//                                                                       .name ??
//                                                                   '',
//                                                               color: AppColors
//                                                                   .primiry,
//                                                               textStyleEnum:
//                                                                   TextStyleEnum
//                                                                       .title,
//                                                             ),
//                                                             Column(
//                                                               children: [
//                                                                 CustomText(
//                                                                   '${cubit.service.subServices?[i].offer?.priceBefore}',
//                                                                   decoration:
//                                                                       TextDecoration
//                                                                           .lineThrough,
//                                                                   fontsize: 18,
//                                                                 ),
//                                                                 CustomText(
//                                                                     '${cubit.service.subServices?[i].offer?.priceAfter}',
//                                                                     color: AppColors
//                                                                         .primiry,
//                                                                     fontsize:
//                                                                         20),
//                                                               ],
//                                                             )
//                                                           ],
//                                                         ),
//                                                         CustomText(cubit
//                                                                 .service
//                                                                 .subServices?[i]
//                                                                 .description ??
//                                                             ""),
//                                                         CustomText(
//                                                           'Gift Offer'.tr(),
//                                                           color:
//                                                               AppColors.primiry,
//                                                           textStyleEnum:
//                                                               TextStyleEnum
//                                                                   .title,
//                                                         ),
//                                                         ListView.builder(
//                                                           shrinkWrap: true,
//                                                           physics:
//                                                               NeverScrollableScrollPhysics(),
//                                                           itemBuilder:
//                                                               (context, index) {
//                                                             return CustomText(cubit
//                                                                         .service
//                                                                         .subServices?[
//                                                                             i]
//                                                                         .offer
//                                                                         ?.gifts?[
//                                                                     index] ??
//                                                                 '');
//                                                           },
//                                                           itemCount: cubit
//                                                               .service
//                                                               .subServices?[i]
//                                                               .offer
//                                                               ?.gifts
//                                                               ?.length,
//                                                         ),
//                                                         Center(
//                                                           child: MyButton(
//                                                               function:
//                                                                   () async {
//                                                                 await cubit
//                                                                     .getData(
//                                                                         context);

//                                                                 if (state
//                                                                         is SuccessState &&
//                                                                     cubit.myCars
//                                                                             .length ==
//                                                                         0) {
//                                                                   OverLays.snack(
//                                                                       text:
//                                                                           "addcarfirst",
//                                                                       state: SnakState
//                                                                           .failed);
//                                                                 } else {
//                                                                   showDialog(
//                                                                       context:
//                                                                           context,
//                                                                       builder:
//                                                                           (BuildContext
//                                                                               context) {
//                                                                         final date =
//                                                                             DateTime.now();
//                                                                         return DialogItem(
//                                                                           date:
//                                                                               date,
//                                                                           id: cubit
//                                                                               .service
//                                                                               .subServices?[i]
//                                                                               .id
//                                                                               .toString(),
//                                                                         );
//                                                                       });
//                                                                 }
//                                                               },
//                                                               text: 'book'.tr(),
//                                                               color: AppColors
//                                                                   .primiry,
//                                                               textColor:
//                                                                   AppColors
//                                                                       .white,
//                                                               height: 50,
//                                                               width: 120,
//                                                               weight: FontWeight
//                                                                   .normal,
//                                                               radius: 20),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         });
//                               },
//                               text: cubit.service.subServices?[i].name ?? '',
//                               color: AppColors.secondary,
//                               textColor: AppColors.primiry,
//                               // height: 55,
//                               width: 150,
//                               weight: FontWeight.normal,
//                               radius: 20);
//                         }),
//                   ],
//                 ),
//               ),
//               // Padding(
//               //   padding: const EdgeInsets.symmetric(vertical: 20),
//               //   child: Row(
//               //     mainAxisAlignment: MainAxisAlignment.center,
//               //     children: [
//               //       defaultButton(
//               //           function: () {
//               //             navigate(context: context, route: CallScreen());
//               //           },
//               //           text: 'vcfd',
//               //           color: AppColors.secondary,
//               //           textColor: AppColors.primiry,
//               //           height: 50,
//               //           width: 120,
//               //           weight: FontWeight.normal,
//               //           radius: 20),
//               //       defaultButton(
//               //           weight: FontWeight.normal,
//               //           function: () {},
//               //           text: 'Sakura',
//               //           color: AppColors.primiry,
//               //           textColor: AppColors.secondary,
//               //           width: 120,
//               //           height: 50,
//               //           radius: 20),
//               //     ],
//               //   ),
//               // ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CustomText(
//                     'Rating'.tr(),
//                     textStyleEnum: TextStyleEnum.title,
//                     color: AppColors.primiry,
//                   ),
//                   ListTile(
//                     title: Row(
//                       children: [
//                         Utiles.UserImage == ''
//                             ? CircleAvatar(
//                                 radius: 22,
//                                 backgroundImage: Image.asset(
//                                   'assets/images/user.png',
//                                 ).image,
//                               )
//                             : CircleAvatar(
//                                 radius: 15,
//                                 backgroundImage: Image.network(
//                                   Utiles.UserImage,
//                                   errorBuilder: (context, error, stackTrace) =>
//                                       Image.asset('assets/images/user.png'),
//                                 ).image,
//                               ),
//                         // CircleAvatar(
//                         //   radius: 15,
//                         //   backgroundImage:
//                         //       Image.asset('assets/images/user.png').image,
//                         // ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             children: [
//                               RatingBar.builder(
//                                 // ignoreGestures: true,
//                                 initialRating: 1,
//                                 itemSize: 18,
//                                 minRating: 1,
//                                 direction: Axis.horizontal,
//                                 allowHalfRating: false,
//                                 itemCount: 5,
//                                 itemPadding:
//                                     EdgeInsets.symmetric(horizontal: 0.0),
//                                 itemBuilder: (context, _) => Icon(
//                                   Icons.star,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 onRatingUpdate: (rating) {
//                                   score = rating;
//                                   print(rating);
//                                 },
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         LoginTextField(
//                           keyboardType: TextInputType.multiline,
//                           validate: (p) {},
//                           onChange: (p) {
//                             comment = p;
//                           },
//                           hintText: 'levecomment'.tr(),
//                         ),
//                         MyButton(
//                             width: 70,
//                             height: 40,
//                             color: AppColors.primiry,
//                             fontSize: 14,
//                             function: () async {
//                               await cubit.reviewService(
//                                   cubit.service.id, score, comment, context);
//                             },
//                             text: 'Rate'.tr())
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               // ListView.builder(
//               //     shrinkWrap: true,
//               //     physics: NeverScrollableScrollPhysics(),
//               //     itemCount: cubit.reviewServices.length,
//               //     itemBuilder: (context, i) {
//               //       return ListTile(
//               //         title: Row(
//               //           children: [
//               //             CircleAvatar(
//               //               radius: 15,
//               //               backgroundImage: Image.network(
//               //                 cubit.reviewServices[i].user?.avatar ?? '',
//               //                 errorBuilder: (context, error, stackTrace) =>
//               //                     Image.asset('assets/images/user.png'),
//               //               ).image,
//               //             ),
//               //             Padding(
//               //               padding: const EdgeInsets.all(8.0),
//               //               child: Column(
//               //                 children: [
//               //                   CustomText(
//               //                       cubit.reviewServices[i].user?.name ?? ''),
//               //                   RatingBar.builder(
//               //                     ignoreGestures: true,
//               //                     initialRating:
//               //                         (cubit.reviewServices[i].score ?? 1)
//               //                             .toDouble(),
//               //                     itemSize: 18,
//               //                     minRating: 1,
//               //                     direction: Axis.horizontal,
//               //                     allowHalfRating: false,
//               //                     itemCount: 5,
//               //                     itemPadding:
//               //                         EdgeInsets.symmetric(horizontal: 0.0),
//               //                     itemBuilder: (context, _) => Icon(
//               //                       Icons.star,
//               //                       color: Colors.amber,
//               //                       size: 20,
//               //                     ),
//               //                     onRatingUpdate: (rating) {
//               //                       print(rating);
//               //                     },
//               //                   ),
//               //                 ],
//               //               ),
//               //             )
//               //           ],
//               //         ),
//               //         subtitle:
//               //             CustomText(cubit.reviewServices[i].comment ?? ''),
//               //       );
//               //     }),
//               // Padding(
//               //   padding: const EdgeInsets.symmetric(vertical: 20),
//               //   child: Row(
//               //     mainAxisAlignment: MainAxisAlignment.center,
//               //     children: [
//               //       MyButton(
//               //           function: () async {
//               //             await cubit.getData(context);

//               //             if (state is SuccessState &&
//               //                 cubit.myCars.length == 0) {
//               //               OverLays.snack(
//               //                   text: "addcarfirst", state: SnakState.failed);
//               //             } else {
//               //               showDialog(
//               //                   context: context,
//               //                   builder: (BuildContext context) {
//               //                     final date = DateTime.now();
//               //                     return DialogItem(date: date);
//               //                   });
//               //             }
//               //           },
//               //           text: 'book'.tr(),
//               //           color: AppColors.primiry,
//               //           textColor: AppColors.white,
//               //           height: 50,
//               //           width: 120,
//               //           weight: FontWeight.normal,
//               //           radius: 20),
//               //       MyButton(
//               //           weight: FontWeight.normal,
//               //           function: () {
//               //             showModalBottomSheet(
//               //               shape: RoundedRectangleBorder(
//               //                 borderRadius: BorderRadius.vertical(
//               //                   top: Radius.circular(20),
//               //                 ),
//               //               ),
//               //               context: context,
//               //               builder: (BuildContext context) {
//               //                 return AddToCart();
//               //               },
//               //             );
//               //           },
//               //           text: 'add'.tr(),
//               //           color: AppColors.white,
//               //           textColor: AppColors.primiry,
//               //           width: 120,
//               //           height: 50,
//               //           radius: 20),
//               //     ],
//               //   ),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.symmetric(vertical: 15),
//               //   child: Column(
//               //     mainAxisAlignment: MainAxisAlignment.end,
//               //     children: [
//               //       CustomText(
//               //         'Contactteam'.tr(),
//               //         color: AppColors.primiry,
//               //         fontsize: 19,
//               //       ),
//               //       ListView.builder(
//               //         shrinkWrap: true,
//               //         physics: NeverScrollableScrollPhysics(),
//               //         itemBuilder: (context, index) {
//               //           return GestureDetector(
//               //             onTap: () {
//               //               Utiles.makeCall(Utiles.Allphones[index]);
//               //             },
//               //             child: CommuicationWidget(
//               //               size: 16,
//               //               num: Utiles.Allphones[index],
//               //               color: AppColors.black,
//               //               colorIcon: AppColors.green,
//               //             ),
//               //           );
//               //         },
//               //         itemCount: 1,
//               //       ),
//               //     ],
//               //   ),
//               // ),
//             ],
//           );
//         });
//   }
// }
// //Smart cars need attention and constant examination, and we are here to provide you with these services ,our services for your safety car Paint protection film, window tint film , safety glass film, thermal  insulation films
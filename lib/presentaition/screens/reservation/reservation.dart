// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:easy_localization/easy_localization.dart' hide TextDirection;
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:supa_kota/presentaition/components/background_image.dart';
// import 'package:supa_kota/presentaition/components/network_image.dart';

// import '../../../core/themes/colors.dart';
// import '../../../core/utiles/utiles.dart';
// import '../../components/custom_text.dart';
// import '../../components/default_app_bar.dart';
// import '../../components/default_button.dart';
// import '../../components/default_text_field.dart';
// import '../../components/loadinganderror.dart';
// import '../services/cubit/services_cubit.dart';
// import 'cubit/reservation_cubit.dart';
// import 'package:easy_stepper/easy_stepper.dart';
// import 'package:flutter/cupertino.dart';

// class MyReservation extends StatefulWidget {
//   MyReservation({super.key, required this.id});
//   String id;
//   @override
//   State<MyReservation> createState() => _MyReservationState();
// }

// class _MyReservationState extends State<MyReservation> {
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       final cubit = ReservationCubit.get(context);
//       await cubit.getOneReservation(widget.id, context);
//       // await servicesCubit.getServiceAndReviews(widget.id, context);
//     });
//     super.initState();
//   }

//   int activeStep = 0;
//   String comment = '';
//   String promocode = '';

//   double score = 1;
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Background(
//       child: BlocConsumer<ReservationCubit, ReservationState>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             final servDetailsCubit = ServicesCubit.get(context);

//             final cubit = ReservationCubit.get(context);

//             return Scaffold(
//               body: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Stack(
//                       children: [
//                         DefaultAppBar(
//                           icon: 'cardetails',
//                           title: 'reservation Details'.tr(),
//                           // desc: 'see All information about your car'.tr(),
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
//                               // GestureDetector(
//                               //   onTap: () {
//                               //     navigate(
//                               //         context: context,
//                               //         route: NotificationScreen());
//                               //   },
//                               //   child: CircleAvatar(
//                               //     backgroundColor:
//                               //         Colors.grey.shade300.withOpacity(.4),
//                               //     radius: 25,
//                               //     child: Padding(
//                               //         padding: EdgeInsets.all(10),
//                               //         child: Image.asset(
//                               //             'assets/images/notification1.png')),
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.end,
//                     //   children: [
//                     //     Padding(
//                     //       padding: const EdgeInsets.only(top: 20.0),
//                     //       child: defaultButton(
//                     //         weight: FontWeight.w600,
//                     //         height: 60,
//                     //         radius: 30,
//                     //         color: AppColors.secondary,
//                     //         textColor: AppColors.primiry,
//                     //         width: 200,
//                     //         text: 'Sell this car'.tr(),
//                     //         fontSize: 18,
//                     //         function: () {},
//                     //       ),
//                     //     ),
//                     //   ],
//                     // ),
//                     // Padding(
//                     //   padding: const EdgeInsets.symmetric(horizontal: 30),
//                     //   child: CustomText(
//                     //     "${cubit.oneReservations?.car?.brand?.name ?? ''} ${cubit.oneReservations?.car?.model?.name ?? ''}",
//                     //     textStyleEnum: TextStyleEnum.title,
//                     //   ),
//                     // ),
//                     // Padding(
//                     //   padding: const EdgeInsets.symmetric(vertical: 15),
//                     //   child: CarouselSlider(
//                     //     options: CarouselOptions(
//                     //       height: 250,
//                     //       autoPlay: false,
//                     //       viewportFraction: .4,
//                     //       enableInfiniteScroll: false,
//                     //       aspectRatio: 30,
//                     //       enlargeCenterPage: true,
//                     //       enlargeStrategy: CenterPageEnlargeStrategy.height,
//                     //     ),
//                     //     items: List.generate(
//                     //       4,
//                     //       (index) => ClipRRect(
//                     //         borderRadius: BorderRadius.circular(30.0),
//                     //         child: Image.asset(
//                     //           'assets/images/${index}.jpg',
//                     //           height: 200,
//                     //           width: 250,
//                     //           fit: BoxFit.fill,
//                     //         ),
//                     //       ),
//                     //     ),
//                     //   ),
//                     // ),

//                     // ConstrainedBox(
//                     //   constraints: BoxConstraints(
//                     //       maxHeight: 100, maxWidth: 300, minWidth: 50),
//                     //   child: Stepper(
//                     //     currentStep: cubit.index,
//                     //     type: StepperType.horizontal,
//                     //     steps: List.generate(
//                     //       cubit.oneReservations?.progress?.length ?? 0,
//                     //       (index) => Step(
//                     //           state: index + 1 <= cubit.index
//                     //               ? StepState.complete
//                     //               : StepState.disabled,
//                     //           title: CustomText(
//                     //               cubit.oneReservations?.progress?[index].name ??
//                     //                   '',
//                     //               color: AppColors.primiry,
//                     //               fontsize: 18),
//                     //           subtitle: CustomText(
//                     //               cubit.oneReservations?.progress?[index].name ??
//                     //                   '',
//                     //               color: AppColors.primiry,
//                     //               fontsize: 18),
//                     //           content: SizedBox(
//                     //             width: double.infinity,
//                     //           ),
//                     //           isActive: true),
//                     //     ),
//                     //     controlsBuilder: (context, details) {
//                     //       return SizedBox();
//                     //     },
//                     //   ),
//                     // ),
//                     SingleChildScrollView(
//                       child: LoadingAndError(
//                         isError: state is OneErrorReservations,
//                         isLoading: state is OneLoadingReservations,
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 20),
//                           child: Directionality(
//                             textDirection: context.locale == Locale('en', 'US')
//                                 ? TextDirection.ltr
//                                 : TextDirection.rtl,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 30),
//                                   child: CustomText(
//                                     "${cubit.oneReservations?.car?.brand?.name ?? ''} ${cubit.oneReservations?.car?.model?.name ?? ''}",
//                                     textStyleEnum: TextStyleEnum.title,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 115,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: ListView(
//                                       scrollDirection: Axis.horizontal,
//                                       children: List.generate(
//                                           cubit.oneReservations?.progress
//                                                   ?.length ??
//                                               0, (index) {
//                                         return Row(
//                                           children: [
//                                             Column(
//                                               children: [
//                                                 InkWell(
//                                                   onTap: () {
//                                                     cubit.changeIndex(index);
//                                                   },
//                                                   child: Stack(
//                                                     children: [
//                                                       CircleAvatar(
//                                                         backgroundImage:
//                                                             Image.network(cubit
//                                                                         .oneReservations
//                                                                         ?.progress?[
//                                                                             index]
//                                                                         .icon ??
//                                                                     '')
//                                                                 .image,
//                                                         radius: 30,
//                                                       ),
//                                                       if (index + 1 <=
//                                                           cubit.index)
//                                                         CircleAvatar(
//                                                           child: Container(
//                                                               child: Icon(Icons
//                                                                   .assignment_turned_in_outlined)),
//                                                           radius: 30,
//                                                         ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 CustomText(
//                                                     cubit
//                                                             .oneReservations
//                                                             ?.progress?[index]
//                                                             .name ??
//                                                         '',
//                                                     color: AppColors.primiry,
//                                                     fontsize: 18),
//                                               ],
//                                             ),
//                                             if (index != 5)
//                                               SizedBox(
//                                                   width: 50,
//                                                   child: Divider(
//                                                     thickness: 1,
//                                                   ))
//                                           ],
//                                         );
//                                       }),
//                                     ),
//                                   ),
//                                 ),
//                                 // ConstrainedBox(
//                                 //   constraints: BoxConstraints(maxHeight: 100),
//                                 //   child: Stepper(
//                                 //     currentStep: cubit.index,
//                                 //     // physics: ClampingScrollPhysics(),
//                                 //     type: StepperType.horizontal,
//                                 //     steps: List.generate(
//                                 //       cubit.oneReservations?.progress?.length ?? 0,
//                                 //       (index) => Step(
//                                 //           state: index + 1 <= cubit.index
//                                 //               ? StepState.complete
//                                 //               : StepState.disabled,
//                                 //           title: CustomText(
//                                 //               cubit.oneReservations?.progress?[index]
//                                 //                       .name ??
//                                 //                   '',
//                                 //               color: AppColors.primiry,
//                                 //               fontsize: 18),
//                                 //           subtitle: CustomText(
//                                 //               cubit.oneReservations?.progress?[index]
//                                 //                       .name ??
//                                 //                   '',
//                                 //               color: AppColors.primiry,
//                                 //               fontsize: 18),
//                                 //           content: SizedBox(
//                                 //             width: double.infinity,
//                                 //           ),
//                                 //           isActive: true),
//                                 //     ),
//                                 //     // controlsBuilder: (context, details) {
//                                 //     //   return SizedBox();
//                                 //     // },
//                                 //   ),
//                                 // ),
//                                 // EasyStepper(
//                                 //   activeStep: 3,
//                                 //   lineLength: 50,
//                                 //   lineType: LineType.dotted,
//                                 //   steps: List.generate(
//                                 //       cubit.oneReservations?.progress?.length ?? 0,
//                                 //       (index) => EasyStep(
//                                 //             icon: Icon(CupertinoIcons.info),
//                                 //             activeIcon: Icon(CupertinoIcons.info),
//                                 //             title: cubit.oneReservations
//                                 //                     ?.progress?[index].name ??
//                                 //                 '',
//                                 //           )),

//                                 // const [
//                                 //   EasyStep(
//                                 //     icon: Icon(Icons.check),
//                                 //     activeIcon: Icon(CupertinoIcons.cart),
//                                 //     title: 'checking',
//                                 //     finishIcon:
//                                 //         Icon(Icons.check_circle_outline_rounded),
//                                 //   ),
//                                 //   EasyStep(
//                                 //     icon: Icon(CupertinoIcons.info),
//                                 //     activeIcon: Icon(CupertinoIcons.info),
//                                 //     title: 'washing',
//                                 //   ),
//                                 //   EasyStep(
//                                 //     icon: Icon(CupertinoIcons.cart_fill_badge_plus),
//                                 //     activeIcon:
//                                 //         Icon(CupertinoIcons.cart_fill_badge_plus),
//                                 //     title: 'preparing',
//                                 //   ),
//                                 //   EasyStep(
//                                 //     icon: Icon(CupertinoIcons.money_dollar),
//                                 //     activeIcon: Icon(CupertinoIcons.money_dollar),
//                                 //     title: 'cutting',
//                                 //   ),
//                                 //   EasyStep(
//                                 //     icon: Icon(Icons.file_present_rounded),
//                                 //     activeIcon: Icon(Icons.file_present_rounded),
//                                 //     title: 'composition',
//                                 //   ),
//                                 //   EasyStep(
//                                 //     icon: Icon(Icons.check_circle_outline),
//                                 //     activeIcon: Icon(Icons.check_circle_outline),
//                                 //     title: 'delivery',
//                                 //   ),
//                                 // ],
//                                 //   onStepReached: (index) =>
//                                 //       setState(() => activeStep = index),
//                                 // ),
//                                 if (cubit.oneReservations?.progress
//                                         ?.isNotEmpty ??
//                                     false)
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: InkWell(
//                                       onTap: () {
//                                         //             showDialog(
//                                         //                 context: context,
//                                         //                 builder: (BuildContext context) {
//                                         //                   final date = DateTime.now();
//                                         //                   return Dialog(
//                                         //                       shape: RoundedRectangleBorder(
//                                         //                           borderRadius:
//                                         //                               BorderRadius.all(
//                                         //                                   Radius.circular(
//                                         //                                       32.0))),
//                                         //                       child: Padding(
//                                         //                           padding: const EdgeInsets
//                                         //                                   .symmetric(
//                                         //                               vertical: 20,
//                                         //                               horizontal: 10),
//                                         //                           child: Directionality(
//                                         //                               textDirection: context
//                                         //                                           .locale ==
//                                         //                                       Locale('en', 'US')
//                                         //                                   ? TextDirection.ltr
//                                         //                                   : TextDirection.rtl,
//                                         //                               child:
//                                         //                                   SingleChildScrollView(
//                                         //                                       child: Container(
//                                         //                                 height: 500,
//                                         //                                 decoration:
//                                         //                                     BoxDecoration(
//                                         //                                   shape:
//                                         //                                       BoxShape.circle,
//                                         //                                   color:
//                                         //                                       AppColors.white,
//                                         //                                 ),
//                                         //                                 child: Column(children: [    Stack(
//                                         //   alignment: Alignment.bottomCenter,
//                                         //   children: [
//                                         //     Padding(
//                                         //       padding: const EdgeInsets.symmetric(vertical: 15),
//                                         //       child: CarouselSlider(
//                                         //         options: CarouselOptions(
//                                         //           height: 250,
//                                         //           autoPlay: true,
//                                         //           viewportFraction: 1,
//                                         //           enableInfiniteScroll: true,
//                                         //           aspectRatio: 1.5,
//                                         //           enlargeCenterPage: true,
//                                         //           enlargeStrategy:
//                                         //               CenterPageEnlargeStrategy.scale,
//                                         //         ),
//                                         //         items: List.generate(
//                                         //        cubit
//                                         //                           .oneReservations
//                                         //                           ?.progress?[cubit.indexData].partsDetails?.length ?? 0,
//                                         //           (index) => NetworkImagesWidgets(
//                                         //             'https://www.supakotoapp.com${cubit.aboutUsModel?.aboutGallery?[index] ?? ''}',
//                                         //             height: 312,
//                                         //             width: 820,
//                                         //             fit: BoxFit.cover,
//                                         //             // errorBuilder: (context, error, stackTrace) =>
//                                         //             //     Image.asset(
//                                         //             //   'assets/images/logo2.png',
//                                         //             //   height: 250,
//                                         //             //   width: 450,
//                                         //             //   fit: BoxFit.fill,
//                                         //             // ),
//                                         //           ),
//                                         //         ),
//                                         //       ),
//                                         //     ),
//                                         //     Padding(
//                                         //       padding: const EdgeInsets.only(bottom: 30),
//                                         //       child: Row(
//                                         //           mainAxisAlignment: MainAxisAlignment.center,
//                                         //           children: List.generate(
//                                         //             cubit.aboutUsModel?.aboutGallery?.length ??
//                                         //                 0,
//                                         //             (index) => AnimatedContainer(
//                                         //               duration:
//                                         //                   const Duration(milliseconds: 200),
//                                         //               decoration: BoxDecoration(
//                                         //                 borderRadius: BorderRadius.all(
//                                         //                   Radius.circular(50),
//                                         //                 ),
//                                         //                 color: cubit.indexCrsoul == index
//                                         //                     ? AppColors.primiry
//                                         //                     : AppColors.white,
//                                         //               ),
//                                         //               margin: const EdgeInsets.only(right: 5),
//                                         //               height: 10,
//                                         //               curve: Curves.easeIn,
//                                         //               width: 10,
//                                         //             ),
//                                         //           )),
//                                         //     ),
//                                         //   ],
//                                         // ),],),
//                                         //                               )))));
//                                         //                 });
//                                       },
//                                       child: Column(
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               CustomText('nameProg'.tr()),
//                                               CustomText(cubit
//                                                       .oneReservations
//                                                       ?.progress?[
//                                                           cubit.indexData]
//                                                       .name ??
//                                                   ''),
//                                             ],
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               CustomText('status'.tr()),
//                                               CustomText(cubit
//                                                       .oneReservations
//                                                       ?.progress?[
//                                                           cubit.indexData]
//                                                       .status ??
//                                                   ''),
//                                             ],
//                                           ),
//                                           Visibility(
//                                             visible: cubit
//                                                     .oneReservations
//                                                     ?.progress?[cubit.indexData]
//                                                     .generalNotes !=
//                                                 null,
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 CustomText('Notes'.tr()),
//                                                 CustomText(cubit
//                                                         .oneReservations
//                                                         ?.progress?[
//                                                             cubit.indexData]
//                                                         .generalNotes ??
//                                                     ''),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 Container(
//                                     height: 250,
//                                     child:
//                                         //  ListView.builder(
//                                         //   scrollDirection: Axis.horizontal,
//                                         //   itemBuilder: (context, index) {
//                                         //     return

//                                         ClipRRect(
//                                       borderRadius: BorderRadius.circular(40.0),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Image.network(
//                                           cubit.oneReservations?.car?.image ??
//                                               '',
//                                           height: 200,
//                                           width: double.infinity,
//                                           fit: BoxFit.cover,
//                                           errorBuilder:
//                                               (context, error, stackTrace) {
//                                             return Image.asset(
//                                               Utiles.errorImage,
//                                               height: 200,
//                                               width: double.infinity,
//                                               fit: BoxFit.cover,
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     )
//                                     //     ;
//                                     //   },
//                                     //   itemCount: 4,
//                                     // ),
//                                     ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 30),
//                                   child: CustomText(
//                                     'Color'.tr(),
//                                     textStyleEnum: TextStyleEnum.title,
//                                     fontsize: 20,
//                                     color: AppColors.primiry,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 30),
//                                   child: CustomText(
//                                     cubit.oneReservations?.car?.notes ?? '',
//                                     textStyleEnum: TextStyleEnum.normal,
//                                   ),
//                                 ),
//                                 if (cubit.index == 6)
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 40),
//                                     child: SizedBox(
//                                       width: double.infinity,
//                                       child: Divider(color: AppColors.primiry),
//                                     ),
//                                   ),
//                                 if (cubit.index == 6)
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 20),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         CustomText(
//                                           'Rating'.tr(),
//                                           textStyleEnum: TextStyleEnum.title,
//                                           color: AppColors.primiry,
//                                         ),
//                                         ListTile(
//                                           title: Row(
//                                             children: [
//                                               Utiles.UserImage == ''
//                                                   ? CircleAvatar(
//                                                       radius: 22,
//                                                       backgroundImage:
//                                                           Image.asset(
//                                                         'assets/images/user1.png',
//                                                       ).image,
//                                                     )
//                                                   : CircleAvatar(
//                                                       radius: 15,
//                                                       backgroundImage:
//                                                           Image.network(
//                                                         Utiles.UserImage,
//                                                         errorBuilder: (context,
//                                                                 error,
//                                                                 stackTrace) =>
//                                                             Image.asset(
//                                                                 'assets/images/user1.png'),
//                                                       ).image,
//                                                     ),
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Column(
//                                                   children: [
//                                                     RatingBar.builder(
//                                                       // ignoreGestures: true,
//                                                       initialRating: 1,
//                                                       itemSize: 18,
//                                                       minRating: 1,
//                                                       direction:
//                                                           Axis.horizontal,
//                                                       allowHalfRating: false,
//                                                       itemCount: 5,
//                                                       itemPadding:
//                                                           EdgeInsets.symmetric(
//                                                               horizontal: 0.0),
//                                                       itemBuilder:
//                                                           (context, _) => Icon(
//                                                         Icons.star,
//                                                         color: Colors.amber,
//                                                         size: 20,
//                                                       ),
//                                                       onRatingUpdate: (rating) {
//                                                         score = rating;
//                                                         print(rating);
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           subtitle: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.end,
//                                             children: [
//                                               TextFeildWithCustomValidation(
//                                                 height: 60,
//                                                 keyboardType:
//                                                     TextInputType.multiline,
//                                                 maxlines: 3,
//                                                 validate: (p) {},
//                                                 onChange: (p) {
//                                                   comment = p;
//                                                 },
//                                                 hintText: 'levecomment'.tr(),
//                                               ),
//                                               MyButton(
//                                                   width: 70,
//                                                   height: 40,
//                                                   color: AppColors.primiry,
//                                                   fontSize: 14,
//                                                   function: () async {
//                                                     await servDetailsCubit
//                                                         .reviewService(
//                                                             servDetailsCubit
//                                                                 .service.id,
//                                                             score,
//                                                             comment,
//                                                             context);
//                                                   },
//                                                   text: 'Rate'.tr())
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                     // SizedBox(
//                     //   height: 100,
//                     // ),

//                     // showDialog(
//                     //     context: context,
//                     //     builder: (BuildContext context) {
//                     //       return Dialog(
//                     //           shape: RoundedRectangleBorder(
//                     //               borderRadius:
//                     //                   BorderRadius.all(Radius.circular(20.0))),
//                     //           backgroundColor: AppColors.lightGreybackgound,
//                     //           child: Container(
//                     //               height: 600,
//                     //               alignment: Alignment.center,
//                     //               child: Padding(
//                     //                 padding: const EdgeInsets.symmetric(
//                     //                     horizontal: 20, vertical: 10),
//                     //                 child: Column(
//                     //                   mainAxisAlignment:
//                     //                       MainAxisAlignment.spaceEvenly,
//                     //                   children: [
//                     //                     CustomText(
//                     //                       'Please rate yoir experience',
//                     //                       textStyleEnum: TextStyleEnum.title,
//                     //                       fontsize: 25,
//                     //                     ),
//                     //                     RatingBar.builder(
//                     //                       initialRating: 3,
//                     //                       itemSize: 28,
//                     //                       minRating: 1,
//                     //                       direction: Axis.horizontal,
//                     //                       allowHalfRating: true,
//                     //                       itemCount: 5,
//                     //                       itemPadding: EdgeInsets.symmetric(
//                     //                           horizontal: 0.0),
//                     //                       itemBuilder: (context, _) => Icon(
//                     //                         Icons.star,
//                     //                         color: Colors.amber,
//                     //                         size: 20,
//                     //                       ),
//                     //                       onRatingUpdate: (rating) {
//                     //                         print(rating);
//                     //                       },
//                     //                     ),
//                     //                     CustomText(
//                     //                       'Rate Quality of services',
//                     //                       textStyleEnum: TextStyleEnum.title,
//                     //                       fontsize: 23,
//                     //                     ),
//                     //                     RatingBar.builder(
//                     //                       initialRating: 3,
//                     //                       itemSize: 28,
//                     //                       minRating: 1,
//                     //                       direction: Axis.horizontal,
//                     //                       allowHalfRating: true,
//                     //                       itemCount: 5,
//                     //                       itemPadding: EdgeInsets.symmetric(
//                     //                           horizontal: 0.0),
//                     //                       itemBuilder: (context, _) => Icon(
//                     //                         Icons.star,
//                     //                         color: Colors.amber,
//                     //                         size: 20,
//                     //                       ),
//                     //                       onRatingUpdate: (rating) {
//                     //                         print(rating);
//                     //                       },
//                     //                     ),
//                     //                     CustomText(
//                     //                       'Rate quality of video',
//                     //                       textStyleEnum: TextStyleEnum.title,
//                     //                       fontsize: 25,
//                     //                     ),
//                     //                     RatingBar.builder(
//                     //                       initialRating: 3,
//                     //                       itemSize: 28,
//                     //                       minRating: 1,
//                     //                       direction: Axis.horizontal,
//                     //                       allowHalfRating: true,
//                     //                       itemCount: 5,
//                     //                       itemPadding: EdgeInsets.symmetric(
//                     //                           horizontal: 0.0),
//                     //                       itemBuilder: (context, _) => Icon(
//                     //                         Icons.star,
//                     //                         color: Colors.amber,
//                     //                         size: 20,
//                     //                       ),
//                     //                       onRatingUpdate: (rating) {
//                     //                         print(rating);
//                     //                       },
//                     //                     ),
//                     //                     CustomText(
//                     //                       'Add Photo or video',
//                     //                       color: AppColors.primiry,
//                     //                       fontsize: 18,
//                     //                     ),
//                     //                     Container(
//                     //                       height: 150,
//                     //                       width: double.infinity,
//                     //                       decoration: BoxDecoration(
//                     //                           borderRadius:
//                     //                               BorderRadius.circular(20),
//                     //                           border: Border.all(
//                     //                               color: AppColors.greyText)),
//                     //                       child: Column(
//                     //                         mainAxisAlignment:
//                     //                             MainAxisAlignment.center,
//                     //                         children: [
//                     //                           Icon(
//                     //                             Icons.cloud_upload_rounded,
//                     //                             size: 50,
//                     //                           ),
//                     //                           CustomText('Click her to upload')
//                     //                         ],
//                     //                       ),
//                     //                     ),
//                     //                     defaultButton(
//                     //                       function: () {
//                     //                         navigate(
//                     //                             context: context,
//                     //                             route: HomeLayout());
//                     //                       },
//                     //                       weight: FontWeight.normal,
//                     //                       height: 40,
//                     //                       text: 'Submit',
//                     //                       radius: 30,
//                     //                       color: AppColors.primiry,
//                     //                       width: 140,
//                     //                       fontSize: 15,
//                     //                     ),
//                     //                   ],
//                     //                 ),
//                     //               )));
//                     //     });
//                   ]),
//             );
//           }),
//     );
//   }
// }

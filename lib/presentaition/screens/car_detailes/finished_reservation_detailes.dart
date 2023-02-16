import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:supa_kota/core/utiles/navigate.dart';
import 'package:supa_kota/core/utiles/responsive.dart';
import 'package:supa_kota/presentaition/components/background_image.dart';
import 'package:supa_kota/presentaition/components/custom_text.dart';
import 'package:supa_kota/presentaition/components/direction.dart';
import 'package:supa_kota/presentaition/components/loadinganderror.dart';
import 'package:supa_kota/presentaition/screens/car_detailes/widgets/dialog_car_parts.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utiles/utiles.dart';
import '../../../domain/models/reservations_model.dart';
import '../../components/cam_or_gallery.dart';
import '../../components/default_app_bar.dart';
import '../../components/default_button.dart';
import '../../components/default_text_field.dart';
import '../../components/network_image.dart';
import '../gallery/widget/image_fullscreen.dart';
import 'cubit/car_details_cubit.dart';
import 'widgets/progress_reservation.dart';
import 'widgets/rate_service_widget.dart';
import 'widgets/rating_widget.dart';
import 'widgets/receipt_image.dart';
import 'widgets/stepper_prgress.dart';

class FinishedReservationDetailes extends StatefulWidget {
  FinishedReservationDetailes(
      {super.key, required this.reservationsModel, required this.indexStepper});
  ReservationsModel? reservationsModel;
  final int indexStepper;

  @override
  State<FinishedReservationDetailes> createState() =>
      _FinishedReservationDetailesState();
}

class _FinishedReservationDetailesState
    extends State<FinishedReservationDetailes> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final cubit = CarDetailsCubit.get(context);

      await cubit.getOneReservation(widget.reservationsModel?.id, context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.reservationsModel?.id);
    final cubit = CarDetailsCubit.get(context);

    return BlocConsumer<CarDetailsCubit, CarDetailsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = CarDetailsCubit.get(context);
        return Scaffold(
          body: Background(
            child: Column(
              children: [
                Stack(
                  children: [
                    DefaultAppBar(
                      icon: 'cardetails',
                      title: "${cubit.myCar?.brand?.name ?? ''}",
                      desc: "${cubit.myCar?.model?.name ?? ''} " +
                          "${cubit.myCar?.year ?? ''} " +
                          "${cubit.myCar?.notes ?? ''}",
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 53, left: 30, right: 30),
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
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: LoadingAndError(
                    isError: cubit.state is OneErrorReservations,
                    isLoading: cubit.state is OneLoadingReservations,
                    child: Direction(
                      child: ListView(
                        padding: EdgeInsets.all(8),
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ProgressReservation(cubit: cubit),
                          ),
                          if (cubit.oneReservations?.progress?.isNotEmpty ??
                              false)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  if (cubit
                                          .oneReservations
                                          ?.progress?[cubit.indexData]
                                          .partsDetails
                                          ?.isNotEmpty ??
                                      false) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DialogCarParts(
                                            progress: cubit.oneReservations
                                                        ?.progress?[
                                                    cubit.indexData] ??
                                                Progress(),
                                            cubit: cubit,
                                            index: 0,
                                          );
                                        });
                                  }
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText('status'.tr()),
                                        CustomText(cubit
                                                .oneReservations
                                                ?.progress?[cubit.indexData]
                                                .status ??
                                            ''),
                                      ],
                                    ),
                                    Visibility(
                                      visible: cubit
                                              .oneReservations
                                              ?.progress?[cubit.indexData]
                                              .generalNotes !=
                                          null,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText('Notes'.tr()),
                                          CustomText(cubit
                                                  .oneReservations
                                                  ?.progress?[cubit.indexData]
                                                  .generalNotes ??
                                              ''),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          CustomText(
                            'bookingServices'.tr(),
                            textStyleEnum: TextStyleEnum.title,
                            fontsize: 26,
                            color: AppColors.primiry,
                          ),
                          ListView.builder(
                            padding: EdgeInsets.all(5),
                            itemCount:
                                cubit.oneReservations?.subServices?.length ?? 0,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              // return Column(
                              //   children: [
                              //     Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         CustomText(
                              //           cubit.oneReservations
                              //                   ?.subServices?[index].name ??
                              //               '',
                              //           textStyleEnum: TextStyleEnum.title,
                              //           fontsize: 22,
                              //         ),
                              //         MyButton(
                              //           text: 'Rate'.tr(),
                              //           width: 80,
                              //           height: 40,
                              //           color: AppColors.secondary,
                              //           textColor: AppColors.primiry,
                              //           function: () {
                              //             showDialog(
                              //               context: context,
                              //               builder: (BuildContext contexts) {
                              //                 return Dialog(
                              //                     shape: RoundedRectangleBorder(
                              //                         borderRadius:
                              //                             BorderRadius.all(
                              //                                 Radius.circular(
                              //                                     15.0))),
                              //                     child: Container(
                              //                       height: 300,
                              //                       child: Padding(
                              //                         padding:
                              //                             const EdgeInsets.all(
                              //                                 8.0),
                              //                         child: Center(
                              //                           child: Direction(
                              //                             child:
                              //                                 SingleChildScrollView(
                              //                               child: Column(
                              //                                 crossAxisAlignment:
                              //                                     CrossAxisAlignment
                              //                                         .start,
                              //                                 children: [
                              //                                   CustomText(
                              //                                     'Rating'.tr(),
                              //                                     textStyleEnum:
                              //                                         TextStyleEnum
                              //                                             .title,
                              //                                     color: AppColors
                              //                                         .primiry,
                              //                                   ),
                              //                                   ListTile(
                              //                                     title: Row(
                              //                                       children: [
                              //                                         Utiles.UserImage ==
                              //                                                 ''
                              //                                             ? CircleAvatar(
                              //                                                 radius: 22,
                              //                                                 backgroundImage: Image.asset(
                              //                                                   'assets/images/user1.png',
                              //                                                 ).image,
                              //                                               )
                              //                                             : CircleAvatar(
                              //                                                 radius: 15,
                              //                                                 backgroundImage: Image.network(
                              //                                                   Utiles.UserImage,
                              //                                                   errorBuilder: (context, error, stackTrace) => Image.asset('assets/images/user.png'),
                              //                                                 ).image,
                              //                                               ),
                              //                                         Padding(
                              //                                           padding:
                              //                                               const EdgeInsets.all(8.0),
                              //                                           child:
                              //                                               Column(
                              //                                             children: [
                              //                                               RatingBar.builder(
                              //                                                 // ignoreGestures: true,
                              //                                                 initialRating: 1,
                              //                                                 itemSize: 18,
                              //                                                 minRating: 1,
                              //                                                 direction: Axis.horizontal,
                              //                                                 allowHalfRating: false,
                              //                                                 itemCount: 5,
                              //                                                 itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                              //                                                 itemBuilder: (context, _) => Icon(
                              //                                                   Icons.star,
                              //                                                   color: Colors.amber,
                              //                                                   size: 20,
                              //                                                 ),
                              //                                                 onRatingUpdate: (rating) {
                              //                                                   cubit.addReviewModel?.score = rating;
                              //                                                   print(rating);
                              //                                                   print(cubit.addReviewModel?.score);
                              //                                                 },
                              //                                               ),
                              //                                             ],
                              //                                           ),
                              //                                         )
                              //                                       ],
                              //                                     ),
                              //                                     subtitle:
                              //                                         Column(
                              //                                       crossAxisAlignment:
                              //                                           CrossAxisAlignment
                              //                                               .end,
                              //                                       children: [
                              //                                         TextFeildWithCustomValidation(
                              //                                           height:
                              //                                               60,
                              //                                           keyboardType:
                              //                                               TextInputType.multiline,
                              //                                           maxlines:
                              //                                               3,
                              //                                           validate:
                              //                                               (p) {},
                              //                                           onChange:
                              //                                               (p) {
                              //                                             cubit.addReviewModel?.comment =
                              //                                                 p;
                              //                                             print(
                              //                                                 p);
                              //                                             print(cubit
                              //                                                 .addReviewModel
                              //                                                 ?.comment);
                              //                                           },
                              //                                           hintText:
                              //                                               'levecomment'.tr(),
                              //                                         ),
                              //                                         Row(
                              //                                           children: [
                              //                                             MyButton(
                              //                                               weight:
                              //                                                   FontWeight.normal,
                              //                                               height:
                              //                                                   40,
                              //                                               radius:
                              //                                                   30,
                              //                                               color:
                              //                                                   AppColors.primiry,
                              //                                               width:
                              //                                                   90,
                              //                                               text:
                              //                                                   'Car video'.tr(),
                              //                                               fontSize:
                              //                                                   14,
                              //                                               function:
                              //                                                   () {
                              //                                                 showDialog(
                              //                                                     context: context,
                              //                                                     builder: (BuildContext context) {
                              //                                                       return GalleryORCamera(
                              //                                                         fun0: () async {
                              //                                                           await cubit.addVideo(
                              //                                                             context,
                              //                                                             true,
                              //                                                           );
                              //                                                         },
                              //                                                         fun1: () async {
                              //                                                           await cubit.addVideo(
                              //                                                             context,
                              //                                                             false,
                              //                                                           );
                              //                                                         },
                              //                                                       );
                              //                                                     });
                              //                                                 //  cubit.addVideo(context, true);
                              //                                               },
                              //                                             ),
                              //                                             MyButton(
                              //                                               weight:
                              //                                                   FontWeight.normal,
                              //                                               height:
                              //                                                   40,
                              //                                               radius:
                              //                                                   30,
                              //                                               color:
                              //                                                   AppColors.primiry,
                              //                                               width:
                              //                                                   90,
                              //                                               text:
                              //                                                   'Car photo'.tr(),
                              //                                               fontSize:
                              //                                                   14,
                              //                                               function:
                              //                                                   () {
                              //                                                 cubit.addImage(context);
                              //                                               },
                              //                                             ),
                              //                                           ],
                              //                                         ),
                              //                                         MyButton(
                              //                                             width:
                              //                                                 70,
                              //                                             height:
                              //                                                 40,
                              //                                             color: AppColors
                              //                                                 .primiry,
                              //                                             fontSize:
                              //                                                 14,
                              //                                             function:
                              //                                                 () async {
                              //                                               //print(subServices.parent_id);
                              //                                               await cubit.reviewService(widget.reservationsModel?.subServices?[index].id,
                              //                                                   context);
                              //                                             },
                              //                                             text:
                              //                                                 'Rate'.tr())
                              //                                       ],
                              //                                     ),
                              //                                   ),
                              //                                 ],
                              //                               ),
                              //                             ),
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     ));
                              //                 //   return RatingReservationWidget(
                              //                 //       cubit: cubit,
                              //                 //       subServices: widget
                              //                 //                   .reservationsModel
                              //                 //                   ?.subServices?[
                              //                 //               index] ??
                              //                 //           SubServices());
                              //                 // });
                              //               },
                              //             );
                              //           },
                              //         ),
                              //       ],
                              //     ),
                              //     SizedBox(
                              //       width: (((index) + 1) ==
                              //               cubit.oneReservations?.subServices
                              //                   ?.length)
                              //           ? 600
                              //           : 400,
                              //       child: Divider(color: AppColors.primiry),
                              //     )
                              //   ],
                              // );
                              return RateServiceWidget(
                                cubit: cubit,
                                reservationsModel: widget.reservationsModel!,
                                index: index,
                              );
                            },
                          ),
                          CustomText(
                            'ServiceType'.tr(),
                            textStyleEnum: TextStyleEnum.title,
                            color: AppColors.primiry,
                            fontsize: 26,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  CustomText(
                                    cubit.oneReservations?.type ?? '',
                                    textStyleEnum: TextStyleEnum.title,
                                    fontsize: 22,
                                  ),
                                  SizedBox(
                                    width: 400,
                                    child: Divider(color: AppColors.primiry),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Visibility(
                            visible:
                                cubit.oneReservations?.reservationDate != null,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                      'ServiceDate'.tr(),
                                      textStyleEnum: TextStyleEnum.title,
                                      color: AppColors.primiry,
                                    ),
                                  ],
                                ),
                                CustomText(
                                  cubit.oneReservations?.reservationDate ?? '',
                                  textStyleEnum: TextStyleEnum.title,
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: cubit.oneReservations?.notes != null,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                      'Notes'.tr(),
                                      textStyleEnum: TextStyleEnum.title,
                                      color: AppColors.primiry,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        CustomText(
                                          cubit.oneReservations?.notes ?? '',
                                          textStyleEnum: TextStyleEnum.title,
                                        ),
                                        SizedBox(
                                          width: 400,
                                          child:
                                              Divider(color: AppColors.primiry),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible:
                                cubit.oneReservations?.insurance_image != null,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                      'insurance_image'.tr(),
                                      textStyleEnum: TextStyleEnum.title,
                                      color: AppColors.primiry,
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    navigate(
                                        context: context,
                                        route: ImageFullScreen(
                                          image: cubit.oneReservations
                                                  ?.insurance_image ??
                                              '',
                                        ));
                                  },
                                  child: NetworkImagesWidgets(
                                    cubit.oneReservations?.insurance_image ??
                                        '',
                                    height: 260,
                                    width: 350,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible:
                                cubit.oneReservations?.receipt_image != null,
                            child: ReceiptImage(cubit: cubit),
                          ),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

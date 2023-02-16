import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:supa_kota/core/utiles/responsive.dart';
import 'package:supa_kota/core/utiles/validation.dart';
import 'package:supa_kota/domain/models/reservations_model.dart';
import 'package:supa_kota/presentaition/components/background_image.dart';
import 'package:supa_kota/presentaition/components/custom_text.dart';
import 'package:supa_kota/presentaition/components/direction.dart';
import 'package:supa_kota/presentaition/components/loadinganderror.dart';
import 'package:supa_kota/presentaition/layout/layout.dart';
import 'package:supa_kota/presentaition/screens/car_detailes/widgets/previous_reservation_widget.dart';
import 'package:supa_kota/presentaition/screens/edit_car/edit_car.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utiles/navigate.dart';
import '../../../core/utiles/utiles.dart';
import '../../../domain/models/complains_model.dart';
import '../../../domain/models/my_cars_model.dart';
import '../../components/default_app_bar.dart';
import '../../components/default_button.dart';
import '../../components/default_text_field.dart';
import '../../components/network_image.dart';
import '../add_car/add_car.dart';
import '../add_car/cubit/add_car_cubit.dart';
import '../add_car/edit_my_car.dart';
import '../notification.dart/notification.dart';
import 'complaint_detailes.dart';
import 'cubit/car_details_cubit.dart';
import 'finished_reservation_detailes.dart';
import 'widgets/complaint_widget.dart';
import 'widgets/dialog_car_parts.dart';
import 'widgets/rating_widget.dart';
import 'widgets/sell_car_dialg.dart';
import 'widgets/stepper_prgress.dart';

class CarDetailes extends StatefulWidget {
  CarDetailes({super.key, required this.id});
  String id;

  @override
  State<CarDetailes> createState() => _CarDetailesState();
}

class _CarDetailesState extends State<CarDetailes> {
  @override
  void initState() {
    controller = ScrollController(initialScrollOffset: 0);
    controller?.addListener(() {
      print('controller?.offset');
      print(controller?.offset);
      // print('controller?.position');
      // print(controller?.position);
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final cubit = CarDetailsCubit.get(context);

      await cubit.getCarDetailes(widget.id, context);
    });

    super.initState();
  }

  String comment = '';

  double score = 1;

  ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarDetailsCubit, CarDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = CarDetailsCubit.get(context);

          return Background(
            child: Scaffold(
                body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    DefaultAppBar(
                      icon: 'cardetails',
                      title: !(controller?.hasClients ?? false)
                          ? 'My Detailes'.tr()
                          : (controller?.offset ?? 0) < 130
                              ? 'My Detailes'.tr()
                              : "${cubit.myCar?.brand?.name ?? ''}",
                      desc: !(controller?.hasClients ?? false)
                          ? 'see All information about your car'.tr()
                          : (controller?.offset ?? 0) < 130
                              ? 'see All information about your car'.tr()
                              : "${cubit.myCar?.model?.name ?? ''} " +
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
                          GestureDetector(
                            onTap: () {
                              navigate(
                                  context: context,
                                  route: NotificationScreen());
                            },
                            child: CircleAvatar(
                              backgroundColor:
                                  Colors.grey.shade300.withOpacity(.4),
                              radius: 22,
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Image.asset(
                                      'assets/images/notification1.png')),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: LoadingAndError(
                    function: () async {
                      await cubit.getOneCar(widget.id, context);
                    },
                    isError: state is CarErrorState,
                    isLoading: state is CarLoadingState,
                    child: Direction(
                      child: ListView(
                        controller: controller,
                        padding: EdgeInsets.all(5),
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Visibility(
                                visible:
                                    cubit.myCar?.reservations?.isEmpty ?? false,
                                child: MyButton(
                                  padding: 3,
                                  weight: FontWeight.w500,
                                  height: 40,
                                  radius: 30,
                                  color: AppColors.primiry,
                                  textColor: AppColors.white,
                                  width: 110,
                                  text: 'Editcar'.tr(),
                                  fontSize: 18,
                                  function: () {
                                    navigate(
                                        context: context,
                                        route: EditMyCar(
                                          id: "${cubit.myCar?.id ?? ''}",
                                        ));
                                  },
                                ),
                              ),
                              MyButton(
                                padding: 3,
                                weight: FontWeight.w500,
                                height: 40,
                                radius: 30,
                                color: AppColors.secondary,
                                textColor: AppColors.primiry,
                                width: 110,
                                text: 'Sell this car'.tr(),
                                fontSize: 18,
                                function: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SellCarDialog(
                                          cubit: cubit,
                                        );
                                      });
                                },
                              ),
                              if (cubit.myCar?.selling == false)
                                Visibility(
                                  visible: cubit.myCar?.reservations?.isEmpty ??
                                      false,
                                  child: MyButton(
                                    padding: 3,
                                    function: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors.white,
                                                ),
                                                height: 300,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/bin.png',
                                                      height: 200,
                                                      width: 200,
                                                      fit: BoxFit.fill,
                                                    ),
                                                    CustomText(
                                                      'Are you sure you want to delete this car?'
                                                          .tr(),
                                                      fontsize: 18,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Spacer(),
                                                        MyButton(
                                                            textColor:
                                                                AppColors.white,
                                                            radius: 30,
                                                            color: AppColors
                                                                .primiry,
                                                            width: 100,
                                                            fontSize: 18,
                                                            function: () async {
                                                              final m = await cubit
                                                                  .deleteCar(
                                                                      cubit
                                                                          .myCar
                                                                          ?.id,
                                                                      context)
                                                                  .then((s) {
                                                                if (s)
                                                                  Navigator.pop(
                                                                      context);
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                              //status ?

                                                              // : null;
                                                            },
                                                            text: 'Yes'.tr()),
                                                        SizedBox(
                                                          width: 30,
                                                        ),
                                                        MyButton(
                                                            textColor: AppColors
                                                                .primiry,
                                                            radius: 30,
                                                            color: AppColors
                                                                .secondary,
                                                            width: 100,
                                                            fontSize: 18,
                                                            function: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            text: 'No'.tr()),
                                                        Spacer(),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    weight: FontWeight.normal,
                                    height: 40,
                                    text: 'deletecar'.tr(),
                                    radius: 30,
                                    color: AppColors.primiry,
                                    width: 120,
                                    fontSize: 18,
                                  ),
                                ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  "${cubit.myCar?.brand?.name ?? ''}",
                                  textStyleEnum: TextStyleEnum.title,
                                  // color: AppColors.primiry,
                                ),
                                Row(
                                  children: [
                                    CustomText(
                                      cubit.myCar?.model?.name ?? '',
                                      textStyleEnum: TextStyleEnum.title,
                                      fontsize: 22,
                                      color: AppColors.primiry,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    CustomText(
                                      "${cubit.myCar?.year ?? ''}",
                                      textStyleEnum: TextStyleEnum.title,
                                      fontsize: 22,
                                      color: AppColors.primiry,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    CustomText(
                                      cubit.myCar?.notes ?? '',
                                      textStyleEnum: TextStyleEnum.title,
                                      fontsize: 22,
                                      color: AppColors.primiry,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                              height: 300,
                              child: NetworkImagesWidgets(
                                cubit.myCar?.image ?? '',
                                height: 300,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: cubit.prgressReservation?.length ?? 0,
                              itemBuilder: (context, reservationsIndex) {
                                return Column(
                                  children: [
                                    StepperPrgress(
                                      cubit: cubit,
                                      reservationsIndex: reservationsIndex,
                                      isFinishedList: false,
                                      progress: cubit
                                          .prgressReservation?[
                                              reservationsIndex]
                                          .progress,
                                      shown: false,
                                    ), //if()
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: (reservationsIndex + 1 !=
                                                  cubit.prgressReservation
                                                      ?.length)
                                              ? 300
                                              : 400,
                                          child:
                                              Divider(color: AppColors.black),
                                        )
                                      ],
                                    )
                                  ],
                                );
                              }),
                          if (cubit.finishedReservations?.isNotEmpty ?? false)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(
                                    'previousReservation'.tr(),
                                    textStyleEnum: TextStyleEnum.title,
                                    color: AppColors.primiry,
                                  ),
                                ),
                                ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        cubit.finishedReservations?.length ?? 0,
                                    itemBuilder: (context, reservationsIndex) {
                                      return PreviousReservationWidget(
                                          cubit: cubit,
                                          reservationsIndex: reservationsIndex);
                                    }),
                              ],
                            ),
                          if (cubit.complainModel.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(
                                    'complaints'.tr(),
                                    textStyleEnum: TextStyleEnum.title,
                                    color: AppColors.primiry,
                                  ),
                                ),
                                ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: cubit.complainModel.length,
                                    itemBuilder: (context, ComplaintIndex) {
                                      return ComplaintWidget(
                                          cubit: cubit,
                                          ComplaintIndex: ComplaintIndex);
                                    }),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
          );
        });
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:widget_mask/widget_mask.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/navigate.dart';
import '../../../components/custom_text.dart';
import '../../../components/default_button.dart';
import '../../car_detailes/car_detailes.dart';
import '../../cart/cart.dart';
import '../cubit/my_cars_cubit.dart';

class CarWidget extends StatelessWidget {
  CarWidget({super.key, required this.index, required this.myCarsCubit});
  final int index;
  final MyCarsCubit myCarsCubit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: InkWell(
        onTap: () {
          navigate(
              context: context,
              route: CarDetailes(id: myCarsCubit.myCars[index].id.toString()));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          shadowColor: AppColors.black,
          elevation: 1.5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/shi.png',
                      width: 160,
                      height: 180,
                      fit: BoxFit.fill,
                      color: AppColors.primiry,
                    ),
                    Image.asset(
                      'assets/images/shi.png',
                      width: 155,
                      height: 174,
                      fit: BoxFit.fill,
                      color: AppColors.white,
                    ),
                    WidgetMask(
                      blendMode: BlendMode.srcATop,
                      childSaveLayer: true,
                      mask: Image.network(
                        myCarsCubit.myCars[index].image ?? "",
                        fit: BoxFit.cover,
                        errorBuilder: ((context, error, stackTrace) =>
                            Image.asset(
                              'assets/images/logo2.png',
                              fit: BoxFit.cover,
                            )),
                      ),
                      child: Image.asset(
                        'assets/images/shi.png',
                        width: 150,
                        height: 168,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: 30,
                    // ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          myCarsCubit.myCars[index].brand?.name ?? '',
                          textStyleEnum: TextStyleEnum.title,
                        ),
                        Row(
                          children: [
                            CustomText(
                              myCarsCubit.myCars[index].model?.name ?? '',
                              textStyleEnum: TextStyleEnum.title,
                              fontsize: 17,
                              color: AppColors.primiry,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CustomText(
                              "${myCarsCubit.myCars[index].year ?? ''}",
                              textStyleEnum: TextStyleEnum.title,
                              fontsize: 17,
                              color: AppColors.primiry,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CustomText(
                              myCarsCubit.myCars[index].notes ?? '',
                              textStyleEnum: TextStyleEnum.title,
                              fontsize: 17,
                              color: AppColors.primiry,
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 80,
                    ),
                    myCarsCubit.myCars[index].selling ?? false
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MyButton(
                                  function: () {
                                    myCarsCubit.accept(
                                        myCarsCubit.myCars[index].id.toString(),
                                        context);
                                  },
                                  weight: FontWeight.normal,
                                  height: 40,
                                  text: 'Accept'.tr(),
                                  radius: 30,
                                  color: AppColors.primiry,
                                  width: 100,
                                  fontSize: 15,
                                ),
                                MyButton(
                                  function: () {
                                    myCarsCubit.reject(
                                        myCarsCubit.myCars[index].id.toString(),
                                        context);
                                  },
                                  weight: FontWeight.normal,
                                  textColor: AppColors.primiry,
                                  height: 40,
                                  text: 'Reject'.tr(),
                                  radius: 30,
                                  color: AppColors.white,
                                  width: 100,
                                  fontSize: 15,
                                )
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Visibility(
                                  visible: (myCarsCubit
                                          .myCars[index].can_complaint ??
                                      false),
                                  child: Expanded(
                                    child: MyButton(
                                      function: () async {
                                        await myCarsCubit
                                            .getCarPartsAndEndedService(
                                                context,
                                                myCarsCubit.myCars[index].id
                                                    .toString());
                                        // await myCarsCubit.getEndedServices(
                                        //     context,
                                        //     myCarsCubit.myCars[index].id.toString());
                                      },
                                      weight: FontWeight.normal,
                                      textColor: AppColors.primiry,
                                      height: 40,
                                      text: 'Compiant'.tr(),
                                      radius: 30,
                                      color: AppColors.secondary,
                                      width: 110,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: !(myCarsCubit.myCars[index]
                                          .has_active_reservation ??
                                      false),
                                  child: Expanded(
                                    child: MyButton(
                                      function: () {
                                        navigate(
                                            context: context,
                                            route: CartScreen(
                                                carId: myCarsCubit
                                                        .myCars[index].id ??
                                                    0));
                                      },
                                      weight: FontWeight.normal,
                                      textColor: AppColors.white,
                                      height: 40,
                                      text: 'booking'.tr(),
                                      radius: 30,
                                      color: AppColors.primiry,
                                      width: 110,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

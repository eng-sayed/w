import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/navigate.dart';
import '../../../components/custom_text.dart';
import '../cubit/car_details_cubit.dart';
import '../finished_reservation_detailes.dart';

class PreviousReservationWidget extends StatelessWidget {
  const PreviousReservationWidget({
    Key? key,
    required this.cubit,
    required this.reservationsIndex,
  }) : super(key: key);

  final CarDetailsCubit cubit;
  final int reservationsIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GestureDetector(
        onTap: () {
          navigate(
              context: context,
              route: FinishedReservationDetailes(
                reservationsModel:
                    cubit.finishedReservations?[reservationsIndex],
                //  cubit: cubit,
                indexStepper: reservationsIndex,
              ));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        cubit.finishedReservations?[reservationsIndex].type ??
                            '',
                        textStyleEnum: TextStyleEnum.title,
                      ),
                      Visibility(
                        visible: ((cubit
                                    .finishedReservations?[reservationsIndex]
                                    .reservationDate
                                    ?.isNotEmpty ??
                                false) ||
                            cubit.finishedReservations?[reservationsIndex]
                                    .reservationDate !=
                                null),
                        child: CustomText(
                          cubit.finishedReservations?[reservationsIndex]
                                  .reservationDate ??
                              '',
                          textStyleEnum: TextStyleEnum.normal,
                          color: AppColors.primiry,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    CustomText(
                      'MoreDetailes'.tr(),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

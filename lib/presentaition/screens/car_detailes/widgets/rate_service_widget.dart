import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../domain/models/reservations_model.dart';
import '../../../components/custom_text.dart';
import '../../../components/default_button.dart';
import '../cubit/car_details_cubit.dart';
import '../finished_reservation_detailes.dart';
import 'rating_widget.dart';

class RateServiceWidget extends StatelessWidget {
  RateServiceWidget({
    Key? key,
    required this.cubit,
    required this.reservationsModel,
    required this.index,
  }) : super(key: key);

  final CarDetailsCubit cubit;
  final int index;
  ReservationsModel reservationsModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              cubit.oneReservations?.subServices?[index].name ?? '',
              textStyleEnum: TextStyleEnum.title,
              fontsize: 22,
            ),
            MyButton(
              color: AppColors.secondary,
              textColor: AppColors.primiry,
              function: () {
                showDialog(
                    context: context,
                    builder: (BuildContext contexts) {
                      return RatingReservationWidget(
                          cubit: cubit,
                          subServices: reservationsModel.subServices?[index] ??
                              SubServices());
                    });
              },
              text: 'Rate'.tr(),
              width: 80,
              height: 40,
            ),
          ],
        ),
        SizedBox(
          width: (((index) + 1) == cubit.oneReservations?.subServices?.length)
              ? 600
              : 400,
          child: Divider(color: AppColors.primiry),
        )
      ],
    );
  }
}

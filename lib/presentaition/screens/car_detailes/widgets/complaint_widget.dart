import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utiles/navigate.dart';
import '../../../../domain/models/complains_model.dart';
import '../../../components/custom_text.dart';
import '../complaint_detailes.dart';
import '../cubit/car_details_cubit.dart';

class ComplaintWidget extends StatelessWidget {
  const ComplaintWidget({
    Key? key,
    required this.cubit,
    required this.ComplaintIndex,
  }) : super(key: key);

  final CarDetailsCubit cubit;
  final int ComplaintIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GestureDetector(
        onTap: () {
          navigate(
              context: context,
              route: ComplaintsDetailes(
                cubit: cubit,
                complainModel:
                    cubit.complainModel[ComplaintIndex] ?? ComplainModel(),
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
                        cubit.complainModel[ComplaintIndex]?.notes ?? '',
                        textStyleEnum: TextStyleEnum.title,
                      ),
                      if (cubit.complainModel[ComplaintIndex]?.replies
                              ?.isNotEmpty ??
                          false)
                        CustomText(
                          cubit.complainModel[ComplaintIndex]?.replies?.first
                                  .reply ??
                              '',
                          textStyleEnum: TextStyleEnum.title,
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

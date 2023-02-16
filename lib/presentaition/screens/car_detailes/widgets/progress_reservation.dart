import 'package:flutter/material.dart';
import 'package:supa_kota/core/utiles/responsive.dart';

import '../../../../core/themes/colors.dart';
import '../../../components/custom_text.dart';
import '../../../components/network_image.dart';
import '../cubit/car_details_cubit.dart';

class ProgressReservation extends StatelessWidget {
  const ProgressReservation({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final CarDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // runSpacing: 0.0,
      runAlignment: WrapAlignment.end,
      crossAxisAlignment: WrapCrossAlignment.end,
      direction: Axis.horizontal,
      children: List.generate(
          cubit.oneReservations?.progress?.length ?? 0,
          (progresIndex) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: progresIndex != 0
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            cubit.changeIndexProgress(progresIndex);
                          },
                          child: Row(
                            children: [
                              if (progresIndex != 0)
                                SizedBox(
                                    width: 17.w,
                                    child: Divider(
                                      thickness: 1,
                                      color: (cubit
                                                  .oneReservations
                                                  ?.progress?[progresIndex]
                                                  .status ==
                                              'finished')
                                          ? AppColors.greenDone
                                          : AppColors.primiry,
                                    )),
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  // if (widget.progress?[progresIndex]
                                  //         .status ==
                                  //     'finished')
                                  CircleAvatar(
                                    child: Container(
                                        child: Icon(
                                      Icons.check_circle_outline_outlined,
                                      color: AppColors.green,
                                    )),
                                    radius: 22,
                                    backgroundColor: cubit
                                                .oneReservations
                                                ?.progress?[progresIndex]
                                                .status ==
                                            'finished'
                                        ? AppColors.greenDone.withOpacity(1)
                                        : AppColors.primiry.withOpacity(1),
                                  ),
                                  Container(
                                    width: 41,
                                    height: 41,
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        shape: BoxShape.circle
                                        // image: DecorationImage(
                                        //     image: NetworkImagesWidgets(
                                        //         widget
                                        //                 .progress?[
                                        //                     progresIndex]
                                        //                 .icon ??
                                        //             ''))

                                        ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: NetworkImagesWidgets(
                                        cubit
                                                .oneReservations
                                                ?.progress?[progresIndex]
                                                .icon ??
                                            '',
                                        width: 20,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),

                                  if (cubit.oneReservations
                                          ?.progress?[progresIndex].status ==
                                      'finished')
                                    Icon(
                                      Icons.check_circle_outline_rounded,
                                      color: AppColors.greenDone,
                                    )
                                ],
                              ),
                              if (progresIndex + 1 !=
                                  cubit.oneReservations?.progress?.length)
                                SizedBox(
                                    width: 17.w,
                                    child: Divider(
                                      thickness: 1,
                                      color: (cubit
                                                  .oneReservations
                                                  ?.progress?[progresIndex]
                                                  .status ==
                                              'finished')
                                          ? AppColors.greenDone
                                          : AppColors.primiry,
                                    ))
                            ],
                          ),
                        ),
                        Center(
                          child: CustomText(
                            cubit.oneReservations?.progress?[progresIndex]
                                    .name ??
                                '',
                            color: cubit.oneReservations
                                        ?.progress?[progresIndex].status ==
                                    'finished'
                                ? AppColors.greenDone
                                : AppColors.primiry,
                            fontsize: 12.fs,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ],
                    ),
                    // if (progresIndex + 1 !=
                    //     widget.progress?.length)
                    //   SizedBox(
                    //       width: 25,
                    //       child: Divider(
                    //         thickness: 1,
                    //         color: (widget
                    //                     .progress?[progresIndex]
                    //                     .status ==
                    //                 'finished')
                    //             ? AppColors.green
                    //             : AppColors.primiry,
                    //       ))
                  ],
                ),
              )),
    );
  }
}

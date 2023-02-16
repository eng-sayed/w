import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:supa_kota/core/utiles/responsive.dart';
import 'package:supa_kota/presentaition/components/network_image.dart';

import '../../../../core/themes/colors.dart';
import '../../../../domain/models/reservations_model.dart';
import '../../../components/custom_text.dart';
import '../../../components/shimer_loading_items.dart';
import '../cubit/car_details_cubit.dart';
import 'dialog_car_parts.dart';

class StepperPrgress extends StatefulWidget {
  StepperPrgress({
    required this.cubit,
    this.reservationsIndex,
    required this.isFinishedList,
    required this.progress,
    required this.shown,
  });

  final CarDetailsCubit cubit;
  final int? reservationsIndex;
  final List<Progress>? progress;
  bool isFinishedList = false;
  bool shown = false;

  @override
  State<StepperPrgress> createState() => _StepperPrgressState();
}

class _StepperPrgressState extends State<StepperPrgress> {
  int? index = 0;

  List<int> indexsss = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarDetailsCubit, CarDetailsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        indexsss = widget.isFinishedList
            ? widget.cubit.finishedIndexs
            : widget.cubit.progressIndexs;
        return SizedBox(
          // height: ,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                // height: 115,
                width: double.infinity,
                child: Column(
                  children: [
                    Wrap(
                      // runSpacing: 0.0,
                      // runAlignment: WrapAlignment.end,
                      // crossAxisAlignment: WrapCrossAlignment.end,
                      // direction: Axis.horizontal,

                      children: List.generate(
                          widget.progress?.length ?? 0,
                          (progresIndex) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
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
                                            print(progresIndex);
                                            print(widget.reservationsIndex);
                                            print(indexsss);
                                            index = widget.reservationsIndex;
                                            setState(() {});
                                            widget.cubit.changeIndex(
                                                progresIndex,
                                                widget.reservationsIndex,
                                                isFinishedList:
                                                    widget.isFinishedList);
                                          },
                                          child: Row(
                                            children: [
                                              if (progresIndex != 0)
                                                SizedBox(
                                                    width: 18.w,
                                                    child: Divider(
                                                      thickness: 1,
                                                      color: (widget
                                                                  .progress?[
                                                                      progresIndex]
                                                                  .status ==
                                                              'finished')
                                                          ? AppColors.greenDone
                                                          : AppColors.primiry,
                                                    )),
                                              Stack(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                children: [
                                                  // if (widget.progress?[progresIndex]
                                                  //         .status ==
                                                  //     'finished')
                                                  CircleAvatar(
                                                    child: Container(
                                                        child: Icon(
                                                      Icons
                                                          .check_circle_outline_outlined,
                                                      color: AppColors.green,
                                                    )),
                                                    radius: 22,
                                                    backgroundColor: widget
                                                                .progress?[
                                                                    progresIndex]
                                                                .status ==
                                                            'finished'
                                                        ? AppColors.greenDone
                                                            .withOpacity(1)
                                                        : AppColors.primiry
                                                            .withOpacity(1),
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
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child:
                                                          NetworkImagesWidgets(
                                                        widget
                                                                .progress?[
                                                                    progresIndex]
                                                                .icon ??
                                                            '',
                                                        width: 20,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  // CircleAvatar(
                                                  //   backgroundImage: Image.network(
                                                  //     widget.progress?[progresIndex]
                                                  //             .icon ??
                                                  //         '',
                                                  //     loadingBuilder: (context,
                                                  //         child, loadingProgress) {
                                                  //       return LoadingImage(
                                                  //           w: 20, h: 20);
                                                  //     },
                                                  //   ).image,
                                                  //   radius: 20,
                                                  //   backgroundColor: Colors.green,
                                                  // ),
                                                  if (widget
                                                          .progress?[
                                                              progresIndex]
                                                          .status ==
                                                      'finished')
                                                    Icon(
                                                      Icons
                                                          .check_circle_outline_rounded,
                                                      color:
                                                          AppColors.greenDone,
                                                    )
                                                ],
                                              ),
                                              if (progresIndex + 1 !=
                                                  widget.progress?.length)
                                                SizedBox(
                                                    width: 17.w,
                                                    child: Divider(
                                                      thickness: 1,
                                                      color: (widget
                                                                  .progress?[
                                                                      progresIndex]
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
                                            widget.progress?[progresIndex]
                                                    .name ??
                                                '',
                                            color: widget
                                                        .progress?[progresIndex]
                                                        .status ==
                                                    'finished'
                                                ? AppColors.greenDone
                                                : AppColors.primiry,
                                            fontsize: 13,
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
                    ),
                    if (widget.shown)
                      InkWell(
                        onTap: () {
                          if (widget.progress?[indexsss[index ?? 0]]
                                  .partsDetails?.isNotEmpty ??
                              false) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return DialogCarParts(
                                    progress: widget
                                            .progress?[indexsss[index ?? 0]] ??
                                        Progress(),
                                    cubit: widget.cubit,
                                    index: 0,
                                  );
                                });
                          }
                        },
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText('status'.tr()),
                                CustomText(widget
                                        .progress?[indexsss[index ?? 0]]
                                        .status ??
                                    ''),
                              ],
                            ),
                            // if (reservationsModel?.isNotEmpty ?? false)
                            Visibility(
                              visible: widget.progress?[indexsss[index ?? 0]]
                                      .generalNotes !=
                                  null,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText('Notes'.tr()),
                                  CustomText(widget
                                          .progress?[indexsss[index ?? 0]]
                                          .generalNotes ??
                                      ''),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                )),
          ),
        );
      },
    );
  }
}

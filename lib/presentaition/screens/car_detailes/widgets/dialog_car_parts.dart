import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supa_kota/core/utiles/responsive.dart';

import '../../../../core/themes/colors.dart';
import '../../../../domain/models/reservations_model.dart';
import '../../../components/custom_text.dart';
import '../../../components/direction.dart';
import '../../../components/network_image.dart';
import '../cubit/car_details_cubit.dart';

class DialogCarParts extends StatelessWidget {
  const DialogCarParts({
    Key? key,
    required this.cubit,
    required this.index,
    required this.progress,
  }) : super(key: key);

  final CarDetailsCubit cubit;
  final int index;
  final Progress progress;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Direction(
                child: SingleChildScrollView(
                    child: Container(
              height: 700,
              width: 400.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(progress.name ?? '',
                      color: AppColors.primiry,
                      textStyleEnum: TextStyleEnum.title),
                  Expanded(
                      child: ListView.builder(
                    itemCount: progress.partsDetails?.length,
                    itemBuilder: (context, i) {
                      return Direction(
                          child: Visibility(
                        visible:
                            ((progress.partsDetails?[i].gallery?.isNotEmpty ??
                                    false) ||
                                progress.partsDetails?[i].notes != null),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  NetworkImagesWidgets(
                                    progress.partsDetails?[i].image ?? '',
                                    width: 50,
                                    height: 50,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomText(
                                      progress.partsDetails?[i].name ?? '')
                                ],
                              ),
                            ),
                            Visibility(
                              visible: progress.partsDetails?[i].notes != null,
                              child: CustomText(
                                'Notes'.tr(),
                                color: AppColors.primiry,
                                textStyleEnum: TextStyleEnum.title,
                                fontsize: 20,
                              ),
                            ),
                            CustomText(
                              progress.partsDetails?[i].notes ?? '',
                              textStyleEnum: TextStyleEnum.normal,
                              fontsize: 18,
                            ),
                            Visibility(
                              visible: progress
                                      .partsDetails?[i].gallery?.isNotEmpty ??
                                  false,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: CarouselSlider(
                                      options: CarouselOptions(
                                        height: 250,
                                        autoPlay: true,
                                        viewportFraction: 1,
                                        enableInfiniteScroll: false,
                                        aspectRatio: 1.5,
                                        enlargeCenterPage: true,
                                        enlargeStrategy:
                                            CenterPageEnlargeStrategy.scale,
                                      ),
                                      items: List.generate(
                                        progress.partsDetails?[i].gallery
                                                ?.length ??
                                            0,
                                        (imageIndex) => NetworkImagesWidgets(
                                          progress.partsDetails?[i]
                                                  .gallery?[imageIndex] ??
                                              '',
                                          height: 312,
                                          width: 820,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: ((progress.partsDetails?.indexOf(
                                              progress.partsDetails?[i] ??
                                                  PartsDetails()) ??
                                          0) +
                                      1) !=
                                  progress.partsDetails?.length,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 350,
                                    child: Divider(color: AppColors.primiry),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ));
                    },
                  ))
                ],
              ),
            )))));
  }
}

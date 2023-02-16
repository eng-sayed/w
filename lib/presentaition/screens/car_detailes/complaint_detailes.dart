import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:supa_kota/core/utiles/utiles.dart';
import 'package:supa_kota/presentaition/components/background_image.dart';

import '../../../core/themes/colors.dart';
import '../../../domain/models/complains_model.dart';
import '../../components/custom_text.dart';
import '../../components/default_app_bar.dart';
import '../../components/direction.dart';
import '../../components/network_image.dart';
import 'cubit/car_details_cubit.dart';

class ComplaintsDetailes extends StatelessWidget {
  ComplaintsDetailes({
    super.key,
    required this.cubit,
    required this.complainModel,
  });
  final CarDetailsCubit cubit;
  final ComplainModel complainModel;

  @override
  Widget build(BuildContext context) {
    print(complainModel.id);
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
                padding: const EdgeInsets.only(top: 53, left: 30, right: 30),
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
            child: Direction(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        'Complaint Reason'.tr(),
                        textStyleEnum: TextStyleEnum.title,
                        fontsize: 26,
                        color: AppColors.primiry,
                      ),
                      Column(
                        children: [
                          CustomText(
                            complainModel.notes ?? '',
                            textStyleEnum: TextStyleEnum.title,
                            fontsize: 22,
                          ),
                          SizedBox(
                            width: 400,
                            child: Divider(color: AppColors.primiry),
                          )
                        ],
                      ),
                      if (complainModel.replies?.isNotEmpty ?? false)
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  height: 250,
                                  autoPlay: false,
                                  viewportFraction: 1,
                                  enableInfiniteScroll: false,
                                  aspectRatio: 1.5,
                                  enlargeCenterPage: true,
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.scale,
                                ),
                                items: List.generate(
                                  complainModel.images?.length ?? 0,
                                  (index) => NetworkImagesWidgets(
                                    complainModel.images?[index] ?? '',
                                    height: 312,
                                    width: 820,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      if (complainModel.replies?.isNotEmpty ?? false)
                        CustomText(
                          'Replay'.tr(),
                          textStyleEnum: TextStyleEnum.title,
                          fontsize: 26,
                          color: AppColors.primiry,
                        ),
                      if (complainModel.replies?.isNotEmpty ?? false)
                        ListView.builder(
                          padding: EdgeInsets.all(5),
                          itemCount: complainModel.replies?.length ?? 0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Direction(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: CustomText(
                                      complainModel.replies?[index].reply ?? '',
                                      textStyleEnum: TextStyleEnum.title,
                                      fontsize: 22,
                                      color: AppColors.black,
                                    ),
                                    trailing: CustomText(
                                      complainModel.replies?[index].createdAt!
                                              .parseDateTime() ??
                                          '',
                                      textStyleEnum: TextStyleEnum.title,
                                      fontsize: 12,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    width: (((index) + 1) ==
                                            complainModel.replies?.length)
                                        ? 600
                                        : 400,
                                    child: Divider(color: AppColors.primiry),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}

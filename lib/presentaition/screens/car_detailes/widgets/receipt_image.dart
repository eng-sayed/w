import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/navigate.dart';
import '../../../components/custom_text.dart';
import '../../../components/network_image.dart';
import '../../gallery/widget/image_fullscreen.dart';
import '../cubit/car_details_cubit.dart';

class ReceiptImage extends StatelessWidget {
  const ReceiptImage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final CarDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            CustomText(
              'receipt_image'.tr(),
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
                  image: cubit.oneReservations?.receipt_image ?? '',
                ));
          },
          child: NetworkImagesWidgets(
            cubit.oneReservations?.receipt_image ?? '',
            height: 260,
            width: 350,
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}

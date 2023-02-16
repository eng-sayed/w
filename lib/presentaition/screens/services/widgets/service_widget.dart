import 'package:flutter/material.dart';
import 'package:widget_mask/widget_mask.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/navigate.dart';
import '../../../components/custom_text.dart';
import '../cubit/services_cubit.dart';
import '../services_details.dart';

class ServiceWidget extends StatelessWidget {
  const ServiceWidget({
    Key? key,
    required this.servicesCubit,
    required this.index,
  }) : super(key: key);

  final ServicesCubit servicesCubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigate(
            context: context,
            route: ServicesDetails(
              id: servicesCubit.services[index].id ?? 0,
            ));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/protect.png',
                fit: BoxFit.fill,
                width: 165, //453
                height: 180,
                color: AppColors.primiry,
              ),
              Image.asset(
                'assets/images/protect.png',
                fit: BoxFit.fill,
                width: 160,
                height: 174,
                color: AppColors.white,
              ),
              WidgetMask(
                blendMode: BlendMode.srcATop,
                childSaveLayer: true,
                mask: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      servicesCubit.services[index].image!,
                      fit: BoxFit.fill,
                      width: 150,
                      height: 163,
                      filterQuality: FilterQuality.low,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;

                        return Container(
                          color: AppColors.grey,
                        );
                      },
                      errorBuilder: ((context, error, stackTrace) =>
                          Image.asset(
                            'assets/images/logo2.png',
                            fit: BoxFit.cover,
                          )),
                    ),
                    Container(
                      color: AppColors.primiry.withOpacity(.3),
                    )
                  ],
                ),
                child: Image.asset(
                  'assets/images/protect.png',
                  fit: BoxFit.contain,
                  width: 150,
                  height: 163,
                ),
              ),
            ],
          ),
          CustomText(
            servicesCubit.services[index].name ?? '',
            fontsize: 18,
          ),
          CustomText(
            servicesCubit.services[index].shortDescription ?? '',
            align: TextAlign.center,
            maxLines: 2,
            color: AppColors.primiry,
            fontsize: 15,
          ),
          Icon(
            Icons.arrow_circle_right_rounded,
            size: 40,
            color: AppColors.primiry,
          )
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors.dart';
import '../../../components/custom_text.dart';
import '../cubit/services_cubit.dart';

class DeliveryCheck extends StatelessWidget {
  DeliveryCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = ServicesCubit.get(context);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          child: GestureDetector(
            onTap: () {
              cubit.switchDelivery();
            },
            child: Container(
              height: 50,
              child: Center(
                child: Card(
                  color: cubit.delivery
                      ? AppColors.primiry.withOpacity(.2)
                      : AppColors.lightGrey.withOpacity(1),
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      'delivery'.tr(),
                      color:
                          cubit.delivery ? AppColors.white : AppColors.primiry,
                      // textStyleEnum: TextStyleEnum.title,
                      // fontsize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

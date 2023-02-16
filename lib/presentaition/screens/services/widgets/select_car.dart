import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_kota/core/utiles/navigate.dart';
import 'package:supa_kota/presentaition/components/direction.dart';
import 'package:supa_kota/presentaition/screens/cart/cart.dart';

import '../../../../core/themes/colors.dart';
import '../../../components/custom_text.dart';
import '../cubit/services_cubit.dart';

class SelectCarDialog extends StatelessWidget {
  const SelectCarDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = ServicesCubit.get(context);
        return Dialog(
            child: Container(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Direction(
                  child: Container(
                height: 400,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomText(
                        'SelectCar'.tr(),
                        color: AppColors.black,
                        fontsize: 18,
                      ),
                      SizedBox(
                        height: 18,
                        width: 200,
                        child: Divider(
                          color: AppColors.black,
                        ),
                      ),
                      Center(
                          child: Wrap(
                        children: List.generate(
                            cubit.myCars.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      navigate(
                                          context: context,
                                          route: CartScreen(
                                              carId:
                                                  cubit.myCars[index].id ?? 0));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border:
                                            Border.all(color: AppColors.black),
                                        color: AppColors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CustomText(
                                          "${cubit.myCars[index].brand?.name ?? ''} ${cubit.myCars[index].model?.name ?? ''} ${cubit.myCars[index].notes ?? ''} ${cubit.myCars[index].year ?? ''}",
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                      )),
                    ],
                  ),
                ),
              ))),
        ));
      },
    );
  }
}

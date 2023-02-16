import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_kota/presentaition/screens/on_boarding/cubit/on_boarding_cubit.dart';

import '../../../../core/themes/colors.dart';

class Dots extends StatefulWidget {
  Dots({super.key, required this.index});
  int? index;
  @override
  State<Dots> createState() => _DotsState();
}

class _DotsState extends State<Dots> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = OnBoardingCubit.get(context);

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              color: cubit.currentPage == widget.index
                  ? AppColors.primiry
                  : AppColors.grey,
            ),
            margin: const EdgeInsets.only(right: 5),
            height: 10,
            curve: Curves.easeIn,
            width: 10,
          );
        });
  }
}

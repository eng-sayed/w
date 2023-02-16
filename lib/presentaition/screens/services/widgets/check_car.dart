import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors.dart';
import '../../../../domain/models/my_cars_model.dart';
import '../../../components/custom_text.dart';
import '../cubit/services_cubit.dart';

class CheckBoxCar extends StatefulWidget {
  CheckBoxCar({super.key, required this.car});
  MyCarsModel car;
  @override
  State<CheckBoxCar> createState() => _CheckBoxCarState();
}

class _CheckBoxCarState extends State<CheckBoxCar> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = ServicesCubit.get(context);
          var isSelected = cubit.mainReservation.carId == widget.car.id;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: GestureDetector(
              onTap: () {
                cubit.selectcar(widget.car);
              },
              child: Card(
                color: isSelected
                    ? AppColors.primiry.withOpacity(.2)
                    : AppColors.lightGrey.withOpacity(1),
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                      '${widget.car.brand?.name} ${widget.car.model?.name} ${widget.car.year ?? ''} '),
                ),
              ),
            ),
          );
        });
  }
}

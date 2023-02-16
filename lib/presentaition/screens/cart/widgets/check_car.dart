import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors.dart';
import '../../../../domain/models/my_cars_model.dart';
import '../../../components/custom_text.dart';
import '../cubit/cart_cubit.dart';

class CheckBoxCar extends StatefulWidget {
  CheckBoxCar({super.key, required this.car});
  MyCarsModel car;
  @override
  State<CheckBoxCar> createState() => _CheckBoxCarState();
}

class _CheckBoxCarState extends State<CheckBoxCar> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = CartCubit.get(context);
          var isSelected = cubit.mainReservation.carId == widget.car.id;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: GestureDetector(
              onTap: () {
                cubit.selectcar(widget.car);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      '${widget.car.model?.name}  ${widget.car.brand?.name}'),
                  Checkbox(
                    checkColor: AppColors.primiry,
                    // fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isSelected ? true : false,
                    shape: CircleBorder(),
                    onChanged: (bool? value) {
                      print(value);
                      cubit.selectcar(widget.car);
                      // cubit.maintenanceModel.branchId = widget.branch.id;
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}

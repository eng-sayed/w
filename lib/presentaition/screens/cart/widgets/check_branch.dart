import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors.dart';
import '../../../../domain/models/branches_model.dart';
import '../../../components/custom_text.dart';
import '../cubit/cart_cubit.dart';

class CheckBoxBranch extends StatefulWidget {
  CheckBoxBranch({super.key, required this.branch});
  BranchesDropDownModel branch;
  @override
  State<CheckBoxBranch> createState() => _CheckBoxBranchState();
}

class _CheckBoxBranchState extends State<CheckBoxBranch> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = CartCubit.get(context);
          var isSelected = cubit.mainReservation.branchId == widget.branch.id;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: GestureDetector(
              onTap: () {
                cubit.selectBranch(widget.branch);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(widget.branch.name ?? ''),
                  // CustomText(widget.branch.name ?? ''),
                  Checkbox(
                    checkColor: AppColors.primiry,
                    // fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isSelected ? true : false,
                    shape: CircleBorder(),
                    onChanged: (bool? value) {
                      cubit.selectBranch(widget.branch);
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

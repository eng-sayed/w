import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors.dart';
import '../../../../domain/models/branche_of_country_model.dart';
import '../../../../domain/models/branches_model.dart';
import '../../../components/custom_text.dart';
import '../cubit/services_cubit.dart';

class CheckBoxBranch extends StatefulWidget {
  CheckBoxBranch({
    super.key,
    required this.branch,
    required this.index,
  });
  BranchesOfCountriesModel branch;
  int index;
  @override
  State<CheckBoxBranch> createState() => _CheckBoxBranchState();
}

class _CheckBoxBranchState extends State<CheckBoxBranch> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = ServicesCubit.get(context);
          var isSelected = cubit.mainReservation.branchId == widget.branch.id;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            child: GestureDetector(
              onTap: () {
                cubit.selectBranch(widget.branch, widget.index);
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
                    child: CustomText(widget.branch.name ?? ''),
                  )),
            ),
          );
        });
  }
}

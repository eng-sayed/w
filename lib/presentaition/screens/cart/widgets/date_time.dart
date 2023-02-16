import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:supa_kota/presentaition/screens/services/cubit/services_cubit.dart';

import '../../../../core/themes/colors.dart';
import '../../../components/custom_text.dart';
import '../cubit/cart_cubit.dart';

class DateItem extends StatefulWidget {
  DateItem({
    Key? key,
    required this.dateTime,
  }) : super(key: key);
  final DateTime dateTime;
  @override
  State<DateItem> createState() => _DateItemState();
}

class _DateItemState extends State<DateItem> {
  var formatter = DateFormat(
    'MMM,E,d',
  );

  late List<String> splitedDate;
  @override
  void initState() {
    var date = formatter.format(widget.dateTime);
    splitedDate = date.split(",");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = CartCubit.get(context);
    var isSelected = cubit.selectedDate.day.toString() +
            cubit.selectedDate.month.toString() ==
        widget.dateTime.day.toString() + widget.dateTime.month.toString();
    return SizedBox(
      width: 80.0,
      height: 90.0,
      child: Card(
        color: isSelected ? AppColors.primiry : AppColors.white,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () {
            cubit.selectDate(context, widget.dateTime);
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomText(
                  splitedDate[0],
                  fontsize: 12,
                  weight: FontWeight.w400,
                  color: isSelected ? AppColors.white : AppColors.black,
                ),
                SizedBox(
                  height: 5,
                ),
                CustomText(
                  splitedDate[2],
                  textStyleEnum: TextStyleEnum.title,
                  color: isSelected ? AppColors.white : AppColors.primiry,
                  fontsize: 18,
                  weight: FontWeight.bold,
                ),
                CustomText(
                  splitedDate[1],
                  color: isSelected ? AppColors.white : AppColors.black,
                  fontsize: 12,
                  weight: FontWeight.bold,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

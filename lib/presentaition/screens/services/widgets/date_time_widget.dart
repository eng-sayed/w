import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:supa_kota/presentaition/screens/services/cubit/services_cubit.dart';

import '../../../../core/themes/colors.dart';
import '../../../components/custom_text.dart';

class DateItem extends StatefulWidget {
  DateItem({
    Key? key,
    required this.dateTime,
    required this.context,
  }) : super(key: key);
  final DateTime dateTime;
  BuildContext context;
  @override
  State<DateItem> createState() => _DateItemState();
}

class _DateItemState extends State<DateItem> {
  var formatter;

  late List<String> splitedDate;
  @override
  void initState() {
    formatter = DateFormat(
        'MMM,EE,dd', widget.context.locale == Locale('en', 'US') ? 'en' : 'ar');
    var date = formatter.format(widget.dateTime);
    splitedDate = date.split(",");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ServicesCubit.get(context);
    var isSelected = cubit.selectedDate.day.toString() +
            cubit.selectedDate.month.toString() ==
        widget.dateTime.day.toString() + widget.dateTime.month.toString();
    return SizedBox(
      width: 80.0,
      child: Card(
        color: isSelected ? AppColors.primiry : AppColors.white,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () {
            cubit.selectDate(context, widget.dateTime);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomText(
                splitedDate[1],
                color: isSelected ? AppColors.white : AppColors.black,
                fontsize: 12,
                weight: FontWeight.bold,
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
                splitedDate[0],
                fontsize: 12,
                weight: FontWeight.w400,
                color: isSelected ? AppColors.white : AppColors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

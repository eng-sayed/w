import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../components/custom_text.dart';

class CommuicationWidget extends StatelessWidget {
  CommuicationWidget(
      {Key? key,
      required this.color,
      this.icon,
      required this.num,
      required this.size,
      this.mainAxisAlignment,
      required this.colorIcon})
      : super(key: key);
  String num;
  IconData? icon;
  Color color, colorIcon;
  double size;
  MainAxisAlignment? mainAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      children: [
        Icon(
          icon ?? Icons.phone,
          color: colorIcon,
          size: 20,
        ),
        SizedBox(
          width: 5,
        ),
        CustomText(
          num,
          color: color,
          fontsize: size,
        ),
      ],
    );
  }
}

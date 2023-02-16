import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

class Direction extends StatefulWidget {
  Direction({super.key, required this.child});
  Widget child;

  @override
  State<Direction> createState() => _DirectionState();
}

class _DirectionState extends State<Direction> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.locale == Locale('en', 'US')
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: widget.child,
    );
  }
}

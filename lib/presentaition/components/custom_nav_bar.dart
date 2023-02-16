import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:flutter/material.dart';
import 'package:supa_kota/core/utiles/navigate.dart';

import '../../core/themes/colors.dart';
import '../layout/layout.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomBarBubble(
      items: List.of([
        BottomBarItem(
            iconBuilder: (color) => Image.asset(
                  'assets/images/0.png',
                  height: 30,
                  width: 30,
                )),
        BottomBarItem(
            iconBuilder: (color) =>
                Image.asset('assets/images/1.png', height: 30, width: 30)),
        BottomBarItem(
            iconBuilder: (color) =>
                Image.asset('assets/images/2.png', height: 30, width: 30)),
        BottomBarItem(
            iconBuilder: (color) =>
                Image.asset('assets/images/3.png', height: 30, width: 30)),
        BottomBarItem(
            iconBuilder: (color) =>
                Image.asset('assets/images/4.png', height: 30, width: 30)),
      ]),
      selectedIndex: 2,
      color: AppColors.primiry,
      onSelect: (int? selectedPos) {
        navigateReplacement(
            context: context,
            route: HomeLayout(
              index: selectedPos,
            ));
      },
    );
  }
}

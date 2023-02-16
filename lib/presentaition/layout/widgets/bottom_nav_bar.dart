import 'package:bottom_bar_matu/bottom_bar_matu.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/themes/colors.dart';
import '../../components/custom_text.dart';
import '../cubit/layout_cubit.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar(this.cubit);
  final LayoutCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BottomBarBubble(
      items: cubit.tabItems,
      selectedIndex: cubit.tabController.index,
      color: Colors.transparent,
      onSelect: (int? selectedPos) {
        cubit.changeTab(selectedPos!);
      },
    );
  }

//   Widget navBarItem(IconData icon, String title, {VoidCallback? ontap}) {
//     return Expanded(
//       child: InkWell(
//         onTap: ontap,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Icon(
//                 icon,
//                 color: AppColors.white,
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               CustomText(title.tr(),
//                   textStyleEnum: TextStyleEnum.normal, color: Colors.white),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
}

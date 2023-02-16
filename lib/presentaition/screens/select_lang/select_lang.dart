// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:supa_kota/presentaition/components/background_image.dart';
// import 'package:supa_kota/presentaition/components/custom_text.dart';

// import '../../../core/themes/colors.dart';
// import '../../../core/utiles/navigate.dart';
// import '../../components/default_button.dart';
// import '../auth/auth_screen.dart';

// class SelectLanguage extends StatelessWidget {
//   const SelectLanguage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Background(
//       child: Scaffold(
//         body: Center(
//           child: Column(
//             // mainAxisSize: MainAxisSize.max,
//             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 height: 100,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: AppColors.primiry,
//                   borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(50),
//                       bottomRight: Radius.circular(50)),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 30, right: 30),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CustomText(
//                         'selectLng'.tr(),
//                         textStyleEnum: TextStyleEnum.title,
//                         color: AppColors.white,
//                         fontsize: 26,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Spacer(),
//               Column(
//                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Spacer(),
//                   defaultButton(
//                       textColor: context.locale == Locale('en', 'US')
//                           ? AppColors.white
//                           : AppColors.primiry,
//                       radius: 40,
//                       height: 300,
//                       color: context.locale == Locale('en', 'US')
//                           ? AppColors.primiry
//                           : AppColors.white,
//                       width: 300,
//                       text: 'En',
//                       fontSize: 40,
//                       function: () {
//                         context.setLocale(Locale('en', 'US'));
//                         navigateReplacement(
//                             context: context, route: AuthScreen());
//                       }),
//                   defaultButton(
//                       textColor: context.locale == Locale('ar', 'EG')
//                           ? AppColors.white
//                           : AppColors.primiry,
//                       radius: 40,
//                       height: 300,
//                       color: context.locale == Locale('ar', 'EG')
//                           ? AppColors.primiry
//                           : AppColors.white,
//                       width: 300,
//                       text: 'ع',
//                       fontSize: 40,
//                       function: () {
//                         context.setLocale(Locale('ar', 'EG'));
//                         navigateReplacement(
//                             context: context, route: AuthScreen());
//                       }),
//                 ],
//               ),
//               Spacer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

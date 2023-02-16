// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';

// import '../../../core/themes/colors.dart';
// import '../../../core/utiles/navigate.dart';
// import '../../../core/utiles/validation.dart';
// import '../../components/background_image.dart';
// import '../../components/custom_text.dart';
// import '../../components/default_app_bar.dart';
// import '../../components/default_button.dart';
// import '../../components/default_text_field.dart';
// import 'otp_pin.dart';

// class ForgetPassword extends StatelessWidget {
//   const ForgetPassword({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Background(
//       child: Scaffold(
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 DefaultAppBar(
//                   icon: 'forget password',
//                   title: 'Forget Password'.tr(),
//                   // desc: 'Best car you can see here',
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: Icon(
//                             Icons.arrow_back_ios,
//                             color: AppColors.white,
//                           )),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   CustomText(
//                     'our Protect CarsPlease Enter Your Email Address To Receive a Verification Code'
//                         .tr(),
//                     fontsize: 20,
//                     align: TextAlign.center,
//                     textStyleEnum: TextStyleEnum.title,
//                   ),
//                   SizedBox(
//                     height: 70,
//                   ),
//                   LoginTextField(
//                     hintText: 'Email'.tr(),
//                     keyboardType: TextInputType.phone,
//                     validate: Validation().emailValidation,
//                     prefix: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       child: Image.asset(
//                         'assets/images/gmail.png',
//                         width: 15,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 70,
//                   ),
//                   defaultButton(
//                     radius: 30,
//                     color: AppColors.primiry,
//                     width: 147,
//                     text: 'Send'.tr(),
//                     fontSize: 18,
//                     function: () {
//                       navigate(context: context, route: OTPPin());
//                       // _controller.nextPage(
//                       //   duration: const Duration(milliseconds: 200),
//                       //   curve: Curves.easeIn,
//                       // );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

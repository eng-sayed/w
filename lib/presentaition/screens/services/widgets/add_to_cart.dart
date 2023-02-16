// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../core/themes/colors.dart';
// import '../../../../core/utiles/alerts.dart';
// import '../../../components/custom_text.dart';
// import '../../../components/default_button.dart';
// import '../cubit/services_cubit.dart';
// import 'dialog_request.dart';

// class AddToCart extends StatefulWidget {
//   const AddToCart({super.key});

//   @override
//   State<AddToCart> createState() => _AddToCartState();
// }

// class _AddToCartState extends State<AddToCart> {
//   @override
//   void initState() {
//     final cubit = ServicesCubit.get(context);
//     cubit.addServiceToCart();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ServicesCubit, ServicesState>(
//         listener: (context, state) {},
//         builder: (context, statee) {
//           final cubit = ServicesCubit.get(context);
//           return SingleChildScrollView(
//             child: Container(
//               decoration: BoxDecoration(
//                   color: AppColors.white,
//                   borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(20.0),
//                       topRight: Radius.circular(20.0))),
//               height: 200,
//               child: Center(
//                   child: AnimatedCrossFade(
//                 duration: const Duration(milliseconds: 300),
//                 firstChild: ListTile(
//                   title: CustomText(
//                     "addedOneServices".tr(),
//                     textStyleEnum: TextStyleEnum.title,
//                   ),
//                   subtitle: GestureDetector(
//                     onTap: () {
//                       cubit.toggleChilds(false);
//                     },
//                     child: Row(
//                       children: [
//                         Text('ShowServices'.tr()),
//                         Icon(
//                           Icons.arrow_drop_down_outlined,
//                           color: AppColors.primiry,
//                         )
//                       ],
//                     ),
//                   ),
//                   trailing: defaultButton(
//                       function: () {
//                         Navigator.pop(context);
//                         // OverLays.snack(
//                         //     text: "serviceAddesSucess".tr(),
//                         //     state: SnakState.success);
//                         // Navigator.pop(context);
//                         // showDialog(
//                         //     context: context,
//                         //     builder: (BuildContext context) {
//                         //       final date = DateTime.now();
//                         //       return DialogItem(date: date);
//                         //     });
//                       },
//                       text: 'Continue'.tr(),
//                       color: AppColors.primiry,
//                       textColor: AppColors.white,
//                       height: 50,
//                       width: 120,
//                       weight: FontWeight.normal,
//                       radius: 20),
//                 ),
//                 secondChild: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: CustomText(
//                             'Services'.tr(),
//                             textStyleEnum: TextStyleEnum.title,
//                           ),
//                         ),
//                         SizedBox(
//                           child: Divider(color: AppColors.primiry),
//                           width: double.infinity,
//                         ),
//                         ListView.builder(
//                             physics: NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             itemCount: cubit.allSavedServices.length,
//                             itemBuilder: (context, i) {
//                               return ListTile(
//                                   title: CustomText(
//                                       cubit.allSavedServices[i].name ?? ''),
//                                   subtitle: ListView.builder(
//                                       physics: NeverScrollableScrollPhysics(),
//                                       shrinkWrap: true,
//                                       itemCount: cubit.allSavedServices[i]
//                                           .subServices?.length,
//                                       itemBuilder: (context, index) {
//                                         return CustomText(
//                                           cubit.allSavedServices[i]
//                                                   .subServices?[index].name ??
//                                               '',
//                                           color: AppColors.primiry,
//                                           textStyleEnum: TextStyleEnum.normal,
//                                         );
//                                       }),
//                                   trailing: IconButton(
//                                     onPressed: () {
//                                       cubit.deleteServiceFromCart(i);
//                                       Navigator.pop(context);
//                                     },
//                                     icon: Icon(
//                                       Icons.delete,
//                                       color: AppColors.red,
//                                     ),
//                                   ));
//                             }),
//                         GestureDetector(
//                           onTap: () {
//                             cubit.toggleChilds(true);
//                           },
//                           child: Row(
//                             children: [
//                               CustomText('HideServices'.tr()),
//                               Icon(
//                                 Icons.arrow_drop_up_outlined,
//                                 color: AppColors.primiry,
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 crossFadeState: statee is ServicesSecChild?
//                     ? CrossFadeState.showSecond
//                     : CrossFadeState.showFirst,
//               )),
//             ),
//           );
//         });
//   }
// }

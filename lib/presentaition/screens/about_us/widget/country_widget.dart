import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/utiles.dart';
import '../../../components/custom_text.dart';
import '../../../components/default_button.dart';
import '../../../components/network_image.dart';
import '../cubit/about_us_cubit.dart';

class CountryWidget extends StatelessWidget {
  const CountryWidget({
    Key? key,
    required this.cubit,
    required this.index,
  }) : super(key: key);

  final AboutUsCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return MyButtonWIdget(
      width: 160,
      height: 50,
      color: Colors.grey[200],
      function: () async {
        final response = await cubit
            .getBranches(cubit.countries[index].id, context)
            .then((value) {
          if (value) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(32.0))),
                      child: Container(
                        height: 500,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: Directionality(
                                textDirection:
                                    context.locale == Locale('en', 'US')
                                        ? TextDirection.ltr
                                        : TextDirection.rtl,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          NetworkImagesWidgets(
                                            // 'assets/images/0.jpg',
                                            cubit.countries[index].flag ?? '',
                                            width: 50,
                                            height: 40,
                                            fit: BoxFit.fill,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          CustomText(
                                            cubit.countries[index].name ?? '',
                                            fontsize: 20,
                                            color: AppColors.black,
                                          )
                                        ],
                                      ),
                                    ),
                                    CustomText(
                                      'Address',
                                      fontsize: 22,
                                      weight: FontWeight.w500,
                                      color: AppColors.primiry,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: cubit.branches.length,
                                        itemBuilder: (context, i) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  CustomText(
                                                    cubit.branches[i].name ??
                                                        '',
                                                    fontsize: 18,
                                                    weight: FontWeight.w700,
                                                    color: AppColors.black,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              CustomText(
                                                cubit.branches[i].address ?? '',
                                                color: AppColors.black,
                                                fontsize: 15,
                                                weight: FontWeight.normal,
                                                maxLines: 3,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  MyButtonWIdget(
                                                    width: 120,
                                                    height: 40,
                                                    color: Colors.grey[200],
                                                    function: () async {
                                                      if (await canLaunchUrl(
                                                          Uri.tryParse(cubit
                                                                  .branches[i]
                                                                  .location_url ??
                                                              '')!)) {
                                                        await launchUrl(
                                                            Uri.tryParse(cubit
                                                                    .branches[i]
                                                                    .location_url ??
                                                                '')!);
                                                      } else {
                                                        throw 'Could not launch ${cubit.branches[i].location_url}';
                                                      }
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/map.png',
                                                          width: 20,
                                                        ),
                                                        CustomText(
                                                          'getlocation'.tr(),
                                                          color:
                                                              AppColors.black,
                                                          fontsize: 15,
                                                          weight:
                                                              FontWeight.normal,
                                                          maxLines: 3,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: cubit.branches[i]
                                                            .phones !=
                                                        null,
                                                    child: MyButtonWIdget(
                                                        width: 125,
                                                        color: Colors.grey[200],
                                                        height: 40,
                                                        function: () {
                                                          Utiles.makeCall(cubit
                                                                  .branches[i]
                                                                  .phones ??
                                                              '');
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.phone,
                                                              color: AppColors
                                                                  .green,
                                                              size: 20,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            CustomText(
                                                              'callbranch'.tr(),
                                                              color: AppColors
                                                                  .black,
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              ),

                                              // SizedBox(
                                              //   height: 5,
                                              // ),
                                              SizedBox(
                                                width: double.infinity,
                                                child: Divider(
                                                    color: AppColors.primiry),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ))),
                      ));
                });
          } else {
            Fluttertoast.showToast(
                msg: 'nobranches'.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: AppColors.primiry,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: NetworkImagesWidgets(
              // 'assets/images/0.jpg',
              cubit.countries[index].flag ?? '',
              width: 25,
              height: 25,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          CustomText(
            cubit.countries[index].name ?? '',
            color: AppColors.black,
          )
        ],
      ),
    );
  }
}

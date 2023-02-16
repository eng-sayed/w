import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:readmore/readmore.dart';
import 'package:supa_kota/core/themes/colors.dart';
import 'package:supa_kota/core/utiles/responsive.dart';
import 'package:supa_kota/core/utiles/validation.dart';
import 'package:supa_kota/presentaition/components/background_image.dart';
import 'package:supa_kota/presentaition/components/custom_text.dart';
import 'package:supa_kota/presentaition/components/default_app_bar.dart';
import 'package:supa_kota/presentaition/components/direction.dart';
import 'package:widget_mask/widget_mask.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

import '../../../core/utiles/navigate.dart';
import '../../../core/utiles/utiles.dart';
import '../../components/custom_nav_bar.dart';
import '../../components/default_button.dart';
import '../../components/default_text_field.dart';
import '../../layout/widgets/bottom_nav_bar.dart';
import '../notification.dart/notification.dart';
import 'cubit/services_cubit.dart';
import 'widgets/add_to_cart.dart';
import 'widgets/appbar_service_detailes.dart';
import 'widgets/bottomnavbar_servoce_detailes.dart';
import 'widgets/communication_wiget.dart';
import 'widgets/description_services.dart';
import 'widgets/dialog_request.dart';
import 'widgets/offer_dialog.dart';
import 'widgets/review_widget_service_detailes.dart';

class ServicesDetails extends StatefulWidget {
  ServicesDetails({super.key, required this.id});

  int id;

  @override
  State<ServicesDetails> createState() => _ServicesDetailsState();
}

class _ServicesDetailsState extends State<ServicesDetails> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final servicesCubit = ServicesCubit.get(context);
      await servicesCubit.getServiceAndReviews(widget.id, context);
      servicesCubit.promoCode = null;
      servicesCubit.delivery = false;
    });
    super.initState();
  }

  String comment = '';

  double score = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: BlocConsumer<ServicesCubit, ServicesState>(
            listener: (context, state) {},
            builder: (context, state) {
              final servDetailsCubit = ServicesCubit.get(context);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarServiceDetailes(servDetailsCubit: servDetailsCubit),
                  SizedBox(
                    height: 18,
                  ),
                  Center(
                    child: CustomText(
                      servDetailsCubit.service.name ?? '',
                      textStyleEnum: TextStyleEnum.title,
                      fontsize: 28,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      child: Direction(
                        child: SingleChildScrollView(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: servDetailsCubit
                                      .service.description?.isNotEmpty ??
                                  false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    'Description'.tr(),
                                    textStyleEnum: TextStyleEnum.title,
                                    color: AppColors.primiry,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ReadMoreText(
                                    servDetailsCubit.service.description ?? '',
                                    trimLines: 2,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'readMore'.tr(),
                                    trimExpandedText: 'readLess'.tr(),
                                    moreStyle: TextStyle(
                                        fontSize: 15, color: AppColors.primiry),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: Divider(color: AppColors.primiry),
                                  height: 8,
                                  width: 350,
                                ),
                              ],
                            ),
                            Visibility(
                              visible: servDetailsCubit
                                      .service.subServices?.isNotEmpty ??
                                  false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    'srvceinclude'.tr(),
                                    textStyleEnum: TextStyleEnum.title,
                                    color: AppColors.primiry,
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(maxHeight: 200),
                                    child: ListView.builder(
                                        padding: EdgeInsets.all(5),
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: servDetailsCubit
                                            .service.subServices?.length,
                                        itemBuilder: (context, i) {
                                          return Row(
                                            children: [
                                              Icon(
                                                Icons.check,
                                                color: AppColors.yellow,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              CustomText(
                                                servDetailsCubit.service
                                                        .subServices?[i].name ??
                                                    '',
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: Divider(color: AppColors.primiry),
                                  height: 8,
                                  width: 350,
                                ),
                              ],
                            ),
                            Visibility(
                              visible: servDetailsCubit
                                      .service.subServices?.isNotEmpty ??
                                  false,
                              child: SizedBox(
                                height: 100,
                                width: double.infinity,
                                child: ListView.builder(
                                    itemCount: servDetailsCubit
                                        .service.subServices?.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 10),
                                        child: Container(
                                          width: 170,
                                          child: MyButton(
                                            function: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext contexts) {
                                                    return OfferDialog(
                                                      i: i,
                                                    );
                                                  });
                                            },
                                            text: servDetailsCubit.service
                                                    .subServices?[i].name ??
                                                '',
                                            color: i.isEven
                                                ? AppColors.secondary
                                                : AppColors.primiry,
                                            textColor: i.isEven
                                                ? AppColors.primiry
                                                : AppColors.secondary,
                                            // height: 80,
                                            // width: 100,
                                            weight: FontWeight.normal,
                                            fontSize: 17,
                                            radius: 20,
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            if (servDetailsCubit.reviewServices.isNotEmpty)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    child: Divider(color: AppColors.primiry),
                                    height: 8,
                                    width: 350,
                                  ),
                                ],
                              ),
                            if (servDetailsCubit.reviewServices.isNotEmpty)
                              CustomText(
                                'Reviews'.tr(),
                                textStyleEnum: TextStyleEnum.title,
                                color: AppColors.primiry,
                              ),
                            ListView.builder(
                                padding: EdgeInsets.all(5),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    servDetailsCubit.reviewServices.length,
                                itemBuilder: (context, i) {
                                  return ReviewWidgetServiceDetailes(
                                      servDetailsCubit: servDetailsCubit, i: i);
                                }),
                          ],
                        )),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
      bottomNavigationBar: BottomNavBarServiceDetailes(),
    );
  }
}

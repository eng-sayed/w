import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supa_kota/core/utiles/responsive.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/validation.dart';
import '../../../components/custom_text.dart';
import '../../../components/default_button.dart';
import '../../../components/default_text_field.dart';
import '../cubit/services_cubit.dart';
import 'dialog_request.dart';

class OfferDialog extends StatefulWidget {
  OfferDialog({super.key, required this.i});
  int i;
  @override
  State<OfferDialog> createState() => _OfferDialogState();
}

class _OfferDialogState extends State<OfferDialog> {
  final CurrencyTextInputFormatter _formatter =
      CurrencyTextInputFormatter(locale: 'en', decimalDigits: 3, symbol: '');
  final _formKey = GlobalKey<FormState>();
  String promocode = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final servDetailsCubit = ServicesCubit.get(context);
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Directionality(
            textDirection: context.locale == Locale('en', 'US')
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              //  height: 350,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 230.w,
                            child: CustomText(
                              servDetailsCubit
                                      .service.subServices?[widget.i].name ??
                                  '',
                              color: AppColors.primiry,
                              textStyleEnum: TextStyleEnum.title,
                            ),
                          ),
                          Visibility(
                            visible: servDetailsCubit
                                    .service.subServices?[widget.i].offer !=
                                null,
                            replacement: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Row(
                                children: [
                                  CustomText(
                                      '${_formatter.format(('${servDetailsCubit.service.subServices?[widget.i].price ?? 0}'))} ',
                                      color: AppColors.primiry,
                                      fontsize: 22),
                                  CustomText('EGP'.tr(),
                                      color: AppColors.primiry, fontsize: 22),
                                ],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                        '${_formatter.format('${servDetailsCubit.service.subServices?[widget.i].offer?.priceAfter ?? 0}')} ',
                                        color: AppColors.primiry,
                                        fontsize: 22),
                                    CustomText('EGP'.tr(),
                                        color: AppColors.primiry, fontsize: 22),
                                  ],
                                ),
                                Row(
                                  children: [
                                    CustomText(
                                      '${_formatter.format('${servDetailsCubit.service.subServices?[widget.i].offer?.priceBefore ?? 0}')} ',
                                      decoration: TextDecoration.lineThrough,
                                      fontsize: 18,
                                    ),
                                    CustomText(
                                      'EGP'.tr(),
                                      decoration: TextDecoration.lineThrough,
                                      fontsize: 18,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      CustomText(servDetailsCubit
                              .service.subServices?[widget.i].description ??
                          ""),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: (servDetailsCubit
                                    .service
                                    .subServices?[widget.i]
                                    .offer
                                    ?.gifts
                                    ?.isNotEmpty ??
                                false),
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/gift.png',
                                        width: 40,
                                      ),
                                      CustomText(
                                        'Gifts'.tr(),
                                        textStyleEnum: TextStyleEnum.title,
                                        color: AppColors.primiry,
                                        fontsize: 20,
                                      ),
                                    ],
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          MyButtonWIdget(
                                            function: () {
                                              null;
                                            },
                                            width: (servDetailsCubit
                                                        .service
                                                        .subServices?[widget.i]
                                                        .offer
                                                        ?.gifts?[index]
                                                        .length
                                                        .toDouble() ??
                                                    0.0) *
                                                10,
                                            height: 50,
                                            color: Colors.green,
                                            child: CustomText(
                                              servDetailsCubit
                                                      .service
                                                      .subServices?[widget.i]
                                                      .offer
                                                      ?.gifts?[index] ??
                                                  '',
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    itemCount: servDetailsCubit
                                            .service
                                            .subServices?[widget.i]
                                            .offer
                                            ?.gifts
                                            ?.length ??
                                        0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: servDetailsCubit
                                    .service.subServices?[widget.i].offer !=
                                null,
                            child: MyButtonWIdget(
                              function: () {
                                null;
                              },
                              width: 80,
                              color: Colors.green,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(
                                    "${(servDetailsCubit.service.subServices?[widget.i].offer?.percentage ?? 0)}%",
                                    fontsize: 18,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

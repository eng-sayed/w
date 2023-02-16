import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/themes/colors.dart';
import '../../../../domain/models/services_model.dart';
import '../../../components/custom_text.dart';
import '../../../components/default_button.dart';
import '../../../components/direction.dart';
import '../../services/cubit/services_cubit.dart';

class SubServiceWidget extends StatefulWidget {
  const SubServiceWidget({
    Key? key,
    required this.cubit,
    required this.i,
    required this.index,
    required CurrencyTextInputFormatter formatter,
  })  : _formatter = formatter,
        super(key: key);

  final ServicesCubit cubit;
  final CurrencyTextInputFormatter _formatter;
  final int i;
  final int index;

  @override
  State<SubServiceWidget> createState() => _SubServiceWidgetState();
}

class _SubServiceWidgetState extends State<SubServiceWidget> {
  @override
  Widget build(BuildContext context) {
    {
      bool? isSelected;

      for (SubServices e in widget.cubit.bookingSubServices ?? []) {
        if (e.id ==
            widget.cubit.services[widget.index].subServices?[widget.i].id) {
          isSelected = true;
          break;
        }
      }

      return Direction(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: GestureDetector(
            onTap: () {
              (isSelected ?? false)
                  ? widget.cubit.remove(widget.cubit.services[widget.index]
                          .subServices?[widget.i] ??
                      SubServices())
                  : widget.cubit.selectSubSerVice(
                      i: widget.i,
                      index: widget.index,
                      subService: widget.cubit.services[widget.index]
                              .subServices?[widget.i] ??
                          SubServices());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Visibility(
                                visible: isSelected ?? false,
                                replacement: Icon(
                                  Icons.check_box_outline_blank,
                                  color: AppColors.primiry,
                                  size: 25,
                                ),
                                child: Icon(
                                  Icons.check_box,
                                  color: AppColors.primiry,
                                  size: 25,
                                ),
                              ),
                              CustomText(
                                widget.cubit.services[widget.index]
                                        .subServices?[widget.i].name ??
                                    '',
                                textStyleEnum: TextStyleEnum.title,
                                color: AppColors.primiry,
                              ),
                            ],
                          ),
                          Direction(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReadMoreText(
                                  widget.cubit.services[widget.index]
                                          .subServices?[widget.i].description ??
                                      "",
                                  trimLines: 3,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: 'readMore'.tr(),
                                  trimExpandedText: 'readLess'.tr(),
                                  moreStyle: TextStyle(
                                      fontSize: 15, color: AppColors.primiry),
                                  style: TextStyle(
                                      fontSize: 15, color: AppColors.black),
                                ),
                                Visibility(
                                  visible: widget
                                          .cubit
                                          .services[widget.index]
                                          .subServices?[widget.i]
                                          .offer
                                          ?.gifts
                                          ?.isNotEmpty ??
                                      false,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/gift.png',
                                        width: 40,
                                      ),
                                      CustomText(
                                        ' ' 'Gifts'.tr(),
                                        textStyleEnum: TextStyleEnum.title,
                                        color: AppColors.primiry,
                                        fontsize: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                Direction(
                                  child: ListView.builder(
                                      padding: EdgeInsets.only(bottom: 10),
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: widget
                                              .cubit
                                              .services[widget.index]
                                              .subServices?[widget.i]
                                              .offer
                                              ?.gifts
                                              ?.length ??
                                          0,
                                      itemBuilder: (context, indexs) {
                                        return CustomText(widget
                                                .cubit
                                                .services[widget.index]
                                                .subServices?[widget.i]
                                                .offer
                                                ?.gifts?[indexs] ??
                                            '');
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: widget.cubit.services[widget.index]
                                    .subServices?[widget.i].offer !=
                                null,
                            child: MyButtonWIdget(
                              function: () {
                                null;
                              },
                              width: 90,
                              height: 35,
                              color: Colors.green,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(
                                    "${(widget.cubit.services[widget.index].subServices?[widget.i].offer?.percentage ?? 0)}% Off",
                                    fontsize: 18,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Visibility(
                              visible: widget.cubit.services[widget.index]
                                      .subServices?[widget.i].offer !=
                                  null,
                              replacement: Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: CustomText(
                                    "${widget._formatter.format('${(widget.cubit.services[widget.index].subServices?[widget.i].price ?? 0)} ')}"
                                            "EGP"
                                        .tr(),
                                    color: AppColors.primiry,
                                    fontsize: 20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CustomText(
                                      "${widget._formatter.format('${(widget.cubit.services[widget.index].subServices?[widget.i].offer?.priceAfter ?? 0)}')} "
                                              "EGP"
                                          .tr(),
                                      color: AppColors.primiry,
                                      fontsize: 20),
                                  CustomText(
                                    "${widget._formatter.format('${(widget.cubit.services[widget.index].subServices?[widget.i].offer?.priceBefore ?? 0)}')} "
                                            "EGP"
                                        .tr(),
                                    decoration: TextDecoration.lineThrough,
                                    fontsize: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 400,
                      child: Divider(color: AppColors.primiry),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}

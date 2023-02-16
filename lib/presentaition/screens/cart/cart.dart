import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:readmore/readmore.dart';
import 'package:scrollable_list_tabview/scrollable_list_tabview.dart';
import 'package:supa_kota/core/utiles/responsive.dart';
import 'package:supa_kota/presentaition/components/background_image.dart';
import 'package:supa_kota/presentaition/components/default_button.dart';
import 'package:supa_kota/presentaition/components/direction.dart';
import 'package:supa_kota/presentaition/components/empty_widget.dart';
import 'package:supa_kota/presentaition/components/loadinganderror.dart';
import 'package:supa_kota/presentaition/screens/services/widgets/dialog_request.dart';
import 'package:widget_mask/widget_mask.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utiles/alerts.dart';
import '../../../domain/models/services_model.dart';
import '../../components/custom_text.dart';
import '../../components/default_app_bar.dart';
import '../services/cubit/services_cubit.dart';
import 'cubit/cart_cubit.dart';
import 'widgets/subservice_widget.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key, required this.carId});
  int carId;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final cubit = CartCubit.get(context);

      // await cubit.getServiceToCart();
      final servicesCubit = ServicesCubit.get(context);
      // servicesCubit.getServiceFromCart();
      await servicesCubit.getDataToBookingServiceCar(
          widget.carId.toString(), context);
      servicesCubit.reset();
    });
    super.initState();
  }

  final CurrencyTextInputFormatter _formatter =
      CurrencyTextInputFormatter(locale: 'en', decimalDigits: 3, symbol: '');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = ServicesCubit.get(context);

          return Background(
              child: LoadingAndError(
            isError: state is ErrorServicesBooking,
            isLoading: state is LoadingServicesBooking,
            child: Scaffold(
                bottomNavigationBar: Direction(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () async {
                        if ((cubit.bookingSubServices ?? []).isEmpty) {
                          Fluttertoast.showToast(
                              msg: "chooseOneServive".tr(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              backgroundColor: AppColors.primiry,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          await cubit.getData(context, show: false);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                final date = DateTime.now();
                                return DialogItem(
                                    date: date, carId: widget.carId
                                    //     .toString(),
                                    );
                              });
                        }
                      },
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: AppColors.primiry,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                'book'.tr(),
                                color: AppColors.white,
                                fontsize: 22,
                              ),
                              // if ((cubit.bookingSubServices ?? []).isNotEmpty)
                              //   Row(
                              //     children: [
                              //       CustomText(
                              //         'Total'.tr() + ' ',
                              //         color: AppColors.white,
                              //         fontsize: 16,
                              //       ),
                              //       CustomText(
                              //         '${_formatter.format('${cubit.discount == 0 ? cubit.total : ((cubit.total * cubit.discount) / 10)}')} '
                              //                 'EGP'
                              //             .tr(),
                              //         color: AppColors.white,
                              //         fontsize: 22,
                              //       ),
                              //     ],
                              //   ),  // if ((cubit.bookingSubServices ?? []).isNotEmpty)
                              //   Row(
                              //     children: [
                              //       CustomText(
                              //         'Total'.tr() + ' ',
                              //         color: AppColors.white,
                              //         fontsize: 16,
                              //       ),
                              //       CustomText(
                              //         '${_formatter.format('${cubit.discount == 0 ? cubit.total : ((cubit.total * cubit.discount) / 10)}')} '
                              //                 'EGP'
                              //             .tr(),
                              //         color: AppColors.white,
                              //         fontsize: 22,
                              //       ),
                              //     ],
                              //   ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                body: Column(children: [
                  Stack(
                    children: [
                      DefaultAppBar(
                        icon: 'booking',
                        title: 'BookingRequest'.tr(),
                        desc: 'BookYouServiceNow'.tr(),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 55, left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors.white,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          cubit.myCar?.brand?.name ?? '',
                          textStyleEnum: TextStyleEnum.title,
                          fontsize: 22,
                          color: AppColors.primiry,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          cubit.myCar?.model?.name ?? '',
                          textStyleEnum: TextStyleEnum.title,
                          fontsize: 22,
                          color: AppColors.primiry,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          "${cubit.myCar?.year ?? ''}",
                          textStyleEnum: TextStyleEnum.title,
                          fontsize: 22,
                          color: AppColors.primiry,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          "${cubit.myCar?.notes ?? ''}",
                          textStyleEnum: TextStyleEnum.title,
                          fontsize: 22,
                          color: AppColors.primiry,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ScrollableListTabView(
                        style: TextStyle(color: AppColors.white),
                        tabHeight: 48,
                        bodyAnimationDuration:
                            const Duration(milliseconds: 150),
                        tabAnimationCurve: Curves.linear,
                        tabAnimationDuration: const Duration(milliseconds: 200),
                        tabs: List.generate(
                          cubit.services.length,
                          (index) => ScrollableListTab(
                              tab: ListTab(
                                  activeBackgroundColor: AppColors.primiry,
                                  borderColor: AppColors.primiry,
                                  label: Text(
                                    cubit.services[index].name ?? '',
                                  ),
                                  // icon: Icon(Icons.group),
                                  showIconOnList: false),
                              body: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    cubit.services[index].subServices?.length,
                                itemBuilder: (_, i) => Column(
                                  children: [
                                    SubServiceWidget(
                                        cubit: cubit,
                                        formatter: _formatter,
                                        i: i,
                                        index: index),
                                    if (index + 1 == cubit.services.length &&
                                        i + 1 ==
                                            cubit.services[index].subServices
                                                ?.length)
                                      SizedBox(
                                        height: 300.h,
                                      )
                                  ],
                                ),
                              )),
                        )),
                  )
                ])),
          ));
        });
  }
}

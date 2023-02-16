import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supa_kota/core/utiles/navigate.dart';
import 'package:supa_kota/core/utiles/utiles.dart';
import 'package:supa_kota/presentaition/components/custom_text.dart';
import 'package:supa_kota/presentaition/components/default_app_bar.dart';
import 'package:supa_kota/presentaition/components/default_button.dart';
import 'package:supa_kota/presentaition/screens/about_us/aboutus_screen.dart';
import 'package:supa_kota/presentaition/screens/become_partener/becomePartener.dart';
import 'package:supa_kota/presentaition/screens/cart/cart.dart';
import 'package:supa_kota/presentaition/screens/notification.dart/notification.dart';
import 'package:supa_kota/presentaition/screens/profile/profie_screen.dart';
import 'package:supa_kota/presentaition/screens/services/services_details.dart';
import 'package:supa_kota/presentaition/screens/splash_screen/splash_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_mask/widget_mask.dart';

import '../../../core/themes/colors.dart';
import '../../components/background_image.dart';
import '../../components/loadinganderror.dart';
import '../../components/toggle_clickable_container.dart';
import '../../layout/cubit/layout_cubit.dart';
import '../about_us/cubit/about_us_cubit.dart';
import '../my_cars/cubit/my_cars_cubit.dart';
import 'cubit/services_cubit.dart';
import 'widgets/appbar_service.dart';
import 'widgets/header_service_screen.dart';
import 'widgets/service_widget.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final servicesCubit = ServicesCubit.get(context);
      // servicesCubit.getServiceFromCart();
      await servicesCubit.getServicesAndNums(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final servicesCubit = ServicesCubit.get(context);
    final cubit = LayoutCubit.get(context);

    return Background(
      child: BlocConsumer<ServicesCubit, ServicesState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                  heroTag: null,
                  onPressed: () {
                    servicesCubit.getMyCars(context, show: true);
                  },
                  label: CustomText(
                    'booking'.tr(),
                    color: AppColors.white,
                    fontsize: 18,
                  )),
              backgroundColor: Colors.transparent,
              body: RefreshIndicator(
                onRefresh: () async {
                  await servicesCubit.getServicesAndNums(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppBarService(),
                    HeaderServiceScreen(cubit: cubit),
                    Expanded(
                      flex: 3,
                      child: LoadingAndError(
                        function: () async {
                          await servicesCubit.getServicesAndNums(context);
                        },
                        isError: servicesCubit.state is ServicesErrorState,
                        isLoading: servicesCubit.state is ServicesLoadingState,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            padding: EdgeInsets.only(bottom: 1),
                            itemCount: servicesCubit.services.length,
                            gridDelegate:
                                new SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 5,
                                    mainAxisExtent: 300),
                            itemBuilder: (BuildContext context, int index) {
                              return ServiceWidget(
                                  servicesCubit: servicesCubit, index: index);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

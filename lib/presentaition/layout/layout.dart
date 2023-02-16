// import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supa_kota/presentaition/components/background_image.dart';
import 'package:supa_kota/presentaition/components/direction.dart';
import 'package:supa_kota/presentaition/layout/widgets/bottom_nav_bar.dart';
import 'package:supa_kota/presentaition/screens/services/services_screen%20.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/themes/colors.dart';
import '../../core/utiles/utiles.dart';
import '../components/custom_text.dart';
import '../screens/about_us/cubit/about_us_cubit.dart';
import '../screens/gallery/gallery_screen.dart';
import '../screens/my_cars/mycars_screen.dart';
import '../screens/news/news_screens.dart';
import '../screens/reviews/reviews.dart';
import '../screens/services/cubit/services_cubit.dart';
import '../screens/services/widgets/communication_wiget.dart';
import 'cubit/layout_cubit.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({Key? key, this.index}) : super(key: key);
  int? index;
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    final cubit = LayoutCubit.get(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await cubit.getAboutUs(context);
    });
    cubit.tabController =
        TabController(length: 5, vsync: this, initialIndex: widget.index ?? 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = LayoutCubit.get(context);

    return BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          return UpgradeAlert(
            child: Scaffold(
              backgroundColor: AppColors.white,
              body: TabBarView(
                controller: cubit.tabController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  GalleryScreen(),
                  NewsScreen(),
                  Services(),
                  MyCarsScreen(),
                  ReviewsScreen(),
                ],
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  color: Colors.white,
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (cubit.phones.isNotEmpty)
                        Direction(
                          child: GestureDetector(
                            onTap: () {
                              Utiles.makeCall(Utiles.Allphones.first);
                            },
                            child: Container(
                              color: Colors.grey[100],
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      'Contactteam'.tr(),
                                      color: AppColors.primiry,
                                      fontsize: 19,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    CommuicationWidget(
                                      size: 16,
                                      num: Utiles.Allphones.first,
                                      color: AppColors.black,
                                      colorIcon: AppColors.green,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      CustomBottomNavBar(cubit),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

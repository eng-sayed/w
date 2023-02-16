import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_kota/presentaition/components/background_image.dart';
import 'package:supa_kota/presentaition/components/custom_text.dart';
import 'package:supa_kota/presentaition/components/direction.dart';
import 'package:supa_kota/presentaition/screens/gallery/cubit/gallery_cubit.dart';
import 'package:supa_kota/presentaition/screens/gallery/widget/appbar_gallery.dart';
import 'package:widget_mask/widget_mask.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utiles/navigate.dart';
import '../../../core/utiles/utiles.dart';
import '../../components/default_app_bar.dart';
import '../../components/default_button.dart';
import '../../components/loadinganderror.dart';
import '../../components/network_image.dart';
import '../notification.dart/notification.dart';
import '../profile/profie_screen.dart';
import 'gallery_detailes.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final galleryCubit = GalleryCubit.get(context);
      await galleryCubit.getBrands(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final galleryCubit = GalleryCubit.get(context);

    return Background(
      child: Scaffold(
        body: BlocConsumer<GalleryCubit, GalleryState>(
            listener: (context, state) {},
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  await galleryCubit.getBrands(context);
                },
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarGallery(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: LoadingAndError(
                          function: () async {
                            await galleryCubit.getBrands(context);
                          },
                          isError: state is BrandsErrorState,
                          isLoading: state is BrandsLoadingState,
                          child: GridView.builder(
                            padding: EdgeInsets.all(5),
                            itemCount: galleryCubit.brands.length,
                            gridDelegate:
                                new SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 15,
                                    mainAxisExtent: 160,
                                    crossAxisSpacing: 20),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  navigate(
                                      context: context,
                                      route: GalleryDetailes(
                                        id: galleryCubit.brands[index].id
                                            .toString(),
                                        name: galleryCubit.brands[index].name,
                                        logo: galleryCubit.brands[index].logo,
                                      ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0, color: AppColors.primiry),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: NetworkImagesWidgets(
                                            galleryCubit.brands[index].logo!,
                                            fit: BoxFit.fill,
                                            // height: 80,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: AppColors.primiry,
                                            borderRadius: BorderRadius.only(
                                              bottomRight:
                                                  Radius.circular(10.0),
                                              bottomLeft: Radius.circular(10.0),
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: MyButton(
                                            weight: FontWeight.normal,
                                            textColor: AppColors.black,
                                            color: AppColors.white,
                                            // width: 105,
                                            height: 40,
                                            text: galleryCubit
                                                    .brands[index].name ??
                                                '',
                                            fontSize: 13,
                                            function: () {
                                              navigate(
                                                  context: context,
                                                  route: GalleryDetailes(
                                                      id: galleryCubit
                                                          .brands[index].id
                                                          .toString(),
                                                      name: galleryCubit
                                                          .brands[index].name,
                                                      logo: galleryCubit
                                                          .brands[index].logo));
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

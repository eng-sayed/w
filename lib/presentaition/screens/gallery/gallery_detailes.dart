import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:supa_kota/core/utiles/navigate.dart';
import 'package:supa_kota/presentaition/components/background_image.dart';
import 'package:supa_kota/presentaition/components/custom_text.dart';
import 'package:supa_kota/presentaition/components/network_image.dart';
import 'package:supa_kota/presentaition/screens/gallery/model_detiales.dart';

import '../../../core/themes/colors.dart';
import '../../components/animation_build_widget.dart';
import '../../components/default_button.dart';
import 'cubit/gallery_cubit.dart';
import 'widget/image_tile.dart';

class GalleryDetailes extends StatefulWidget {
  GalleryDetailes({super.key, this.id, this.name, this.logo});
  String? id;
  String? logo;
  String? name;
  @override
  State<GalleryDetailes> createState() => _GalleryDetailesState();
}

class _GalleryDetailesState extends State<GalleryDetailes> {
  final rnd = Random();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final galleryCubit = GalleryCubit.get(context);
      await galleryCubit.getModelOfBrands(widget.id, context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GalleryCubit, GalleryState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final galleryCubit = GalleryCubit.get(context);

        return Background(
          child: Scaffold(
              body: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 110,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primiry,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35)),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 40),
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
                        Row(
                          children: [
                            CustomText(
                              widget.name ?? '',
                              textStyleEnum: TextStyleEnum.title,
                              color: AppColors.white,
                              fontsize: 22,
                              maxLines: 1,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: Image.network(
                                    widget.logo ?? '',
                                  ).image)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 60,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        if (galleryCubit.models.isNotEmpty)
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(maxHeight: 60, maxWidth: 100),
                            child: MyButtonWIdget(
                              function: () {
                                galleryCubit.changeImage(0, true);
                              },
                              width: 100,
                              height: 70,
                              color: galleryCubit.images ==
                                      galleryCubit.allGalleryModels
                                  ? AppColors.primiry
                                  : Colors.grey[200],
                              child: CustomText(
                                'All'.tr(),
                                color: galleryCubit.images ==
                                        galleryCubit.allGalleryModels
                                    ? AppColors.white
                                    : AppColors.primiry,
                                textStyleEnum: TextStyleEnum.title,
                                fontsize: 20,
                              ),
                            ),
                          ),
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: galleryCubit.models.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: MyButton(
                                width: 165,

                                height: 60,
                                function: () {
                                  galleryCubit.changeImage(index, false);
                                },
                                color: galleryCubit.images ==
                                        galleryCubit.models[index].gallery
                                    ? AppColors.primiry
                                    : Colors.grey[200],
                                text: galleryCubit.models[index].name ?? '',
                                textColor: galleryCubit.images ==
                                        galleryCubit.models[index].gallery
                                    ? AppColors.white
                                    : AppColors.primiry,
                                // textStyleEnum: TextStyleEnum.title,
                                fontSize: 20,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: AnimationAppearanceOpacity(
                    child: MasonryGridView.count(
                      padding: EdgeInsets.all(5),
                      itemCount: galleryCubit.images.length,
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      itemBuilder: (context, index) {
                        final height = (rnd.nextInt(7) + 1) * 40;
                        return AnimationAppearanceOpacity(
                          child: ImageTile(
                            index: index,
                            width: 300,
                            height: height < 45 ? 90 : height,
                            isText: false,
                            image: galleryCubit.images[index],
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          )),
        );
      },
    );
  }
}

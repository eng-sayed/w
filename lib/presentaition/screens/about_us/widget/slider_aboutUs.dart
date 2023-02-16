import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../components/network_image.dart';
import '../cubit/about_us_cubit.dart';

class SliderAboutUs extends StatelessWidget {
  const SliderAboutUs({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final AboutUsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              aspectRatio: 1.5,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              onPageChanged: (index, reason) {
                cubit.changeSlider(index);
              },
            ),
            items: List.generate(
              cubit.aboutUsModel?.aboutGallery?.length ?? 0,
              (index) => NetworkImagesWidgets(
                'https://www.supakotoapp.com${cubit.aboutUsModel?.aboutGallery?[index] ?? ''}',
                height: 312,
                width: 820,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                cubit.aboutUsModel?.aboutGallery?.length ?? 0,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    color: cubit.indexCrsoul == index
                        ? AppColors.primiry
                        : AppColors.white,
                  ),
                  margin: const EdgeInsets.only(right: 5),
                  height: 10,
                  curve: Curves.easeIn,
                  width: 10,
                ),
              )),
        ),
      ],
    );
  }
}

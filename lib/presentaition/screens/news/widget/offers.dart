import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../components/network_image.dart';
import '../cubit/news_cubit.dart';

class Offers extends StatelessWidget {
  const Offers({
    Key? key,
    required this.blogCubit,
  }) : super(key: key);

  final NewsCubit blogCubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 250,
            autoPlay: true,
            viewportFraction: 1,
            enableInfiniteScroll: true,
            aspectRatio: 1.5,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            onPageChanged: (index, reason) {
              blogCubit.changeSlider(index);
            },
          ),
          items: List.generate(
            blogCubit.gallery.length,
            (index) => NetworkImagesWidgets(
              '${blogCubit.gallery[index]}',
              height: 312,
              width: 820,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                blogCubit.gallery.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    color: blogCubit.indexCrsoul == index
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

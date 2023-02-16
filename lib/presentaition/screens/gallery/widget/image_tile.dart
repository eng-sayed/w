import 'package:flutter/material.dart';
import 'package:supa_kota/presentaition/screens/gallery/widget/image_fullscreen.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utiles/navigate.dart';
import '../../../components/custom_text.dart';
import '../../../components/network_image.dart';
import '../model_detiales.dart';

class ImageTile extends StatelessWidget {
  const ImageTile({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
    required this.isText,
    required this.image,
  }) : super(key: key);

  final int index;
  final int width;
  final int height;
  final bool isText;
  final image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // isText
        //     ?
        navigate(
            context: context,
            route: ImageFullScreen(
              image: image,
            ));
        // : navigate(context: context, route: ModelDetailes());
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              image,
              width: width.toDouble(),
              height: height.toDouble(),
              fit: BoxFit.cover,
            ),
          ),
          if (isText)
            Align(
                child: CustomText(
              'Testal Model X',
              color: AppColors.white,
              fontsize: 22,
            ))
        ],
      ),
    );
  }
}

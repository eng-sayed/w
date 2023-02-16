import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:supa_kota/presentaition/components/network_image.dart';

import '../../../../core/themes/colors.dart';

class ImageFullScreen extends StatefulWidget {
  ImageFullScreen({super.key, required this.image});
  String image;

  @override
  State<ImageFullScreen> createState() => _ImageFullScreenState();
}

class _ImageFullScreenState extends State<ImageFullScreen> {
  // late TransformationController controller;
  // TapDownDetails? tapDownDetails;
  // @override
  // void initState() {
  //   super.initState();
  //   controller = TransformationController();
  // }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          // alignment: Alignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Spacer(),
            PhotoView(
              imageProvider: Image.network(
                widget.image,
              ).image,
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

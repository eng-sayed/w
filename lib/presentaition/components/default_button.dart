import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';

import '../../core/themes/colors.dart';
import 'custom_text.dart';

class MyButton extends StatelessWidget {
  MyButton({
    super.key,
    required this.function,
    required this.text,
    this.width,
    this.color,
    this.fontFamily,
    this.fontSize,
    this.height,
    this.isUpperCase,
    this.radius,
    this.padding,
    this.textColor,
    this.weight,
  });
  double? width = 120;
  double? height;
  Color? textColor = Colors.white;
  bool? isUpperCase = true;
  double? radius = 40;
  Color? color;
  FontWeight? weight;
  double? fontSize;
  double? padding;
  String? fontFamily;
  Function function;
  String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Padding(
        padding: EdgeInsets.all(padding ?? 8.0),
        child: Container(
          height: height ?? 50,
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                    color ?? AppColors.primiry,
                    BlendMode.srcIn,
                  ),
                  image: Image.asset(
                    'assets/images/btn.png',
                    height: height,
                    width: width,
                    color: color,
                    fit: BoxFit.fill,
                  ).image)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Container(
                width: ((width ?? 100)),
                child: CustomText(
                  text,
                  align: TextAlign.center,
                  fontsize: fontSize ?? 18,
                  overflow: TextOverflow.ellipsis,
                  color: textColor ?? AppColors.white,
                  weight: weight ?? FontWeight.bold,
                  maxLines: 3,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyButtonWIdget extends StatelessWidget {
  MyButtonWIdget({
    super.key,
    required this.function,
    this.width,
    this.color,
    this.height,
    this.child,
  });
  double? width = 120;
  double? height;
  Widget? child;

  Color? color;

  Function function;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          function();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/btn.png',
              height: height,
              width: width,
              color: color,
              fit: BoxFit.fill,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            //   child: Image.asset(
            //     'assets/images/btn.png',
            //     height: (height ?? 40) - 3,
            //     width: (width ?? 40) - 3,
            //     color: AppColors.white,
            //     fit: BoxFit.fill,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

Widget defaultButton({
  double width = double.infinity,
  double? height,
  Color textColor = Colors.white,
  bool isUpperCase = true,
  double radius = 40,
  Color? color,
  FontWeight? weight,
  double? fontSize,
  String? fontFamily,
  required Function function,
  required String text,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      // child: Arc(
      //   height: 10,
      //   arcType: ArcType.CONVEX,
      //   edge: Edge.TOP,
      //   child: Arc(
      //     height: 10,
      //     arcType: ArcType.CONVEX,
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: width,
        height: height ?? 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: AppColors.primiry,
          // border: Border.all(color: AppColors.primiry)
          // shape: BoxShape.circle
        ),
        child: TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            backgroundColor:
                MaterialStateProperty.all(color ?? AppColors.buttonColor),
          ),
          onPressed: () {
            function();
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              text,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: fontSize ?? 18,
                  fontFamily: fontFamily,
                  color: textColor,
                  fontWeight: weight ?? FontWeight.bold),
            ),
          ),
        ),
      ),
      //   ),
      // ),
    );

class MyTextButton extends StatelessWidget {
  MyTextButton({
    super.key,
    required this.function,
    required this.text,
    this.color,
    this.size,
  });
  Function function;
  String text;
  double? size;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        function();
      },
      child: CustomText(
        text,
        fontsize: size ?? 12,
        color: color ?? AppColors.secondary,
        //  style: TextStyle(color: AppColors.secondary),
      ),
      // style: TextButton.styleFrom(
      //   elevation: 0,
      //   textStyle: TextStyle(
      //     fontWeight: FontWeight.w600,
      //     fontSize: (width <= 550) ? 13 : 17,
      //   ),
      // ),
    );
  }
}

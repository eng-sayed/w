import 'package:flutter/material.dart';

import '../../core/themes/colors.dart';
import 'custom_text.dart';

class ClickableContainer extends StatefulWidget {
  ClickableContainer({
    required this.text,
    required this.textColor,
    required this.function,
    required this.isSelect,
    required this.borderColor,
    required this.color,
    required this.isRight,
    Key? key,
  }) : super(key: key);
  Color color, borderColor, textColor;
  String text;
  Function function;
  bool isSelect, isRight;

  @override
  State<ClickableContainer> createState() => _ClickableContainerState();
}

class _ClickableContainerState extends State<ClickableContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.function();
        // widget.isSelect = !widget.isSelect;
        // setState(() {});
      },
      child: Container(
        alignment: Alignment.center,
        width: 55,
        height: 40,
        // padding: EdgeInsets.symmetric(vertical: 8, horizontal: 22),
        decoration: BoxDecoration(
          color: widget.isSelect ? widget.color : AppColors.white,
          border: Border.all(color: widget.borderColor),
          borderRadius: !widget.isRight
              ? const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
              : const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
        ),
        child: CustomText(
          widget.text,
          color: widget.isSelect ? AppColors.white : widget.textColor,
        ),
      ),
    );
  }
}

class ClickableBtn extends StatefulWidget {
  ClickableBtn({
    required this.text,
    required this.textColor,
    required this.function,
    required this.isSelect,
    required this.borderColor,
    required this.color,
    required this.isRight,
    Key? key,
  }) : super(key: key);
  Color color, borderColor, textColor;
  String text;
  Function function;
  bool isSelect, isRight;

  @override
  State<ClickableBtn> createState() => _ClickableBtnState();
}

class _ClickableBtnState extends State<ClickableBtn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.function();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 60,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(.15),
                  blurRadius: 4,
                  offset: widget.isRight
                      ? Offset(5, 2)
                      : Offset(20, 2), // Shadow position
                ),
              ],
            ),
            child: Image.asset(
              widget.isRight
                  ? 'assets/images/right.png'
                  : 'assets/images/lefte.png',
              width: 60,
              height: 50,
              color: widget.isSelect ? widget.color : AppColors.white,
            ),
          ),
          CustomText(
            widget.text,
            color: widget.isSelect ? AppColors.white : widget.textColor,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../consts.dart';

class DefaultButton extends StatefulWidget {
  String text;
  bool? isGetPadding;
  Color? backgroundColor;
  Color? textColor;
  VoidCallback? onPressed;
  EdgeInsetsGeometry? margin;

  double? width;
  double? height;
  double? fontSize;

  DefaultButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.margin,
      this.width,
      this.height,
      this.textColor,
      this.fontSize,
      this.backgroundColor,
      required this.isGetPadding})
      : assert(isGetPadding != null),
        super(key: key);
  @override
  State<StatefulWidget> createState() => _DefaultButton();
}

class _DefaultButton extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    double bottomButtonWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: widget.isGetPadding == true
          ? EdgeInsets.only(left: defaultSidePadding, right: defaultSidePadding)
          : const EdgeInsets.only(left: 0, right: 0),
      width: widget.width ?? MediaQuery.of(context).size.width,
      margin: widget.margin,
      constraints: BoxConstraints(
        minHeight: widget.height ?? 55,
      ),
      height: 55,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        child: Text(
          widget.text,
          style: TextStyle(
              fontSize: widget.fontSize ?? bottomButtonWidth * 0.045,
              color: widget.textColor ?? Colors.white),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: widget.backgroundColor ?? colorMain,
            shadowColor: Colors.transparent,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}

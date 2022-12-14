import 'package:flutter/material.dart';

import '../consts.dart';

class DefaultButton extends StatefulWidget {
  String text;
  bool? isGetPadding;
  Function onPressed;
  EdgeInsetsGeometry? margin;

  DefaultButton(
      {required this.text,
      required this.onPressed,
      this.margin,
      required this.isGetPadding});
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
      width: MediaQuery.of(context).size.width,
      margin: widget.margin,
      constraints: const BoxConstraints(
        minHeight: 55,
      ),
      height: 55,
      child: ElevatedButton(
        onPressed: () => widget.onPressed.call(),
        child: Text(
          widget.text,
          style: TextStyle(fontSize: bottomButtonWidth * 0.05),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: colorMain,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ),
    );
  }
}

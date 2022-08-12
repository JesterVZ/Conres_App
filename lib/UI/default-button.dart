import 'package:flutter/material.dart';

import '../consts.dart';

class DefaultButton extends StatefulWidget{
  String text;
  Function onPressed;
  EdgeInsetsGeometry? margin;

  DefaultButton({required this.text, required this.onPressed, this.margin});
  @override
  State<StatefulWidget> createState() => _DefaultButton();
}
class _DefaultButton extends State<DefaultButton>{

  @override
  Widget build(BuildContext context) {
    return Container(
                      padding: EdgeInsets.only(
                          left: defaultSidePadding, right: defaultSidePadding),
                      width: MediaQuery.of(context).size.width,
                      margin: widget.margin,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: ()=> widget.onPressed.call(),
                        child: Text(widget.text, style: buttonTextStyle, textAlign: TextAlign.center,),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorMain,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
                    );
  }
}
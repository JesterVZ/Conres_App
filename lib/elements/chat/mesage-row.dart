import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';
import 'm-element.dart';

class MessageRow extends StatelessWidget{
  bool isOwn;
  String text;
  String time;
  MessageRow({required this.isOwn, required this.text, required this.time});

  @override
  Widget build(BuildContext context) {
    return isOwn ? Row(
      children: [
        const Spacer(),
        Container(
          margin: EdgeInsets.only(right: 22, bottom: 10),
          child: MessageBox(text: text, rectangleColor: colorMain, textColor: Colors.white),
        )
      ],
    ) : Row(
      children: [
        Container(
            margin: EdgeInsets.only(left: 22, bottom: 10),
          child: MessageBox(text: text, rectangleColor: messageColor, textColor: Colors.black),
        ),
        const Spacer()
      ],
    );
  }
}
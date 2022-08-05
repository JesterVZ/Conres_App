import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../consts.dart';

class HeaderRow extends StatelessWidget {
  String text = "";
  double fontSize;

  HeaderRow({required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            width: 30,
            height: 30,
            margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
            child: Image.asset('assets/back-arrow.png'),
          ),
        ),
        Flexible(
            child: Text(
          text,
          style: TextStyle(fontFamily: 'Bubicon-Bold', fontSize: fontSize),
        )),
      ],
    );
  }
}

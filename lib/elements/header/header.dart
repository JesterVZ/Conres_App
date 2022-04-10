import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../consts.dart';

class HeaderRow extends StatelessWidget {
  late String _text = "";
  late double _fontSize;
  HeaderRow(String text, double fontSize, bool isLS) {
    _text = text;
    _fontSize = fontSize;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
          _text,
          style: TextStyle(fontFamily: 'Bubicon-Bold', fontSize: _fontSize),
        )),
      ],
    );
  }
}

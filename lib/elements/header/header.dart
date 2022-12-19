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
      crossAxisAlignment: CrossAxisAlignment.start,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 8),
          child: GestureDetector(
            onTap: () {
              if (text == "Выберите тип (Авторизаця)") {
                Navigator.of(context).popUntil((route) => route.isFirst);
              } else {
                Navigator.pop(context);
              }
            },
            child: Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: Image.asset('assets/back-arrow.png'),
            ),
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

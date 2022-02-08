import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';

class HeaderRow extends StatelessWidget {
  late String _text = "";
  late double _fontSize;
  HeaderRow(String text, double fontSize) {
    _text = text;
    _fontSize = fontSize;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
                shadowColor: Colors.transparent
            ),

            child: Image.asset('assets/back-arrow.png'),
          ),
        ),
        Flexible(
            child: Text(
          _text,
          style: TextStyle(fontFamily: 'Bubicon-Bold', fontSize: _fontSize),
        ))
      ],
    );
  }
}

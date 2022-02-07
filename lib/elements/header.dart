import 'package:flutter/cupertino.dart';

import '../consts.dart';

class HeaderRow extends StatelessWidget{
  late String _text = "";
  HeaderRow(String text){
    _text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset('assets/back-arrow.png'),
            )),
        Flexible(child: Text(
          _text,
          style: TextStyle(fontFamily: 'Bubicon-Bold', fontSize: 34),
        ))
      ],
    );
  }

}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';

class Status extends StatelessWidget{
  String? name;
  Color? textColor;
  Color? backgroundColor;

  Status({
    required this.name,
  });
  @override
  Widget build(BuildContext context) {
    switch (name) {
        case "Открыт":
          textColor = Colors.white;
          backgroundColor = greenColor;
          break;
        case "Закрыт":
          textColor = Colors.white;
          backgroundColor = redColor;
          break;
        case "В обработке":
          textColor = Colors.white;
          backgroundColor = yellowColor;
          break;
      }
    return Container(
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor
      ),
      child: Text(name!, style: TextStyle(
        color: textColor
      )),
    );
  }
}
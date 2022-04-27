import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';

class StatusElement extends StatelessWidget{
  String status;
  Color? textColor = colorMain;
  Color? backgroundColor = messageColor;
  StatusElement({required this.status});

  @override
  Widget build(BuildContext context) {
    switch(status){
      case "Отправленно":
        textColor = colorMain;
        backgroundColor = messageColor;
        break;
      case "Ожидается подтверждение":
        textColor = yellowColor;
        backgroundColor = yellowStatusColor;
        break;
      case "Не оплачено":
        textColor = Colors.green;
        backgroundColor = Colors.greenAccent;
    }

    return Container(
      padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor
      ),
      child: Text(status, style: TextStyle(color: textColor)),
    );
  }
}
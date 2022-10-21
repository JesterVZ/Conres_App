import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';

class TuStatusElement extends StatelessWidget{
  String status;
  Color? textColor = colorMain;
  Color? backgroundColor = messageColor;
  TuStatusElement({required this.status});

  @override
  Widget build(BuildContext context) {
    String statusName = "";
    switch(status){
      case "1":
        statusName = "Отправлено";
        textColor = colorMain;
        backgroundColor = messageColor;
        break;
      case "2":
        statusName = "В обработке";
        textColor = yellowColor;
        backgroundColor = yellowStatusColor;
        break;
      case "3":
        statusName = "Ожидается подтверждение";
        textColor = yellowColor;
        backgroundColor = yellowStatusColor;
        break;
      case "4":
        statusName = "Отклонено";
        textColor = Colors.white;
        backgroundColor = redColor;
        break;
      case "5":
        statusName = "Завершено";
        textColor = Colors.white;
        backgroundColor = greenColor;
        break;
    }

    return Container(
      padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor
      ),
      child: Text(statusName, style: TextStyle(color: textColor)),
    );
  }
}
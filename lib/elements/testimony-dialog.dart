import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';

class TestimonyDialog extends StatelessWidget{
  String time;
  String coefficient;
  String consumption;
  String previousReadings;

  TestimonyDialog(
      this.time,
      this.coefficient,
      this.consumption,
      this.previousReadings, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget labelTitle = Row(
      children: [
        Container(
          width: 10,
          height: 10,
          color: yellowColor,
        ),
        Text(time)
      ],
    );
    return AlertDialog(
      title: labelTitle,
      content: Column(children: [
        TextField(),
        Row(children: [
          const Text("Расчётный коэфициент:"),
          const Spacer(),
          Text(coefficient)
        ]),
        Row(
          children: [
            const Text("Расход:"),
            const Spacer(),
            Text(consumption)
          ],
        ),
        Divider(
          color: borderProfileColor,
        ),
        Row(
          children: [
            const Text("Предыдущие показания:"),
            const Spacer(),
            Text(previousReadings)
          ],
        )
      ]),
    );
  }
}
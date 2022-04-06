import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';


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
          margin: const EdgeInsets.only(right: 9),
          decoration: BoxDecoration(
              color: yellowColor,
            shape: BoxShape.circle
          ),
        ),
        Text(time)
      ],
    );
    return AlertDialog(
      title: labelTitle,
      content: Container(
        height: 236,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
            children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            height: 45,
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Новое показание",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: inputBorder))),
            )
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Row(children: [
              const Text("Расчётный коэфициент:"),
              const Spacer(),
              Text(coefficient)
            ]),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 17),
            child: Row(
              children: [
                const Text("Расход:"),
                const Spacer(),
                Text(consumption)
              ],
            ),
          ),

          Divider(
            color: Colors.black,
          ),
          Container(
            margin: const EdgeInsets.only(top: 17),
            child: Row(
              children: [
                const Text("Предыдущие показания:"),
                const Spacer(),
                Text(previousReadings)
              ],
            )
          )

        ]),
      )
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../UI/default-input.dart';
import '../../consts.dart';
/* 
claim-step3-object.dart
Объект в заявлениях (добавляется на шаге 3)

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class ClaimStep3Object extends StatefulWidget {
  List<TextEditingController> ControllerList =
      List<TextEditingController>.generate(
          6, (index) => TextEditingController());
  ValueChanged<int> deleteFunc;
  int id;
  ClaimStep3Object({required this.id, required this.deleteFunc});
  @override
  State<StatefulWidget> createState() => _ClaimStep3Object();
}

class _ClaimStep3Object extends State<ClaimStep3Object> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15, bottom: 15),
          width: MediaQuery.of(context).size.width,
          height: 6,
          decoration: BoxDecoration(
              color: colorMain, borderRadius: BorderRadius.circular(8)),
        ),
        Container(
          child: Text("Максимальная мощность (всего) на напряжении:",
              style: TextStyle(color: colorGray, fontSize: 16)),
        ),
        Container(
          child: Row(
            children: [
              SizedBox(
                width: 158,
                child: DefaultInput(
                    controller: widget.ControllerList[0],
                    keyboardType: TextInputType.number,
                    labelText: "кВт",
                    hintText: "000",
                    validatorText: "Введите серию"),
              ),
              const Spacer(),
              SizedBox(
                width: 158,
                child: DefaultInput(
                    controller: widget.ControllerList[1],
                    keyboardType: TextInputType.number,
                    labelText: "Вт",
                    hintText: "000",
                    validatorText: "Введите номер"),
              )
            ],
          ),
        ),
        Container(
          child: Text("Вновь присоединяемая мощность на напряжении:",
              style: TextStyle(color: colorGray, fontSize: 16)),
        ),
        Container(
          child: Row(
            children: [
              SizedBox(
                width: 158,
                child: DefaultInput(
                    controller: widget.ControllerList[2],
                    keyboardType: TextInputType.number,
                    labelText: "кВт",
                    hintText: "000",
                    validatorText: "Введите серию"),
              ),
              const Spacer(),
              SizedBox(
                width: 158,
                child: DefaultInput(
                    controller: widget.ControllerList[3],
                    keyboardType: TextInputType.number,
                    labelText: "Вт",
                    hintText: "000",
                    validatorText: "Введите номер"),
              )
            ],
          ),
        ),
        Container(
          child: Text("Ранее присоединяемая мощность на напряжении:",
              style: TextStyle(color: colorGray, fontSize: 16)),
        ),
        Container(
          child: Row(
            children: [
              SizedBox(
                width: 158,
                child: DefaultInput(
                    controller: widget.ControllerList[4],
                    keyboardType: TextInputType.number,
                    labelText: "кВт",
                    hintText: "000",
                    validatorText: "Введите серию"),
              ),
              const Spacer(),
              SizedBox(
                width: 158,
                child: DefaultInput(
                    controller: widget.ControllerList[5],
                    keyboardType: TextInputType.number,
                    labelText: "Вт",
                    hintText: "000",
                    validatorText: "Введите номер"),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 23),
          width: MediaQuery.of(context).size.width,
          height: 55,
          child: ElevatedButton(
            onPressed: () {
              widget.deleteFunc.call(widget.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: redColor,
            ),
            child: Text("Удалить объект"),
          ),
        )
      ],
    );
  }
}

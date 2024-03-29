import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../UI/default-button.dart';
import '../../UI/default-input.dart';
import '../../consts.dart';
/* 
claim-step5-object.dart
Объект в заявлениях (добавляется на шаге 5)

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class ClaimStep5Object extends StatefulWidget {
  List<TextEditingController> ControllerList =
      List<TextEditingController>.generate(
          6, (index) => TextEditingController());
  ValueChanged<int> deleteFunc;
  int id;
  ClaimStep5Object({required this.id, required this.deleteFunc});
  @override
  State<StatefulWidget> createState() => _ClaimStep45Object();
}

class _ClaimStep45Object extends State<ClaimStep5Object> {
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
        DefaultInput(
            controller: widget.ControllerList[0],
            keyboardType: TextInputType.number,
            labelText: "Этап (очередь) строительства",
            hintText: "",
            validatorText: "Введите серию"),
        DefaultInput(
            controller: widget.ControllerList[1],
            keyboardType: TextInputType.number,
            labelText:
                "Планируемый срок проектирования энергоприниюмающих устройств месяц, год) ",
            hintText: "",
            validatorText: "Введите серию"),
        DefaultInput(
            controller: widget.ControllerList[2],
            keyboardType: TextInputType.number,
            labelText:
                "Планируемый срок введения энергопринимающих устройств в эксплуатацию(месяц, год) ",
            hintText: "",
            validatorText: "Введите серию"),
        DefaultInput(
            controller: widget.ControllerList[3],
            keyboardType: TextInputType.number,
            labelText:
                "Максимальная мощность энергопринимаю-щих устройств (кВт)",
            hintText: "",
            validatorText: "Введите серию"),
        DefaultInput(
            controller: widget.ControllerList[4],
            keyboardType: TextInputType.number,
            labelText: "Категория надежности энергопринимаю-щих устройств ",
            hintText: "",
            validatorText: "Введите серию"),
        DefaultButton(
            margin: const EdgeInsets.only(bottom: 24),
            text: "Удалить объект", 
            onPressed: (){
                widget.deleteFunc.call(widget.id);
            },
            backgroundColor: redColor,
            isGetPadding: false),
        
      ],
    );
  }
}

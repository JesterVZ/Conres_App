import 'dart:ui';

import 'package:conres_app/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../UI/default-input.dart';

class ClaimStep2Object extends StatefulWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController kadastrController = TextEditingController();
  ValueChanged<int> deleteFunc;
  int id;

  ClaimStep2Object(
      {required this.id,
      required this.deleteFunc});
  @override
  State<StatefulWidget> createState() => _ClaimStep2Object();
}

class _ClaimStep2Object extends State<ClaimStep2Object> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 15),
            width: MediaQuery.of(context).size.width,
            height: 6,
            decoration: BoxDecoration(
              color: colorMain,
              borderRadius: BorderRadius.circular(8)),
          ),
          DefaultInput(
              controller: widget.nameController,
              keyboardType: TextInputType.text,
              labelText: "Наименование объекта",
              hintText: "Наименование объекта",
              validatorText: "Введите наименование объекта"),
          DefaultInput(
              controller: widget.addressController,
              keyboardType: TextInputType.text,
              labelText: "Адрес объекта",
              hintText: "Адрес объекта",
              validatorText: "Введите адрес объекта"),
          DefaultInput(
              controller: widget.kadastrController,
              keyboardType: TextInputType.text,
              labelText: "Кадастровый номер (необязательно)",
              hintText: "00:00:0000000:000",
              validatorText: "Введите кадастровый номер"),
          Container(
            margin: EdgeInsets.only(top: 23),
            width: MediaQuery.of(context).size.width,
            height: 55,
            child: ElevatedButton(
              onPressed: (){
                widget.deleteFunc.call(widget.id);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: redColor,
              ),
              child: Text("Удалить объект"),
            ),
          )
        ],
      ),
    );
  }
}

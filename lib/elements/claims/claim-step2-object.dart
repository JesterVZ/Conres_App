import 'dart:ui';

import 'package:conres_app/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
          Container(
                                    margin: EdgeInsets.only(bottom: 12),
                                  child:
          DefaultInput(
              controller: widget.nameController,
              keyboardType: TextInputType.text,
              labelText: "Наименование объекта",
              hintText: "Наименование объекта",
              validatorText: "Введите наименование объекта")),
          Container(
                                    margin: EdgeInsets.only(bottom: 12),
                                  child:
          DefaultInput(
              controller: widget.addressController,
              keyboardType: TextInputType.text,
              labelText: "Адрес объекта",
              hintText: "Адрес объекта",
              validatorText: "Введите адрес объекта")),
          Container(
                                    margin: EdgeInsets.only(bottom: 12),
                                  child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Кадастровый номер (необязательно)",
                  style: TextStyle(color: colorGray, fontSize: 16.0)),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: widget.kadastrController,
                keyboardType: TextInputType.text,
                inputFormatters: [MaskTextInputFormatter(mask: "+7 (###) ###-##-##")],
                decoration: InputDecoration(
                    hintText: "00:00:0000000:000",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: inputBorder, width: 5.0),
                        borderRadius: BorderRadius.circular(10))),
              )
            ],
          )),
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
              child: Text("Удалить объект", style: buttonTextStyle,),
            ),
          )
        ],
      ),
    );
  }
}

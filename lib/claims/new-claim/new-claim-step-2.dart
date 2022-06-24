import 'dart:ui';

import 'package:conres_app/elements/header/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../consts.dart';
import '../../elements/dropdown.dart';
import '../../elements/masks.dart';
import 'new-claim-step-3.dart';

class NewClaimStep2 extends StatefulWidget{
  const NewClaimStep2({Key? key, required List<TextEditingController> controllerList}) : super(key: key);

  final controllerList = List<TextEditingController>;
  @override
  State<StatefulWidget> createState() => _NewClaimStep2();
}

class _NewClaimStep2 extends State<NewClaimStep2>{
  final controllerList = List<TextEditingController>.generate(3, (index) => TextEditingController());
  final controllerDlList = List<TextEditingController>.generate(3, (index) => TextEditingController());
  late bool _visabillity = false;

  void _addNewObject(){
    setState(() {
      _visabillity = !_visabillity;
    });

  }
  void _validate(bool result){

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(17, 59, 17, 0),
                child: Column(
                  children: [
                    HeaderRow(text: claimStep2, fontSize: 24),
                    Column(
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(margin: EdgeInsets.fromLTRB(0, 25, 0, 10),
                              child: Text(claimAdd, style: claimTextStyle),),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(cause, style: labelTextStyle),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 55,
                                      child: const CustomDropDown(title: "Выберите причину", items: [
                                        "увеличением объема максимальной мощности",
                                        "новым строительством",
                                        "изменением категории надежности электроснабжения",
                                        "другое"
                                      ],)
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 28),
                                    child: Text(warning, style: warningTextStyle, textAlign: TextAlign.center,)
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(objectName,
                                            style: labelTextStyle),
                                        TextField(
                                          controller: controllerList[0],
                                          decoration: InputDecoration(
                                            hintText: "Наименование объекта",
                                              border: OutlineInputBorder(
                                                  borderSide:
                                                  BorderSide(color: inputBorder))),
                                        )
                                      ],
                                    )
                                  ),
                                  Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(objectAddress,
                                              style: TextStyle(
                                                  color: colorGray, fontSize: 16.0)),
                                          TextField(
                                            controller: controllerList[1],
                                            decoration: InputDecoration(
                                              hintText: "Адрес объекта",
                                                border: OutlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: inputBorder))),
                                          )
                                        ],
                                      )),
                                  Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(cadastrNumber,
                                              style: TextStyle(
                                                  color: colorGray, fontSize: 16.0)),
                                          MaskInput(
                                            isValidate: _validate,
                                            textController: controllerList[2],
                                            formatter: MaskTextInputFormatter(mask: "##:##:#######:###"),
                                            hint: "00:00:0000000:000",
                                            type: "kadastr",
                                          )
                                        ],
                                      )),
                                  Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
                                      height: 55,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(primary: Colors.white),
                                          onPressed: (){
                                            setState(() {
                                              _addNewObject();
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                  child: SvgPicture.asset('assets/plus.svg')
                                              ),
                                              Text(addObject, style: TextStyle(color: colorMain, fontSize: 18))
                                            ],
                                          ))
                                  ),
                                  Visibility(
                                    visible: _visabillity,
                                    child: Column(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(objectName,
                                                    style: labelTextStyle),
                                                TextField(
                                                  controller: controllerDlList[0],
                                                  decoration: InputDecoration(
                                                    hintText: "Наименование объекта",
                                                      border: OutlineInputBorder(
                                                          borderSide:
                                                          BorderSide(color: inputBorder))),
                                                )
                                              ],
                                            )
                                        ),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(objectAddress,
                                                    style: TextStyle(
                                                        color: colorGray, fontSize: 16.0)),
                                                TextField(
                                                  controller: controllerDlList[1],
                                                  decoration: InputDecoration(
                                                    hintText: "Адрес объекта",
                                                      border: OutlineInputBorder(
                                                          borderSide:
                                                          BorderSide(color: inputBorder))),
                                                )
                                              ],
                                            )),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(cadastrNumber,
                                                    style: TextStyle(
                                                        color: colorGray, fontSize: 16.0)),
                                                MaskInput(
                                                  isValidate: _validate,
                                                  textController: controllerDlList[2],
                                                  formatter: MaskTextInputFormatter(mask: "##:##:#######:###"),
                                                  hint: "00:00:0000000:000",
                                                  type: "kadastr",
                                                )
                                              ],
                                            )),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
                                            height: 55,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(primary: redColor),
                                                onPressed: (){
                                                  setState(() {
                                                    _visabillity = false;
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text(deleteObject, style: TextStyle(color: Colors.white, fontSize: 18))
                                                  ],
                                                ))
                                        ),
                                      ],
                                    )
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.9,
                                      height: 55.0,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder:  (context) =>  NewClaimStep3()));
                                          },
                                          child: Text(
                                              next,
                                            style: buttonTextStyle,
                                          ),
                                          style: ElevatedButton.styleFrom(primary: colorMain))),
                                ],

                              )
                            ],
                          )
                        )

                      ],
                    ),


                  ],
                ))
          ],
        ),
      )
    );
  }

}
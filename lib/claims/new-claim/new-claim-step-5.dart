import 'dart:ui';

import 'package:conres_app/elements/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../consts.dart';
import '../../elements/dropdown.dart';
import '../../icons.dart';
import '../../profile/profile-no-ls.dart';
import 'new-claim-step-2.dart';
import 'new-claim-step-6.dart';

class NewClaimStep5 extends StatefulWidget{
  const NewClaimStep5({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewClaimStep5();
}

class _NewClaimStep5 extends State<NewClaimStep5>{
  late bool _visabillity = false;

  void _addNewObject(){
    _visabillity = !_visabillity;
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
                    HeaderRow(claimStep5, 24, true),
                    Column(
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(margin: EdgeInsets.fromLTRB(0, 25, 0, 10),
                              child: Text(guaranteeing, style: claimTextStyle),),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 27),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(guaranteeingName),
                                        TextField(
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderSide:
                                                  BorderSide(color: inputBorder))),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 27),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text("Тип договора:"),
                                        CustomDropDown(title: "Выберите причину", items: [
                                          "Договор электроснабжения",
                                          "Договор купли-продажи"
                                        ])
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.9,
                                      height: 55.0,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder:  (context) =>  NewClaimStep6()));
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
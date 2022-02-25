import 'dart:ui';

import 'package:conres_app/elements/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../consts.dart';
import '../../elements/masks.dart';
import '../../icons.dart';
import '../../profile/profile-no-ls.dart';
import 'new-claim-step-2.dart';

class NewClaimStep1 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _NewClaimStep1();
}

class _NewClaimStep1 extends State<NewClaimStep1>{
  final controllerList = List<TextEditingController>.generate(9, (index) => TextEditingController());
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                    HeaderRow(claimStep1, 24, true),
                    Column(
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(margin: EdgeInsets.fromLTRB(0, 25, 0, 10),
                              child: Text(claimInfo, style: claimTextStyle)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(fio,
                                      style: labelTextStyle),
                                  TextField(
                                    controller: controllerList[0],
                                    decoration: InputDecoration(
                                      hintText: "Иванов Иван Иванович",
                                        border: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(color: inputBorder))),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(factAddress,
                                          style: TextStyle(
                                              color: colorGray, fontSize: 16.0)),
                                      TextField(
                                        controller: controllerList[1],
                                        decoration: InputDecoration(
                                          hintText: "Город, Улица, Дом, Квартира",
                                            border: OutlineInputBorder(
                                                borderSide:
                                                BorderSide(color: inputBorder))),
                                      )
                                    ],
                                  )),
                            ],
                          )
                        )
                        ,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(margin: EdgeInsets.fromLTRB(0, 25, 0, 10),
                              child: Text(passportData, style: claimTextStyle),),
                            Row(
                              children: [
                                Container(
                                  width: 158,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(seriesPassport),
                                      MaskInput(
                                        textController: controllerList[2],
                                        formatter: MaskTextInputFormatter(mask: "####"),
                                        hint: "0000",
                                      ),

                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  width: 158,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(numberPassport),
                                      MaskInput(
                                        textController: controllerList[3],
                                        formatter: MaskTextInputFormatter(mask: "######"),
                                        hint: "000000",
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 12, 0, 18),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(place,
                                        style: labelTextStyle),
                                    TextField(
                                      controller: controllerList[4],
                                      decoration: InputDecoration(
                                        hintText: "Место выдачи",
                                          border: OutlineInputBorder(
                                              borderSide:
                                              BorderSide(color: inputBorder))),
                                    )
                                  ],
                                )),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(date,
                                        style: TextStyle(
                                            color: colorGray, fontSize: 16.0)),
                                    MaskInput(
                                      textController: controllerList[5],
                                      formatter: MaskTextInputFormatter(mask: "##.##.####"),
                                      hint: "01.01.2020",
                                    )
                                  ],
                                )),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 55.0,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder:  (context) =>  NewClaimStep2()));
                                    },
                                    child: Text(
                                      next,
                                      style: buttonTextStyle,
                                    ),
                                    style: ElevatedButton.styleFrom(primary: colorMain))),


                          ],
                        ),

                      ],
                    ),


                  ],
                ))
          ],
        ),
      )
,
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.home, color: colorGray),
                label: mainPage),
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.contracts, color: colorGray),
                label: contractsPage),
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.reports, color: colorGray),
                label: reportsPage),
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.chat, color: colorGray),
                label: chatPage),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: colorMain,
          onTap: _onItemTapped),
    );
  }

}
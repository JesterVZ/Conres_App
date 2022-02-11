import 'dart:ui';

import 'package:conres_app/elements/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../consts.dart';
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
  int _selectedIndex = 0;
  late bool _visabillity = false;

  void _addNewObject(){
    _visabillity = !_visabillity;
  }
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
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 23),
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
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 27),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(stage),
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
                                          children: [
                                            Text(desighTime),
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
                                          children: [
                                            Text(inputTime),
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
                                          children: [
                                            Text(maxPowerDevices),
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
                                          children: [
                                            Text(reliabilityCategory),
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
                                  )),
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
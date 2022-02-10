import 'dart:ui';

import 'package:conres_app/elements/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../consts.dart';
import '../../icons.dart';
import '../../profile/profile-no-ls.dart';

class NewClaimStep2 extends StatefulWidget{
  const NewClaimStep2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewClaimStep2();
}

class _NewClaimStep2 extends State<NewClaimStep2>{
  int _selectedIndex = 0;
  late bool _visabillity = false;

  void _addNewObject(){
    setState(() {
      _visabillity = !_visabillity;
    });

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
                    HeaderRow(claimStep2, 24),
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
                                    child: ElevatedButton(
                                      onPressed: (){},
                                      child: Text(choose, style: labelTextStyle),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                            side: BorderSide(color: borderProfileColor)
                                        ),
                                      ),
                                    ),
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
                                          decoration: InputDecoration(
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
                                            decoration: InputDecoration(
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
                                          TextField(
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: inputBorder))),
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
                                                  decoration: InputDecoration(
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
                                                  decoration: InputDecoration(
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
                                                TextField(
                                                  decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                          borderSide:
                                                          BorderSide(color: inputBorder))),
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
                                            Navigator.push(context, MaterialPageRoute(builder:  (context) =>  NewClaimStep2()));
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
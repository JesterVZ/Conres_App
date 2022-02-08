import 'dart:ui';

import 'package:conres_app/elements/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';
import '../../icons.dart';
import '../../profile/profile-no-ls.dart';

class NewClaimStep1 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _NewClaimStep1();
}

class _NewClaimStep1 extends State<NewClaimStep1>{
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
                    HeaderRow(claimStep1, 24),
                    Column(
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(margin: EdgeInsets.fromLTRB(0, 25, 0, 10),
                              child: Text(claimInfo, style: claimTextStyle),),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(fio,
                                      style: TextStyle(
                                          color: colorGray, fontSize: 16.0)),
                                  TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(color: inputBorder))),
                                  )
                                ],
                              ),
                              Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(factAddress,
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
                                      TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide:
                                                BorderSide(color: inputBorder))),
                                      )
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
                                      TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide:
                                                BorderSide(color: inputBorder))),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(place,
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
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(date,
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
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 55.0,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder:  (context) => const ProfileNoLs()));
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
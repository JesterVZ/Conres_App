import 'dart:ui';

import 'package:conres_app/elements/header/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../consts.dart';
import 'new-claim-step-5.dart';

class NewClaimStep4 extends StatefulWidget{
  const NewClaimStep4({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewClaimStep4();
}

class _NewClaimStep4 extends State<NewClaimStep4>{
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
                    HeaderRow(text: claimStep4, fontSize: 24),
                    Column(
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(margin: EdgeInsets.fromLTRB(0, 25, 0, 10),
                              child: Text(terms, style: claimTextStyle),),
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
                                        Text(stage),
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: "1 очередь",
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
                                            hintText: "Июнь 2022",
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
                                            hintText: "Июнь 2022",
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
                                            hintText: "000",
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
                                            hintText: "1 или 2 или 3",
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
                                                hintText: "1 очередь",
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
                                                hintText: "Июнь 2022",
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
                                                hintText: "Июнь 2022",
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
                                                hintText: "000",
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
                                                hintText: "1 или 2 или 3",
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
                                            Navigator.push(context, MaterialPageRoute(builder:  (context) =>  NewClaimStep5()));
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
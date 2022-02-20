import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../consts.dart';
import 'new-ls/new-ls.dart';

class Contracts extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Contracts();
}

class _Contracts extends State<Contracts>{
  String thisLS = "345672309";
  String thisdate = "15.11.2021";
  String thisAddress = "г.Пермь, Транспортная 10, кв 2";
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
            Row(
              children: [
                Text(
                  contractsTitle,
                  style: const TextStyle(fontSize: 24),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: profileColor,
                  border: Border.all(color: borderProfileColor),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(19, 14, 19, 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(currentLs,
                                      style: TextStyle(
                                          color: profileLabelColor,
                                          fontSize: 15)),
                                  Text(thisLS,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18))
                                ],
                              ),
                              const Spacer(),
                              Container(
                                width: 40,
                                height: 40,
                                child: SvgPicture.asset("assets/fire.svg"),
                              )
                            ],
                          )
                          ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(dateAdded,
                                  style: TextStyle(
                                      color: profileLabelColor,
                                      fontSize: 15)),
                              Text(thisdate,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18))
                            ],
                          )),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(objectAddress,
                                  style: TextStyle(
                                      color: profileLabelColor,
                                      fontSize: 15)),
                              Text(thisAddress,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18))
                            ],
                          )),
                    ],
                  )),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: profileColor,
                  border: Border.all(color: borderProfileColor),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(19, 14, 19, 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(currentLs,
                                      style: TextStyle(
                                          color: profileLabelColor,
                                          fontSize: 15)),
                                  Text(thisLS,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18))
                                ],
                              ),
                              const Spacer(),
                              Container(
                                //width: 90,
                                //height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: redColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
                                  child: Text(closed, style: contractLabelTextStyle,)
                                )

                              ),

                            ],
                          )
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(dateAdded,
                                  style: TextStyle(
                                      color: profileLabelColor,
                                      fontSize: 15)),
                              Text(thisdate,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18))
                            ],
                          )),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(objectAddress,
                                  style: TextStyle(
                                      color: profileLabelColor,
                                      fontSize: 15)),
                              Text(thisAddress,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18))
                            ],
                          )),
                    ],
                  )),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: profileColor,
                  border: Border.all(color: borderProfileColor),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(19, 14, 19, 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(currentLs,
                                      style: TextStyle(
                                          color: profileLabelColor,
                                          fontSize: 15)),
                                  Text(thisLS,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18))
                                ],
                              ),
                              const Spacer(),
                              Container(
                                  //width: 145,
                                  //height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: colorGray,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
                                    child: Text(underConsideration, style: contractLabelTextStyle,)
                                  )

                              ),

                            ],
                          )
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(dateAdded,
                                  style: TextStyle(
                                      color: profileLabelColor,
                                      fontSize: 15)),
                              Text(thisdate,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18))
                            ],
                          )),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(objectAddress,
                                  style: TextStyle(
                                      color: profileLabelColor,
                                      fontSize: 15)),
                              Text(thisAddress,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18))
                            ],
                          )),
                    ],
                  )),
            ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 55,
          child: ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:  (context) =>  const NewLS()));
            },
            child: Text(linkNewLs, style: buttonTextStyle),
            style: ElevatedButton.styleFrom(
              primary: colorMain,shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
            )
            ),
          ),
        ),)
          ],
        ))


          ],
        ),
      )
    );
  }
}
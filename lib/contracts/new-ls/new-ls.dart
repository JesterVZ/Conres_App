import 'package:conres_app/elements/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';

class NewLS extends StatefulWidget{
  const NewLS({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewLS();
}

class _NewLS extends State<NewLS>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.fromLTRB(19, 59, 19, 23),
          child:
          Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderRow(newLs, 24, true),
                  Container(margin: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                    child: Text(linkNewLs, style: claimTextStyle),),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(numberLS,
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

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(objectAddress,
                          style: labelTextStyle),
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: inputBorder))),
                      )
                    ],
                  ),


                ],
              ),
              Positioned(
                  width: MediaQuery.of(context).size.width,
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: (){},
                      child: Text(sendLinkRequest, style: buttonTextStyle),
                      style: ElevatedButton.styleFrom(
                          primary: colorMain,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          )
                      ),
                    ),
                  ))
            ],
          ))
    );
  }
  
}
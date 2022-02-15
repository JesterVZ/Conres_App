import 'package:conres_app/elements/header-notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';
import '../elements/dropdown.dart';

class LinkPU extends StatefulWidget{
  const LinkPU({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LinkPU();
}

class _LinkPU extends State<LinkPU>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
        Padding(
        padding: EdgeInsets.fromLTRB(21, 58, 21, 54),
        child: Column(
          children: [
        Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 14),
        child: HeaderNotification(linkPU)),

            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(namePU,
                      style: TextStyle(
                          color: colorGray, fontSize: 16.0)),
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
                margin: EdgeInsets.fromLTRB(0, 0, 0, 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(numberPU,
                        style: TextStyle(
                            color: colorGray, fontSize: 16.0)),
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
                margin: EdgeInsets.fromLTRB(0, 0, 0, 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(numberPoint,
                        style: TextStyle(
                            color: colorGray, fontSize: 16.0)),
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
                margin: EdgeInsets.fromLTRB(0, 0, 0, 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(addressPoint,
                        style: TextStyle(
                            color: colorGray, fontSize: 16.0)),
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
                margin: EdgeInsets.fromLTRB(0, 0, 0, 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(typePU,
                        style: TextStyle(
                            color: colorGray, fontSize: 16.0)),
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
                margin: EdgeInsets.fromLTRB(0, 0, 0, 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(typePU,
                        style: TextStyle(
                            color: colorGray, fontSize: 16.0)),
                    const CustomDropDown(title: "Выберите тип", items: ["Тип 1", "Тип 3"],)
                  ],
                )
            ),

          ],
        ))

          ],
        ),
      )
    );
  }

}
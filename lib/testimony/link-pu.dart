import 'package:conres_app/elements/header-notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';
import '../elements/dropdown.dart';
import 'info-pu.dart';

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
                      hintText: namePU,
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
                        hintText: numberPU,
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
                        hintText: numberPoint,
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
                        hintText: addressPoint,
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
                        hintText: typePU,
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
                    const CustomDropDown(title: "Выберите тип", items: ["Электроэнергия", "Тепловая энергия", "Атомная энергия"],)
                  ],
                )
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tarifPU,
                        style: TextStyle(
                            color: colorGray, fontSize: 16.0)),
                    const CustomDropDown(title: "Выберите вид", items: ["Однофазный", "Двухфазный", "Трехфазный"],)
                  ],
                )
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(multi,
                        style: TextStyle(
                            color: colorGray, fontSize: 16.0)),
                    TextField(
                      decoration: InputDecoration(
                        hintText: multi,
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: inputBorder))),
                    )
                  ],
                )
            ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 27),
          width: MediaQuery.of(context).size.width,
          height: 55,
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder:  (context) =>  InfoPU()));
              },
              child: Text(
                  addRequest,
                  style: buttonTextStyle
              ),
              style: ElevatedButton.styleFrom(primary: colorMain, shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ))))


          ],
        ))

          ],
        ),
      )
    );
  }

}
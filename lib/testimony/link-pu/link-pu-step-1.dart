import 'package:conres_app/consts.dart';
import 'package:conres_app/testimony/link-pu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../elements/header/header-notification.dart';

class LinkPUStep1 extends StatefulWidget {
  const LinkPUStep1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LinkPUStep1();
}

class _LinkPUStep1 extends State<LinkPUStep1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 14),
              child: HeaderNotification(text: "Привязать ПУ")),
          Text("Выберите или введите новый объект",
              style: TextStyle(
                  fontSize: 18, color: colorMain, fontWeight: FontWeight.bold)),
          Text("Объект", style: TextStyle(fontSize: 16, color: colorGrayText)),
          Container(
            margin: EdgeInsets.only(top: 17),
            width: MediaQuery.of(context).size.width,
            height: 55,
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Выберите объект"),
              style: ElevatedButton.styleFrom(primary: colorMain),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 17),
            width: MediaQuery.of(context).size.width,
            height: 55,
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Добавить новый объект"),
              style: ElevatedButton.styleFrom(primary: colorMain),
            ),
          )
        ],
      ),
    ));
  }
}

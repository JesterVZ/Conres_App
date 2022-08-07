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
          Padding(
              padding: EdgeInsets.fromLTRB(
                  defaultSidePadding, 59, defaultSidePadding, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 14),
                      child: HeaderNotification(text: "Привязать ПУ")),
                  Text("Выберите или введите новый объект",
                      style: TextStyle(
                          fontSize: 18,
                          color: colorMain,
                          fontWeight: FontWeight.bold)),
                  Text("Объект",
                      style: TextStyle(fontSize: 16, color: colorGrayText)),
                  Container(
                    margin: EdgeInsets.only(top: 17),
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Выберите объект", style: TextStyle(color: colorMain, fontSize: 18),),
                      style: ElevatedButton.styleFrom(
                            backgroundColor: messageColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)))                      
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 17),
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Добавить новый объект", style: TextStyle(color: Colors.white, fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                            backgroundColor: colorMain,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)))
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    child: Row(
                    children: [
                      Container(
                        width: 160,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: (){},
                          child: Text("Отменить", style: TextStyle(color: colorGray, fontSize: 18),),
                           style: ElevatedButton.styleFrom(
                            backgroundColor: messageColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)))
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 160,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: (){},
                          child: Text("Далее", style: TextStyle(color: Colors.white, fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorMain,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)))
                        ),
                      )
                    ],
                  ),
                  )
                ],
              ))
        ],
      ),
    ));
  }
}

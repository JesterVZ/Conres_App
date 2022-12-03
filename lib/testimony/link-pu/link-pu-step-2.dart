import 'package:conres_app/testimony/link-pu/link-pu-step-3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../UI/default-button.dart';
import '../../UI/main-form.dart';
import '../../consts.dart';
import '../../elements/PU/list-element.dart';
import '../../elements/header/header-notification.dart';
import '../../elements/testimony/select-object-doalog.dart';

class LinkPUStep2 extends StatefulWidget {
  const LinkPUStep2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LinkPUStep2();
}

class _LinkPUStep2 extends State<LinkPUStep2> {
  Future<void> _refrash() async {}
  @override
  Widget build(BuildContext context) {
    return MainForm(
        header: HeaderNotification(text: "Привязать ПУ", canGoBack: true),
        body: Padding(
            padding: EdgeInsets.only(
                left: defaultSidePadding, right: defaultSidePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Выберите или укажите новую точку учета",
                    style: TextStyle(
                        color: colorMain,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text("Точка учета"),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              SelectObjectDialog());
                    },
                    child: Text("Выберите точку учета",
                        style: TextStyle(color: colorMain, fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: messageColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Column(
                  children: [
                    ListElement(
                      text: "№39915011 (Вильвенская 2)",
                    ),
                    ListElement(
                      text: "№39915011 (Вильвенская 2)",
                    )
                  ],
                ),
                DefaultButton(
                    text: "Добавить новую ТУ",
                    onPressed: () {
                      /*
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => ObjectPuDialog(
                                title: "Новый объект",
                              ));*/
                    },
                    isGetPadding: false)
              ],
            )),
        footer: Row(
          children: [
            Container(
                padding: EdgeInsets.only(
                  left: defaultSidePadding,
                ),
                width: 160,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Назад",
                      style: TextStyle(fontSize: 18, color: colorMain)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: messageColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                )),
            const Spacer(),
            Container(
                padding: EdgeInsets.only(right: defaultSidePadding),
                width: 160,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LinkPUStep3()));
                  },
                  child: const Text("Далее", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: colorMain,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                ))
          ],
        ),
        onRefrash: _refrash);
  }
}

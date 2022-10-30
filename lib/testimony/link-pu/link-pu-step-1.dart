import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/consts.dart';
import 'package:conres_app/testimony/link-pu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../elements/header/header-notification.dart';
import '../../elements/testimony/object-pu-dialog.dart';
import '../../elements/testimony/select-object-doalog.dart';

class LinkPUStep1 extends StatefulWidget {
  const LinkPUStep1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LinkPUStep1();
}

class _LinkPUStep1 extends State<LinkPUStep1> {
  Future<void> _refrash() async {}
  void _editPU() {}
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
                    "Выберите или введите новый объект",
                    style: TextStyle(
                        color: colorMain,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text("Объект"),
                Container(
                  margin: EdgeInsets.only(bottom: 17),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              SelectObjectDialog());
                    },
                    child: Text("Выберите объект",
                        style: TextStyle(color: colorMain, fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: messageColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                DefaultButton(
                    text: "Добавить новый объект",
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => ObjectPuDialog(
                                title: "Новый объект",
                                function: _editPU,
                              ));
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
                  child: Text("Отменить",
                      style: TextStyle(fontSize: 14, color: colorMain)),
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
                  onPressed: () {},
                  child: const Text("Далее", style: TextStyle(fontSize: 14)),
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

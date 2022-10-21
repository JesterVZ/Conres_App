import 'package:conres_app/UI/default-button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';

class ObjectPuDialog extends StatefulWidget {
  String? title;
  VoidCallback? function;
  ObjectPuDialog({required this.title, required this.function});
  @override
  State<StatefulWidget> createState() => _ObjectPuDialog();
}

class _ObjectPuDialog extends State<ObjectPuDialog> {
  double? value;
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(widget.title!),
        content: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            height: 280,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Column(children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Наименование объекта",
                          style: TextStyle(color: colorGray, fontSize: 16.0)),
                      TextField(
                        controller: name,
                        decoration: InputDecoration(
                            hintText: "Дом",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: inputBorder))),
                      )
                    ],
                  )),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Адрес объекта",
                          style: TextStyle(color: colorGray, fontSize: 16.0)),
                      TextField(
                        controller: name,
                        decoration: InputDecoration(
                            hintText: "Город, Улица, Дом, Квартира",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: inputBorder))),
                      )
                    ],
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 55,
                child: DefaultButton(
                  isGetPadding: false,
                  onPressed: () {
                      widget.function!.call();
                      Navigator.pop(context);
                    }, text: "Принять",)
              )
            ]),
          ),
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../UI/default-button.dart';
import '../../consts.dart';

class EditTuDialog extends StatefulWidget {
  String? title;
  VoidCallback? function;
  EditTuDialog({required this.function, required this.title});
  @override
  State<StatefulWidget> createState() => _EditTuDialog();
}

class _EditTuDialog extends State<EditTuDialog> {
  TextEditingController numberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(widget.title!),
        content: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            height: 350,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Column(children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Номер ТУ",
                          style: TextStyle(color: colorGray, fontSize: 16.0)),
                      TextField(
                        controller: numberController,
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
                      Text("Наименование ТУ",
                          style: TextStyle(color: colorGray, fontSize: 16.0)),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            hintText: "Наименование",
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
                      Text("Адрес ТУ",
                          style: TextStyle(color: colorGray, fontSize: 16.0)),
                      TextField(
                        controller: addressController,
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
                    },
                    text: "Принять",
                  ))
            ]),
          ),
        ));
  }
}

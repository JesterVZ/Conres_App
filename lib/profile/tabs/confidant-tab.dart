import 'package:conres_app/model/user-information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../consts.dart';

class ConfidantTab extends StatefulWidget {
  UserInformation? userInformation;
  ConfidantTab({
    this.userInformation
  });
  @override
  State<StatefulWidget> createState() => _ConfidantTab();
}

class _ConfidantTab extends State<ConfidantTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ]),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(bottom: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ФИО доверенного лица",
                                        style:
                                            TextStyle(color: colorGrayClaim)),
                                    const Text("Иванов2 Иван Иванович",
                                        style: TextStyle(color: Colors.black)),
                                  ],
                                )),
                            Container(
                                margin: EdgeInsets.only(bottom: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("E-mail доверенного лица",
                                        style:
                                            TextStyle(color: colorGrayClaim)),
                                    const Text("ahiro2011@gmail.com",
                                        style: TextStyle(color: Colors.black)),
                                  ],
                                )),
                            Container(
                                margin: EdgeInsets.only(bottom: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Телефон доверенного лица",
                                        style:
                                            TextStyle(color: colorGrayClaim)),
                                    const Text("+7 (919) 466-45-92",
                                        style: TextStyle(color: Colors.black)),
                                  ],
                                ))
                          ],
                        ),
                      )),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Редактировать"),
                      style: ElevatedButton.styleFrom(
                          primary: colorMain,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)))),
                ),
              ],
            ),
          ),
        ));
  }
}

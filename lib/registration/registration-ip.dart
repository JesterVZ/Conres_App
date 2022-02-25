import 'package:conres_app/model/model.dart';
import 'package:conres_app/registration/seccessful-registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../consts.dart';
import '../elements/header.dart';
import '../elements/masks.dart';

class RegIP extends StatefulWidget {
  const RegIP({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegIP();
}

class _RegIP extends State<RegIP> {
  final controllerList = List<TextEditingController>.generate(9, (index) => TextEditingController());
  final controllerDlList = List<TextEditingController>.generate(5, (index) => TextEditingController());
  late bool _agree = false;
  late bool _visabillity = false;

  void _addNewConfidant(){
    _visabillity = !_visabillity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(21, 70, 21, 54),
                child: Column(
                  children: [
                    HeaderRow(regTitle, 34, false),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 38, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(familyIP,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            TextField(
                              controller: controllerList[0],
                              decoration: InputDecoration(
                                hintText: "Иванов",
                                  border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: inputBorder))),
                            )
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(nameIP,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            TextField(
                              controller: controllerList[1],
                              decoration: InputDecoration(
                                hintText: "Иван",
                                  border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: inputBorder))),
                            )
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(patronymicIP,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            TextField(
                              controller: controllerList[2],
                              decoration: InputDecoration(
                                hintText: "Иванович",
                                  border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: inputBorder))),
                            )
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(inn,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            MaskInput(
                              textController: controllerList[3],
                              formatter: MaskTextInputFormatter(mask: "############"),
                              hint: "000000000000",
                            )
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ofrnip,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            MaskInput(
                              textController: controllerList[4],
                              formatter: MaskTextInputFormatter(mask: "###############"),
                              hint: "000000000000000",
                            )
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(contacts,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            MaskInput(
                              textController: controllerList[5],
                              formatter: MaskTextInputFormatter(mask: "+# (###) ###-##-##"),
                              hint: "+7 (___) - ___ - __ - __",
                            )
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(email,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            TextField(
                              controller: controllerList[6],
                              decoration: InputDecoration(
                                hintText: "example@email.ru",
                                  border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: inputBorder))),
                            )
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: Column(
                          children: [
                            Container(
                              height: 55,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: Colors.white),
                                  onPressed: (){
                                  setState(() {
                                    _addNewConfidant();
                                  });

                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                        child: _visabillity ? SvgPicture.asset('assets/minus.svg') : SvgPicture.asset('assets/plus.svg')
                                      ),


                                      Text(confidant, style: TextStyle(color: colorMain, fontSize: 18))
                                    ],
                                  ))
                            ),
                            Visibility(
                              visible: _visabillity,
                                child: Column(
                              children: [
                                Container(
                                    margin: const EdgeInsets.fromLTRB(0, 38, 0, 18),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(familyDL,
                                            style: TextStyle(
                                                color: colorGray, fontSize: 16.0)),
                                        TextField(
                                          controller: controllerDlList[0],
                                          decoration: InputDecoration(
                                            hintText: "Иванов",
                                              border: OutlineInputBorder(
                                                  borderSide:
                                                  BorderSide(color: inputBorder))),
                                        )
                                      ],
                                    )),
                                Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(nameDL,
                                            style: TextStyle(
                                                color: colorGray, fontSize: 16.0)),
                                        TextField(
                                          controller: controllerDlList[1],
                                          decoration: InputDecoration(
                                            hintText: "Иван",
                                              border: OutlineInputBorder(
                                                  borderSide:
                                                  BorderSide(color: inputBorder))),
                                        )
                                      ],
                                    )),
                                Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(patronymicDL,
                                            style: TextStyle(
                                                color: colorGray, fontSize: 16.0)),
                                        TextField(
                                          controller: controllerDlList[2],
                                          decoration: InputDecoration(
                                            hintText: "Иванович",
                                              border: OutlineInputBorder(
                                                  borderSide:
                                                  BorderSide(color: inputBorder))),
                                        )
                                      ],
                                    )),
                                Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(telDL,
                                            style: TextStyle(
                                                color: colorGray, fontSize: 16.0)),
                                        MaskInput(
                                          textController: controllerDlList[3],
                                          formatter: MaskTextInputFormatter(mask: "+# (###) ###-##-##"),
                                          hint: "+7 (___) - ___ - __ - __",
                                        )
                                      ],
                                    )),
                                Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(emailDL,
                                            style: TextStyle(
                                                color: colorGray, fontSize: 16.0)),
                                        TextField(
                                          controller: controllerDlList[4],
                                          decoration: InputDecoration(
                                            hintText: "example@email.ru",
                                              border: OutlineInputBorder(
                                                  borderSide:
                                                  BorderSide(color: inputBorder))),
                                        )
                                      ],
                                    )),
                                Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                    color: colorMain
                                  ),
                                )
                              ],
                            )
                            )


                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(lkPasswordText,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            TextField(
                              controller: controllerList[7],
                              autofocus: false,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Ваш пароль",
                                  border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: inputBorder))),
                            )
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(repeatPassword,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            TextField(
                              controller: controllerList[8],
                              autofocus: false,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Повторите пароль",
                                  border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: inputBorder))),
                            )
                          ],
                        )),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                      child: Row(
                        children: [
                          Checkbox(
                              value: _agree,

                              activeColor: colorMain,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                              onChanged: (value){
                                setState(() {
                                  _agree = !_agree;
                                });
                              }),
                          Container(width: 284, child: Text("Я согласен на обработку персональных данных", style: TextStyle(fontSize: 15))),
                        ],
                      ),),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      child: ElevatedButton(
                          onPressed: () {
                            Ip ipObj = Ip(Family: Family, Name: Name, Patronymic: Patronymic, Password: Password, RepeatPassword: RepeatPassword)
                          },
                          child: Text(
                            login,
                            style: buttonTextStyle,
                          ),
                          style: ElevatedButton.styleFrom(primary: colorMain)),
                    )

                  ],
                ))
          ],
        ),
      ),
    );
  }
}

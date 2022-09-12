import 'dart:ui';

import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/elements/header/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../UI/default-input.dart';
import '../../consts.dart';
import '../../elements/claims/claim-step2-object.dart';
import '../../elements/claims/claim-step3-object.dart';
import '../../elements/masks.dart';
import 'new-claim-step-2.dart';
import 'new-claim-step-4.dart';

class NewClaimStep3 extends StatefulWidget {
  const NewClaimStep3({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewClaimStep3();
}

class _NewClaimStep3 extends State<NewClaimStep3> {
  final controllerList = List<TextEditingController>.generate(
      6, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();
  List<ClaimStep3Object> objects = [];

  void _addNewObject() {
    setState(() {
      objects.add(ClaimStep3Object(id: objects.length, deleteFunc: _delete));
    });
  }

  void _delete(int id) {
    setState(() {
      objects.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MainForm(
            header: HeaderRow(text: claimStep3, fontSize: 24),
            body: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 25, 0, 24),
                    child: Text(
                        "Максимальная мощность энергопринимающих устройств (присоединяемых и ранее присоединенных) составляет",
                        style: claimTextStyle),
                  ),
                  Container(
                    child: Text("Максимальная мощность (всего) на напряжении:",
                        style: TextStyle(color: colorGray, fontSize: 16)),
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 158,
                          child: DefaultInput(
                              controller: controllerList[0],
                              keyboardType: TextInputType.number,
                              labelText: "кВт",
                              hintText: "000",
                              validatorText: "Введите серию"),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 158,
                          child: DefaultInput(
                              controller: controllerList[1],
                              keyboardType: TextInputType.number,
                              labelText: "Вт",
                              hintText: "000",
                              validatorText: "Введите номер"),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Text("Вновь присоединяемая мощность на напряжении:",
                        style: TextStyle(color: colorGray, fontSize: 16)),
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 158,
                          child: DefaultInput(
                              controller: controllerList[2],
                              keyboardType: TextInputType.number,
                              labelText: "кВт",
                              hintText: "000",
                              validatorText: "Введите серию"),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 158,
                          child: DefaultInput(
                              controller: controllerList[3],
                              keyboardType: TextInputType.number,
                              labelText: "Вт",
                              hintText: "000",
                              validatorText: "Введите номер"),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Text("Ранее присоединяемая мощность на напряжении:",
                        style: TextStyle(color: colorGray, fontSize: 16)),
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 158,
                          child: DefaultInput(
                              controller: controllerList[4],
                              keyboardType: TextInputType.number,
                              labelText: "кВт",
                              hintText: "000",
                              validatorText: "Введите серию"),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 158,
                          child: DefaultInput(
                              controller: controllerList[5],
                              keyboardType: TextInputType.number,
                              labelText: "Вт",
                              hintText: "000",
                              validatorText: "Введите номер"),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: objects,
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 24, 0, 24),
                      height: 55,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {
                            _addNewObject();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: SvgPicture.asset('assets/plus.svg')),
                              Text(addObject,
                                  style:
                                      TextStyle(color: colorMain, fontSize: 18))
                            ],
                          ))),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 55.0,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewClaimStep4()));
                          },
                          child: Text(
                            next,
                            style: buttonTextStyle,
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colorMain))),
                ],
              ),
            )));
  }
}

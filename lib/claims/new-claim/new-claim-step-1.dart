import 'package:conres_app/elements/header/header.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';
import '../../UI/default-input.dart';
import '../../consts.dart';
import '../../elements/datetime/datetime-dialog-picker.dart';
import '../../elements/masks.dart';
import 'new-claim-step-2.dart';

class NewClaimStep1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewClaimStep1();
}

class _NewClaimStep1 extends State<NewClaimStep1> {
  final controllerList = List<TextEditingController>.generate(
      9, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          defaultSidePadding, 59, defaultSidePadding, 0),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              HeaderRow(text: claimStep1, fontSize: 24),
                              Column(
                                children: [
                                  SizedBox(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 25, 0, 10),
                                          child: Text(claimInfo,
                                              style: claimTextStyle)),
                                      DefaultInput(
                                          controller: controllerList[0],
                                          keyboardType: TextInputType.text,
                                          labelText: "ФИО",
                                          hintText: "Иванов Иван Иванович",
                                          validatorText: "Введите ФИО"),
                                      DefaultInput(
                                          controller: controllerList[1],
                                          keyboardType: TextInputType.text,
                                          labelText: "Фактический адрес",
                                          hintText:
                                              "Город, Улица, Дом, Квартира",
                                          validatorText: "Введите адрес"),
                                    ],
                                  )),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 25, 0, 10),
                                        child: Text("Паспортные данные",
                                            style: claimTextStyle),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 158,
                                            child: DefaultInput(
                                                controller: controllerList[2],
                                                keyboardType:
                                                    TextInputType.number,
                                                labelText: "Серия",
                                                hintText: "0000",
                                                validatorText: "Введите ФИО"),
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            width: 158,
                                            child: DefaultInput(
                                                controller: controllerList[3],
                                                keyboardType:
                                                    TextInputType.number,
                                                labelText: "Номер",
                                                hintText: "000000",
                                                validatorText: "Введите номер"),
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 12, 0, 18),
                                        child: DefaultInput(
                                            controller: controllerList[4],
                                            keyboardType: TextInputType.number,
                                            labelText: "Кем выдан",
                                            hintText: "Место выдачи",
                                            validatorText:
                                                "Введите место выдачи"),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 18),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(date,
                                                  style: TextStyle(
                                                      color: colorGray,
                                                      fontSize: 16.0)),
                                              BasicDateField(
                                                  controller: controllerList[5],
                                                  format:
                                                      DateFormat("dd.MM.yyyy"))
                                            ],
                                          )),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          height: 55.0,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              NewClaimStep2(
                                                                  controllerList:
                                                                      controllerList)));
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              NewClaimStep2(
                                                                  controllerList:
                                                                      controllerList)));
                                                }
                                              },
                                              child: Text(
                                                next,
                                                style: buttonTextStyle,
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: colorMain))),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )))
                ],
              ),
            )));
  }
}

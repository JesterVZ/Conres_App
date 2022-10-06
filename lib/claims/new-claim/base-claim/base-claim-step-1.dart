import 'package:conres_app/claims/new-claim/base-claim/base-claim-step-2.dart';
import 'package:conres_app/elements/header/header.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';

import '../../../UI/default-input.dart';
import '../../../UI/main-form.dart';
import '../../../consts.dart';
import '../../../elements/datetime/datetime-dialog-picker.dart';

class BaseClaimStep1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BaseClaimStep1();
}

class _BaseClaimStep1 extends State<BaseClaimStep1> {
  final controllerList = List<TextEditingController>.generate(
      9, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MainForm(
            header: HeaderRow(text: claimStep1, fontSize: 24),
            body: Form(
              key: _formKey,
              child: Column(
              children: [
                SizedBox(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                        child: Text(claimInfo, style: claimTextStyle)),
                    DefaultInput(
                        controller: controllerList[0],
                        keyboardType: TextInputType.text,
                        labelText: "Полное наименование организации",
                        hintText: "ООО Потребитель",
                        validatorText: "Введите наименование организации"),
                    DefaultInput(
                        controller: controllerList[1],
                        keyboardType: TextInputType.text,
                        labelText: "Фактический адрес",
                        hintText: "Город, Улица, Дом, Квартира",
                        validatorText: "Введите адрес"),
                    DefaultInput(
                        controller: controllerList[1],
                        keyboardType: TextInputType.text,
                        labelText: "Юридические адрес",
                        hintText: "Город, Улица, Дом, Квартира",
                        validatorText: "Введите адрес"),
                    DefaultInput(
                        controller: controllerList[1],
                        keyboardType: TextInputType.text,
                        labelText: "ОГРН",
                        hintText: "0000000000000",
                        validatorText: "Введите огрн"),
                    DefaultInput(
                        controller: controllerList[1],
                        keyboardType: TextInputType.text,
                        labelText: "Телефон",
                        hintText: "+7 (999)-000-00-00",
                        validatorText: "Введите огрн"),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Дата внесения в реестр",
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            BasicDateField(
                                controller: controllerList[5],
                                format: DateFormat("dd.MM.yyyy"))
                          ],
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 55.0,
                        child: ElevatedButton(
                          
                            onPressed: () {
                              Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BaseClaimStep2(
                                            )));


                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BaseClaimStep2(
                                            )));
                              }
                            },
                            child: Text(
                              next,
                              style: buttonTextStyle,
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: colorMain))),
                  ],
                )),
              ],
            )
            )
            ));
  }
}

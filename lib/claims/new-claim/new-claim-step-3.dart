import 'dart:ui';

import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/elements/header/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../UI/default-input.dart';
import '../../consts.dart';
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
      3, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();
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
                    child: Text("Максимальная мощность (всего) на напряжении:", style: TextStyle(color: colorGray, fontSize: 16)),
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 158,
                          child: DefaultInput(
                              controller: controllerList[2],
                              keyboardType: TextInputType.number,
                              labelText: "Серия",
                              hintText: "0000",
                              validatorText: "Введите серию"),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 158,
                          child: DefaultInput(
                              controller: controllerList[3],
                              keyboardType: TextInputType.number,
                              labelText: "Номер",
                              hintText: "000000",
                              validatorText: "Введите номер"),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}

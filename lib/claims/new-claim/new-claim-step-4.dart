import 'dart:ui';

import 'package:conres_app/elements/header/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../UI/default-input.dart';
import '../../UI/main-form.dart';
import '../../consts.dart';
import '../../elements/claims/claim-step5-object.dart';
import 'new-claim-step-5.dart';

class NewClaimStep4 extends StatefulWidget {
  const NewClaimStep4({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewClaimStep4();
}

class _NewClaimStep4 extends State<NewClaimStep4> {
  final controllerList = List<TextEditingController>.generate(
      6, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MainForm(
          header: HeaderRow(text: claimStep4, fontSize: 24),
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  child: DefaultInput(
                      controller: controllerList[0],
                      keyboardType: TextInputType.number,
                      labelText:
                          "Заявляемый характер нагрузки и наличие нагрузок, искажающих форму кривой электрического тока и вызывающих несимметрию напряжения в точках присоединения",
                      hintText: "",
                      validatorText: "Введите серию"),
                ),
                Container(
                  child: DefaultInput(
                      controller: controllerList[0],
                      keyboardType: TextInputType.number,
                      labelText:
                          "Величина и обоснование величины технологического минимума",
                      hintText: "",
                      validatorText: "Введите серию"),
                ),
                Container(
                  child: DefaultInput(
                      controller: controllerList[0],
                      keyboardType: TextInputType.number,
                      labelText:
                          "Необходимость наличия технологической и (или) аварийной брони",
                      hintText: "",
                      validatorText: "Введите серию"),
                ),
                Container(
                  child: DefaultInput(
                      controller: controllerList[0],
                      keyboardType: TextInputType.number,
                      labelText:
                          "Величина и обоснование технологической и аварийной брони",
                      hintText: "",
                      validatorText: "Введите серию"),
                ),
                Container(
                  child: DefaultInput(
                      controller: controllerList[0],
                      keyboardType: TextInputType.number,
                      labelText:
                          "Количество и мощность присоединяемых к сети трансформаторов",
                      hintText: "",
                      validatorText: "Введите серию"),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 26),
                  child: DefaultInput(
                      controller: controllerList[0],
                      keyboardType: TextInputType.number,
                      labelText:
                          "Количество и мощность генераторов",
                      hintText: "",
                      validatorText: "Введите серию"),
                ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 55.0,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewClaimStep5()));
                          },
                          child: Text(
                            next,
                            style: buttonTextStyle,
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colorMain))),
              ],
            ),
          ),
        ));
  }
}

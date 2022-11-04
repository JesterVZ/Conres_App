import 'dart:ui';

import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/elements/header/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Services/main-claim-send-service.dart';
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
  MainClaimSendService? mainClaimSendService;

  Future<void> _refrash() async {}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MainForm(
            onRefrash: _refrash,
            header: HeaderRow(text: claimStep4, fontSize: 24),
            body: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.only(
                  left: defaultSidePadding, right: defaultSidePadding),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 24),
                      child: DefaultInput(
                          controller: controllerList[0],
                          keyboardType: TextInputType.number,
                          labelText:
                              "Заявляемый характер нагрузки и наличие нагрузок, искажающих форму кривой электрического тока и вызывающих несимметрию напряжения в точках присоединения",
                          hintText: "",
                          validatorText: "Введите серию"),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 24),
                      child: DefaultInput(
                          controller: controllerList[1],
                          keyboardType: TextInputType.number,
                          labelText:
                              "Величина и обоснование величины технологического минимума",
                          hintText: "",
                          validatorText: "Введите серию"),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 24),
                      child: DefaultInput(
                          controller: controllerList[2],
                          keyboardType: TextInputType.number,
                          labelText:
                              "Необходимость наличия технологической и (или) аварийной брони",
                          hintText: "",
                          validatorText: "Введите серию"),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 24),
                      child: DefaultInput(
                          controller: controllerList[3],
                          keyboardType: TextInputType.number,
                          labelText:
                              "Величина и обоснование технологической и аварийной брони",
                          hintText: "",
                          validatorText: "Введите серию"),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 24),
                      child: DefaultInput(
                          controller: controllerList[4],
                          keyboardType: TextInputType.number,
                          labelText:
                              "Количество и мощность присоединяемых к сети трансформаторов",
                          hintText: "",
                          validatorText: "Введите серию"),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 24),
                      child: DefaultInput(
                          controller: controllerList[5],
                          keyboardType: TextInputType.number,
                          labelText: "Количество и мощность генераторов",
                          hintText: "",
                          validatorText: "Введите серию"),
                    ),
                    DefaultButton(
                      text: "Далее",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewClaimStep5()));
                        if (_formKey.currentState!.validate()) {
                          mainClaimSendService!.field_load_nature =
                              controllerList[0].text;
                          mainClaimSendService!.field_tech_min =
                              controllerList[1].text;
                          mainClaimSendService!.field_emergency_armor_needed =
                              controllerList[2].text;
                          mainClaimSendService!.field_emergency_armor_count =
                              controllerList[3].text;
                          mainClaimSendService!.field_count_power_transformer =
                              controllerList[4].text;
                          mainClaimSendService!.field_count_power_generator =
                              controllerList[5].text;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewClaimStep5()));
                        }
                      },
                      isGetPadding: false,
                      margin: EdgeInsets.only(top: 12),
                    )
                  ],
                ),
              ),
            ))));
  }

  @override
  void didChangeDependencies() {
    mainClaimSendService ??=
        DependencyProvider.of(context)!.mainClaimSendService;
    super.didChangeDependencies();
  }
}

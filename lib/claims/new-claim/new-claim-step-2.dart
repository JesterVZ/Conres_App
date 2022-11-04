import 'dart:ui';

import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/elements/header/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../DI/dependency-provider.dart';
import '../../Services/main-claim-send-service.dart';
import '../../UI/default-input.dart';
import '../../UI/main-form.dart';
import '../../consts.dart';
import '../../elements/claims/claim-step2-object.dart';
import '../../elements/dropdown.dart';
import '../../elements/masks.dart';
import '../../model/claims/claim-step-2-object.dart';
import 'new-claim-step-3.dart';

class NewClaimStep2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewClaimStep2();
}

class _NewClaimStep2 extends State<NewClaimStep2> {
  final controllerList = List<TextEditingController>.generate(
      3, (index) => TextEditingController());

  final _formKey = GlobalKey<FormState>();
  List<ClaimStep2Object> objects = [];
  TextEditingController reasonController = TextEditingController();
  MainClaimSendService? mainClaimSendService;

  void _addNewObject() {
    setState(() {
      objects.add(ClaimStep2Object(id: objects.length, deleteFunc: _delete));
    });
  }

  void _delete(int id) {
    setState(() {
      objects.removeWhere((element) => element.id == id);
    });
  }

  Future<void> _refrash() async {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MainForm(
            onRefrash: _refrash,
            header: HeaderRow(text: claimStep2, fontSize: 24),
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: defaultSidePadding, right: defaultSidePadding),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 25, 0, 10),
                                child: Text(
                                    "Заявление на присоединение энергопринимающих устройств",
                                    style: claimTextStyle),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cause, style: labelTextStyle),
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: CustomDropDown(
                                        selectedItem: reasonController,
                                        title: "Выберите причину",
                                        items: const [
                                          "увеличением объема максимальной мощности",
                                          "новым строительством",
                                          "изменением категории надежности электроснабжения",
                                          "другое"
                                        ],
                                      )),
                                  Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 28),
                                      child: Text(
                                        warning,
                                        style: warningTextStyle,
                                        textAlign: TextAlign.center,
                                      )),
                                  DefaultInput(
                                      controller: controllerList[0],
                                      keyboardType: TextInputType.text,
                                      labelText: "Наименование объекта",
                                      hintText: "Наименование объекта",
                                      validatorText:
                                          "Введите наименование объекта"),
                                  DefaultInput(
                                      controller: controllerList[1],
                                      keyboardType: TextInputType.text,
                                      labelText: "Адрес объекта",
                                      hintText: "Адрес объекта",
                                      validatorText: "Введите адрес объекта"),
                                  DefaultInput(
                                      controller: controllerList[2],
                                      keyboardType: TextInputType.text,
                                      labelText:
                                          "Кадастровый номер (необязательно)",
                                      hintText: "00:00:0000000:000",
                                      validatorText:
                                          "Введите кадастровый номер"),
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
                                            setState(() {
                                              _addNewObject();
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 10, 0),
                                                  child: SvgPicture.asset(
                                                      'assets/plus.svg')),
                                              Text(addObject,
                                                  style: TextStyle(
                                                      color: colorMain,
                                                      fontSize: 18))
                                            ],
                                          ))),
                                  DefaultButton(
                                      text: "Далее",
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NewClaimStep3()));

                                        if (_formKey.currentState!.validate()) {
                                          List<ClaimStep2TableObject>
                                              tableObjects = [];
                                          tableObjects.add(
                                              ClaimStep2TableObject(
                                                  address:
                                                      controllerList[1].text,
                                                  kadastr:
                                                      controllerList[2].text,
                                                  name:
                                                      controllerList[0].text));

                                          mainClaimSendService!.reason =
                                              reasonController.text;
                                          mainClaimSendService!.step2Object =
                                              tableObjects;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewClaimStep3()));
                                        }
                                      },
                                      isGetPadding: false)
                                ],
                              )
                            ],
                          ))
                        ],
                      ),
                    )))));
  }

  @override
  void didChangeDependencies() {
    mainClaimSendService ??=
        DependencyProvider.of(context)!.mainClaimSendService;
    super.didChangeDependencies();
  }
}

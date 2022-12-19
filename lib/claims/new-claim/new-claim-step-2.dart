import 'dart:ui';

import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/elements/header/header.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
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

  List dropdownReasonList = [
    {'label': 'увеличением объема максимальной мощности', 'value': '1'},
    {'label': 'новым строительством', 'value': '2'},
    {'label': 'изменением категории надежности электроснабжения', 'value': '3'},
    {'label': 'другое', 'value': '4'},
  ];

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
                                  CoolDropdown(
                                    resultHeight: 55,
                                    resultTS: TextStyle(
                                      fontSize: 20,
                                      color: colorMain,
                                    ),
                                    resultBD: BoxDecoration(
                                      color: messageColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    selectedItemBD: BoxDecoration(
                                      color: messageColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    selectedItemTS: TextStyle(
                                      fontSize: 20,
                                      color: colorMain,
                                    ),
                                    dropdownBD: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Color.fromARGB(255, 49, 49, 49)
                                                    .withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 10,
                                            offset: Offset(0, 1),
                                          ),
                                        ]),
                                    dropdownWidth:
                                        MediaQuery.of(context).size.width - 50,
                                    resultWidth:
                                        MediaQuery.of(context).size.width,
                                    dropdownList: dropdownReasonList,
                                    defaultValue: dropdownReasonList[0],
                                    onChange: (value) {
                                      reasonController.text = value['label'];
                                    },
                                    //defaultValue: dropdownObjectsList[0],
                                  ),
                                  /*
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
                                      )),*/
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
                                      validatorText:
                                          "Введите адрес объекта"),
                                  DefaultInput(
                                      controller: controllerList[2],
                                      keyboardType: TextInputType.text,
                                      labelText: "Кадастровый номер (необязательно)",
                                      hintText: "00:00:000000:00",
                                      textInputFormatter: MaskTextInputFormatter(
                                                  mask: "##:##:######:##"),
                                      ),
                                  
                                  Column(
                                    children: objects,
                                  ),
                                  DefaultButton(
                                    margin: const EdgeInsets.only(bottom: 24),
                                    backgroundColor: messageColor,
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
                                          ), 
                                    onPressed: () {
                                            setState(() {
                                              _addNewObject();
                                            });
                                          }, 
                                    isGetPadding: false),
                                  
                                  DefaultButton(
                                      text: "Далее",
                                      onPressed: () {
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
    reasonController.text = dropdownReasonList[0]['label'];
    super.didChangeDependencies();
  }
}

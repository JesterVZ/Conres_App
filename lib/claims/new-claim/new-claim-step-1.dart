// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:conres_app/Services/profile-service.dart';
import 'package:conres_app/elements/header/header.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';
import '../../DI/dependency-provider.dart';
import '../../Services/main-claim-send-service.dart';
import '../../UI/default-button.dart';
import '../../UI/default-input.dart';
import '../../UI/main-form.dart';
import '../../consts.dart';
import '../../elements/datetime/datetime-dialog-picker.dart';
import '../../elements/masks.dart';
import 'new-claim-step-2.dart';

class NewClaimStep1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewClaimStep1();
}

class _NewClaimStep1 extends State<NewClaimStep1> {
  TextEditingController nameController =
      TextEditingController(); //фио или наименование организации
  TextEditingController ogrnController =
      TextEditingController(); //ОГРН или ОГРНИП
  TextEditingController factAddressController =
      TextEditingController(); //фактический адрес
  TextEditingController urAddressController =
      TextEditingController(); //юридический адрес
  TextEditingController dateController =
      TextEditingController(); //Дата внесения в реестр
  TextEditingController phoneController = TextEditingController(); //телефон
  TextEditingController seriesController =
      TextEditingController(); //серия паспорта
  TextEditingController numberController =
      TextEditingController(); //номер паспорта
  TextEditingController placeController = TextEditingController(); //кем выдан

  final _formKey = GlobalKey<FormState>();
  MainClaimSendService? mainClaimSendService;
  ProfileService? profileService;

  Future<void> _refrash() async {}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MainForm(
            onRefrash: _refrash,
            header: HeaderRow(text: claimStep1, fontSize: 24),
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: defaultSidePadding, right: defaultSidePadding),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            //форма для ФЛ
                            Visibility(
                                visible: profileService!.userType == "fl"
                                    ? true
                                    : false,
                                child: Column(
                                  children: [
                                    SizedBox(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 25, 0, 10),
                                            child: Text(
                                                "Информация о заявителе",
                                                style: claimTextStyle)),
                                        DefaultInput(
                                            controller: nameController,
                                            keyboardType: TextInputType.text,
                                            labelText: "ФИО",
                                            hintText: "Иванов Иван Иванович",
                                            validatorText: "Введите ФИО"),
                                        DefaultInput(
                                            controller: factAddressController,
                                            keyboardType: TextInputType.text,
                                            labelText: "Фактический адрес",
                                            hintText:
                                                "Город, Улица, Дом, Квартира",
                                            validatorText: "Введите адрес"),
                                      ],
                                    )),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                  controller: seriesController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  labelText: "Серия",
                                                  hintText: "0000",
                                                  validatorText:
                                                      "Введите серию"),
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              width: 158,
                                              child: DefaultInput(
                                                  controller: numberController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  labelText: "Номер",
                                                  hintText: "000000",
                                                  validatorText:
                                                      "Введите номер"),
                                            )
                                          ],
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 12, 0, 18),
                                          child: DefaultInput(
                                              controller: placeController,
                                              keyboardType:
                                                  TextInputType.number,
                                              labelText: "Кем выдан",
                                              hintText: "Место выдачи",
                                              validatorText:
                                                  "Введите место выдачи"),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 12, 0, 18),
                                          child: DefaultInput(
                                              controller: phoneController,
                                              keyboardType:
                                                  TextInputType.number,
                                              labelText: "Телефон",
                                              hintText: "+7 (999)-000-00-00",
                                              validatorText: "Введите телефон"),
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
                                                Text("Дата выдачи",
                                                    style: TextStyle(
                                                        color: colorGray,
                                                        fontSize: 16.0)),
                                                BasicDateField(
                                                    controller: dateController,
                                                    format: DateFormat(
                                                        "dd.MM.yyyy"))
                                              ],
                                            )),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 55.0,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    mainClaimSendService!
                                                            .field_header_who =
                                                        nameController
                                                            .text; // фио либо полное название организации
                                                    mainClaimSendService!
                                                            .field_header_address_1 =
                                                        factAddressController
                                                            .text; // фактический адрес
                                                    mainClaimSendService!
                                                            .field_pass_serial =
                                                        seriesController
                                                            .text; //серия паспорта
                                                    mainClaimSendService!
                                                            .field_pass_number =
                                                        numberController
                                                            .text; //номер паспорта
                                                    mainClaimSendService!
                                                            .field_pass_giver =
                                                        placeController
                                                            .text; //кем выдан
                                                    mainClaimSendService!
                                                            .field_header_egrul_date =
                                                        dateController
                                                            .text; //дата выдачи
                                                    mainClaimSendService!
                                                            .field_phone =
                                                        phoneController
                                                            .text; //телефон
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                NewClaimStep2()));
                                                  }
                                                },
                                                child: Text(
                                                  next,
                                                  style: buttonTextStyle,
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        colorMain))),
                                      ],
                                    ),
                                  ],
                                )),
                            //форма для ИП
                            Visibility(
                                visible: profileService!.userType == "ip"
                                    ? true
                                    : false,
                                child: Column(
                                  children: [
                                    SizedBox(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 25, 0, 10),
                                            child: Text(
                                                "Информация о заявителе",
                                                style: claimTextStyle)),
                                        DefaultInput(
                                            controller: nameController,
                                            keyboardType: TextInputType.text,
                                            labelText: "ФИО",
                                            hintText: "Иванов Иван Иванович",
                                            validatorText: "Введите ФИО"),
                                        DefaultInput(
                                            controller: ogrnController,
                                            keyboardType: TextInputType.text,
                                            labelText: "ОГРНИП",
                                            hintText: "ОГРНИП",
                                            validatorText: "Введите ОГРНИП"),
                                        DefaultInput(
                                            controller: factAddressController,
                                            keyboardType: TextInputType.text,
                                            labelText: "Фактический адрес",
                                            hintText:
                                                "Город, Улица, Дом, Квартира",
                                            validatorText:
                                                "Введите фактический адрес"),
                                        DefaultInput(
                                            controller: urAddressController,
                                            keyboardType: TextInputType.text,
                                            labelText: "Юридический адрес",
                                            hintText:
                                                "Город, Улица, Дом, Квартира",
                                            validatorText:
                                                "Введите юридический адрес"),
                                        DefaultInput(
                                            controller: phoneController,
                                            keyboardType: TextInputType.text,
                                            labelText: "Телефон",
                                            hintText:
                                                "Город, Улица, Дом, Квартира",
                                            validatorText:
                                                "Введите юридический адрес"),
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
                                                    controller: dateController,
                                                    format: DateFormat(
                                                        "dd.MM.yyyy"))
                                              ],
                                            )),
                                        DefaultButton(
                                          isGetPadding: false,
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              mainClaimSendService!
                                                      .field_header_who =
                                                  nameController
                                                      .text; // фио либо полное название организации
                                              mainClaimSendService!
                                                      .field_header_egrul =
                                                  ogrnController.text; //ОГРНИП
                                              mainClaimSendService!
                                                      .field_header_address_1 =
                                                  factAddressController
                                                      .text; // фактический адрес
                                              mainClaimSendService!
                                                      .field_header_address_2 =
                                                  urAddressController
                                                      .text; // юридический адрес
                                              mainClaimSendService!
                                                      .field_header_address_2 =
                                                  urAddressController
                                                      .text; // юридический адрес
                                              mainClaimSendService!
                                                      .field_header_egrul_date =
                                                  dateController
                                                      .text; //дата внесения в реестр
                                              mainClaimSendService!
                                                      .field_phone =
                                                  phoneController
                                                      .text; //телефон
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NewClaimStep2()));
                                            }
                                          },
                                          text: "Далее",
                                        )
                                      ],
                                    )),
                                  ],
                                )),
                            //форма для ЮЛ
                            Visibility(
                                visible: profileService!.userType == "ul"
                                    ? true
                                    : false,
                                child: Column(
                                  children: [
                                    SizedBox(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 25, 0, 10),
                                            child: Text(
                                                "Информация о заявителе",
                                                style: claimTextStyle)),
                                        DefaultInput(
                                            controller: nameController,
                                            keyboardType: TextInputType.text,
                                            labelText:
                                                "Наименованое организации",
                                            hintText:
                                                "Наименованое организации",
                                            validatorText:
                                                "Введите наименованое организации"),
                                        DefaultInput(
                                            controller: ogrnController,
                                            keyboardType: TextInputType.text,
                                            labelText: "ОГРН",
                                            hintText: "ОГРН",
                                            validatorText: "Введите ОГРН"),
                                        DefaultInput(
                                            controller: factAddressController,
                                            keyboardType: TextInputType.text,
                                            labelText: "Фактический адрес",
                                            hintText:
                                                "Город, Улица, Дом, Квартира",
                                            validatorText:
                                                "Введите фактический адрес"),
                                        DefaultInput(
                                            controller: urAddressController,
                                            keyboardType: TextInputType.text,
                                            labelText: "Юридический адрес",
                                            hintText:
                                                "Город, Улица, Дом, Квартира",
                                            validatorText:
                                                "Введите юридический адрес"),
                                        DefaultInput(
                                            controller: phoneController,
                                            keyboardType: TextInputType.text,
                                            labelText: "Телефон",
                                            hintText:
                                                "Город, Улица, Дом, Квартира",
                                            validatorText:
                                                "Введите юридический адрес"),
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
                                                    controller: dateController,
                                                    format: DateFormat(
                                                        "dd.MM.yyyy"))
                                              ],
                                            )),
                                        DefaultButton(
                                          isGetPadding: false,
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              mainClaimSendService!
                                                      .field_header_who =
                                                  nameController
                                                      .text; // фио либо полное название организации
                                              mainClaimSendService!
                                                      .field_header_egrul =
                                                  ogrnController.text; //ОГРНИП
                                              mainClaimSendService!
                                                      .field_header_address_1 =
                                                  factAddressController
                                                      .text; // фактический адрес
                                              mainClaimSendService!
                                                      .field_header_address_2 =
                                                  urAddressController
                                                      .text; // юридический адрес
                                              mainClaimSendService!
                                                      .field_header_address_2 =
                                                  urAddressController
                                                      .text; // юридический адрес
                                              mainClaimSendService!
                                                      .field_header_egrul_date =
                                                  dateController
                                                      .text; //дата внесения в реестр
                                              mainClaimSendService!
                                                      .field_phone =
                                                  phoneController
                                                      .text; //телефон
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NewClaimStep2()));
                                            }
                                          },
                                          text: "Далее",
                                        )
                                      ],
                                    )),
                                  ],
                                ))
                          ],
                        ))))));
  }

  @override
  void didChangeDependencies() {
    mainClaimSendService ??=
        DependencyProvider.of(context)!.mainClaimSendService;
    profileService ??= DependencyProvider.of(context)!.profileService;
    super.didChangeDependencies();
  }
}

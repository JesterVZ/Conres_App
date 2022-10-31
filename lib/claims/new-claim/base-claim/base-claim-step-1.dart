import 'package:conres_app/claims/new-claim/base-claim/base-claim-step-2.dart';
import 'package:conres_app/elements/header/header.dart';
import 'package:conres_app/elements/masks.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../DI/dependency-provider.dart';
import '../../../Services/base-claim-send-service.dart';
import '../../../UI/default-input.dart';
import '../../../UI/main-form.dart';
import '../../../consts.dart';
import '../../../elements/datetime/datetime-dialog-picker.dart';

class BaseClaimStep1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BaseClaimStep1();
}

class _BaseClaimStep1 extends State<BaseClaimStep1> {
  BaseClaimSendService? baseClaimSendService;

  final controllerList = List<TextEditingController>.generate(
      9, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();

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
                            SizedBox(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 25, 0, 10),
                                    child:
                                        Text(claimInfo, style: claimTextStyle)),
                                DefaultInput(
                                    controller: controllerList[0],
                                    keyboardType: TextInputType.text,
                                    labelText:
                                        "Полное наименование организации",
                                    hintText: "ООО Потребитель",
                                    validatorText:
                                        "Введите наименование организации"),
                                DefaultInput(
                                    controller: controllerList[1],
                                    keyboardType: TextInputType.text,
                                    labelText: "Фактический адрес",
                                    hintText: "Город, Улица, Дом, Квартира",
                                    validatorText: "Введите адрес"),
                                DefaultInput(
                                    controller: controllerList[2],
                                    keyboardType: TextInputType.text,
                                    labelText: "Юридические адрес",
                                    hintText: "Город, Улица, Дом, Квартира",
                                    validatorText: "Введите адрес"),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("ОГРН",
                                          style: TextStyle(
                                              color: colorGray,
                                              fontSize: 16.0)),
                                      MaskInput(
                                          textController: controllerList[3],
                                          type: "ogrn",
                                          formatter: MaskTextInputFormatter(
                                              mask: "#############"),
                                          hint: "0000000000000")
                                    ]),
                                DefaultInput(
                                    controller: controllerList[4],
                                    keyboardType: TextInputType.text,
                                    labelText: "Телефон",
                                    hintText: "+7 (999)-000-00-00",
                                    validatorText: "Введите огрн"),
                                Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 18),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Дата внесения в реестр",
                                            style: TextStyle(
                                                color: colorGray,
                                                fontSize: 16.0)),
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            baseClaimSendService!
                                                    .field_header_who =
                                                controllerList[0].text;
                                            baseClaimSendService!
                                                    .field_header_egrul =
                                                controllerList[3].text;
                                            baseClaimSendService!
                                                    .field_header_address_1 =
                                                controllerList[1].text;
                                            baseClaimSendService!
                                                    .field_header_address_2 =
                                                controllerList[2].text;
                                            baseClaimSendService!
                                                    .field_header_egrul_date =
                                                controllerList[5].text;
                                            baseClaimSendService!.field_phone =
                                                controllerList[4].text;
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BaseClaimStep2()));
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
                        ))))));
  }

  @override
  void didChangeDependencies() {
    baseClaimSendService ??=
        DependencyProvider.of(context)!.baseClaimSendService;
    super.didChangeDependencies();
  }
}

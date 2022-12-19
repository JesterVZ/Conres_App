import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/Services/main-claim-send-service.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/elements/header/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../Services/profile-service.dart';
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
      //контроллеры под инпуты
      18,
      (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();
  List<ClaimStep3Object> objects = [];
  MainClaimSendService? mainClaimSendService;
  ProfileService? profileService;

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

  Future<void> _refrash() async {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MainForm(
            onRefrash: _refrash,
            header: HeaderRow(text: claimStep3, fontSize: 24),
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: defaultSidePadding, right: defaultSidePadding),
                    child: Form(
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
                            height: 20,
                            margin: EdgeInsets.only(bottom: 24),
                            child: Text("Категория надежности 3",
                                style:
                                    TextStyle(color: colorGray, fontSize: 16)),
                          ),
                          Container(
                            child: Text(
                                "Максимальная мощность (всего) на напряжении:",
                                style:
                                    TextStyle(color: colorGray, fontSize: 16)),
                          ),
                          Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: DefaultInput(
                                      controller: controllerList[0],
                                      keyboardType: TextInputType.number,
                                      labelText: "кВт",
                                      hintText: "000",
                                      validatorText: "Введите значение"),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: DefaultInput(
                                      controller: controllerList[1],
                                      keyboardType: TextInputType.number,
                                      labelText: "Вт",
                                      hintText: "000",
                                      validatorText: "Введите значение"),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Text(
                                "Вновь присоединяемая мощность на напряжении:",
                                style:
                                    TextStyle(color: colorGray, fontSize: 16)),
                          ),
                          Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: DefaultInput(
                                      controller: controllerList[2],
                                      keyboardType: TextInputType.number,
                                      labelText: "кВт",
                                      hintText: "000",
                                      validatorText: "Введите значение"),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: DefaultInput(
                                      controller: controllerList[3],
                                      keyboardType: TextInputType.number,
                                      labelText: "Вт",
                                      hintText: "000",
                                      validatorText: "Введите значение"),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Text(
                                "Ранее присоединяемая мощность на напряжении:",
                                style:
                                    TextStyle(color: colorGray, fontSize: 16)),
                          ),
                          Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: DefaultInput(
                                      controller: controllerList[4],
                                      keyboardType: TextInputType.number,
                                      labelText: "кВт",
                                      hintText: "000",
                                      validatorText: "Введите значение"),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: DefaultInput(
                                      controller: controllerList[5],
                                      keyboardType: TextInputType.number,
                                      labelText: "Вт",
                                      hintText: "000",
                                      validatorText: "Введите значение"),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: profileService!.userType == "ip" || profileService!.userType == "ul",
                            child: Column(children: [
                            Container(
                            height: 20,
                            margin: EdgeInsets.only(top: 24, bottom: 24),
                            child: Text("Категория надежности 2",
                                style:
                                    TextStyle(color: colorGray, fontSize: 16)),
                          ),
                          Container(
                            child: Text(
                                "Максимальная мощность (всего) на напряжении:",
                                style:
                                    TextStyle(color: colorGray, fontSize: 16)),
                          ),
                          Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: DefaultInput(
                                      controller: controllerList[6],
                                      keyboardType: TextInputType.number,
                                      labelText: "кВт",
                                      hintText: "000",
                                      validatorText: "Введите значение"),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: DefaultInput(
                                      controller: controllerList[7],
                                      keyboardType: TextInputType.number,
                                      labelText: "Вт",
                                      hintText: "000",
                                      validatorText: "Введите значение"),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Text(
                                "Вновь присоединяемая мощность на напряжении:",
                                style:
                                    TextStyle(color: colorGray, fontSize: 16)),
                          ),
                          Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: DefaultInput(
                                      controller: controllerList[8],
                                      keyboardType: TextInputType.number,
                                      labelText: "кВт",
                                      hintText: "000",
                                      validatorText: "Введите значение"),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: DefaultInput(
                                      controller: controllerList[9],
                                      keyboardType: TextInputType.number,
                                      labelText: "Вт",
                                      hintText: "000",
                                      validatorText: "Введите значение"),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Text(
                                "Ранее присоединяемая мощность на напряжении:",
                                style:
                                    TextStyle(color: colorGray, fontSize: 16)),
                          ),
                          Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: DefaultInput(
                                      controller: controllerList[10],
                                      keyboardType: TextInputType.number,
                                      labelText: "кВт",
                                      hintText: "000",
                                      validatorText: "Введите значение"),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: DefaultInput(
                                      controller: controllerList[11],
                                      keyboardType: TextInputType.number,
                                      labelText: "Вт",
                                      hintText: "000",
                                      validatorText: "Введите значение"),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 20,
                            margin: EdgeInsets.only(top: 24, bottom: 24),
                            child: Text("Категория надежности 1",
                                style:
                                    TextStyle(color: colorGray, fontSize: 16)),
                          ),
                          Container(
                            child: Text(
                                "Максимальная мощность (всего) на напряжении:",
                                style:
                                    TextStyle(color: colorGray, fontSize: 16)),
                          ),
                          Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: DefaultInput(
                                      controller: controllerList[12],
                                      keyboardType: TextInputType.number,
                                      labelText: "кВт",
                                      hintText: "000",
                                      validatorText: "Введите значение"),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: DefaultInput(
                                      controller: controllerList[13],
                                      keyboardType: TextInputType.number,
                                      labelText: "Вт",
                                      hintText: "000",
                                      validatorText: "Введите значение"),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Text(
                                "Вновь присоединяемая мощность на напряжении:",
                                style:
                                    TextStyle(color: colorGray, fontSize: 16)),
                          ),
                          Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: DefaultInput(
                                      controller: controllerList[14],
                                      keyboardType: TextInputType.number,
                                      labelText: "кВт",
                                      hintText: "000",
                                      validatorText: "Введите значение"),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: DefaultInput(
                                      controller: controllerList[15],
                                      keyboardType: TextInputType.number,
                                      labelText: "Вт",
                                      hintText: "000",
                                      validatorText: "Введите значение"),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Text(
                                "Ранее присоединяемая мощность на напряжении:",
                                style:
                                    TextStyle(color: colorGray, fontSize: 16)),
                          ),
                          Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: DefaultInput(
                                      controller: controllerList[16],
                                      keyboardType: TextInputType.number,
                                      labelText: "кВт",
                                      hintText: "000",
                                      validatorText: "Введите значение"),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: DefaultInput(
                                      controller: controllerList[17],
                                      keyboardType: TextInputType.number,
                                      labelText: "Вт",
                                      hintText: "000",
                                      validatorText: "Введите значение"),
                                )
                              ],
                            ),
                          ),
                          
                          ])),
                          Visibility(visible: profileService!.userType == "fl", child: DefaultButton(
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
                                    isGetPadding: false),),
                          
                          
                          DefaultButton(
                            text: "Далее",
                            onPressed: () {
                              if ((controllerList[2].text != "" &&
                                      controllerList[3].text != "") ||
                                  (controllerList[8].text != "" &&
                                      controllerList[9].text != "") ||
                                  (controllerList[14].text != "" &&
                                      controllerList[15].text != "")) {
                                //категория надежности 3
                                mainClaimSendService!.field_max_power_3 =
                                    controllerList[0].text;
                                mainClaimSendService!.field_max_voltage_3 =
                                    controllerList[1].text;
                                mainClaimSendService!
                                        .field_max_connect_power_3 =
                                    controllerList[2].text;
                                mainClaimSendService!
                                        .field_max_connect_voltage_3 =
                                    controllerList[3].text;
                                mainClaimSendService!
                                        .field_max_current_power_3 =
                                    controllerList[4].text;
                                mainClaimSendService!
                                        .field_max_current_voltage_3 =
                                    controllerList[5].text;
                                //категория надежности 2
                                mainClaimSendService!.field_max_power_2 =
                                    controllerList[6].text;
                                mainClaimSendService!.field_max_voltage_2 =
                                    controllerList[7].text;
                                mainClaimSendService!
                                        .field_max_connect_power_2 =
                                    controllerList[8].text;
                                mainClaimSendService!
                                        .field_max_connect_voltage_2 =
                                    controllerList[9].text;
                                mainClaimSendService!
                                        .field_max_current_power_2 =
                                    controllerList[10].text;
                                mainClaimSendService!
                                        .field_max_current_voltage_2 =
                                    controllerList[11].text;
                                //категория надежности 2
                                mainClaimSendService!.field_max_power_1 =
                                    controllerList[12].text;
                                mainClaimSendService!.field_max_voltage_1 =
                                    controllerList[13].text;
                                mainClaimSendService!
                                        .field_max_connect_power_1 =
                                    controllerList[14].text;
                                mainClaimSendService!
                                        .field_max_connect_voltage_1 =
                                    controllerList[15].text;
                                mainClaimSendService!
                                        .field_max_current_power_1 =
                                    controllerList[16].text;
                                mainClaimSendService!
                                        .field_max_current_voltage_1 =
                                    controllerList[17].text;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewClaimStep4()));
                              } else {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.bottomSlide,
                                  headerAnimationLoop: false,
                                  title: "Ошибка!",
                                  btnOkColor: Colors.red,
                                  desc:
                                      "Введите вновь присоединяемую мощность в одной из категорий надежности",
                                  btnOkOnPress: () {},
                                ).show();
                              }
                            },
                            isGetPadding: false,
                            margin: EdgeInsets.only(top: 12),
                          )
                        ],
                      ),
                    )))));
  }

  @override
  void didChangeDependencies() {
    mainClaimSendService ??=
        DependencyProvider.of(context)!.mainClaimSendService;
    profileService ??= DependencyProvider.of(context)!.profileService;
    super.didChangeDependencies();
  }
}

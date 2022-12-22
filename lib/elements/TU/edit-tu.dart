import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/Services/profile-service.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/default-input.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/model/TU.dart';
import 'package:conres_app/websocket/pu-edit-new.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../DI/dependency-provider.dart';
import '../../bloc/profile/profile-bloc.dart';
import '../../bloc/profile/profile-state.dart';
import '../../consts.dart';
import '../../model/meter.dart';
import '../../websocket/message-send.dart';
import '../PU/list-element.dart';
import '../bloc/bloc-screen.dart';
import '../dropdown.dart';
/* 
edit-tu.dart
Редактирование ТУ

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class EditPuPage extends StatefulWidget {
  List<TuModel> TuPoints;
  Meter currentMeter;
  VoidCallback? refrash;
  EditPuPage({required this.TuPoints, required this.currentMeter, required this.refrash});
  @override
  State<StatefulWidget> createState() => _EditPuPage();
}

class _EditPuPage extends State<EditPuPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController multiplerController = TextEditingController();

  TextEditingController newTuNumberController = TextEditingController();
  TextEditingController newTuNameController = TextEditingController();
  TextEditingController newTuAddressController = TextEditingController();
  TuModel? newTu;

  ProfileBloc? profileBloc;
  ProfileService? profileService;
  WebSocketChannel? webSocketChannel;
  bool isLoading = false;

  Map selectedPoints = {}; // выбранные точки учета
  List dropdownPointsList = [];
  List dropdownTypeList = [
    {'label': 'Электроэнергия', 'value': '1'}
  ];
  List dropdownTariffList = [
    {'label': 'Двухтарифный', 'value': '2'},
    {'label': 'Однотарифный', 'value': '3'}
  ];
  bool isLoaded = false;

  final _formKey = GlobalKey<FormState>();
  final _formNewTUKey = GlobalKey<FormState>();
  Future<void> _refrash() async {}

  void selectPoint(value) {
    if (selectedPoints.containsKey(value['id']) == false) {
      setState(() {
        final point = {value['id']: value['label']};
        selectedPoints.addEntries(point.entries);
      });
    }
  }

  void remove(String id) {}

  @override
  void initState() {
    for (int i = 0; i < widget.TuPoints.length; i++) {
      dropdownPointsList.add({
        'id': widget.TuPoints[i].point_id,
        'label': widget.TuPoints[i].name,
        'value': widget.TuPoints[i].name
      });
    }
    nameController.text = widget.currentMeter.name!;
    numberController.text = widget.currentMeter.pu_number!;
    multiplerController.text = widget.currentMeter.measure_multipler!;
    selectPoint(dropdownPointsList[0]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BlocScreen<ProfileBloc, ProfileState>(
            bloc: profileBloc,
            listener: (context, state) => _listener(context, state),
            builder: (context, state) {
              return MainForm(
                  header: HeaderNotification(
                      text: "Редактировать ПУ", canGoBack: true),
                  body: Stack(children: [
                    SingleChildScrollView(
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: defaultSidePadding,
                                right: defaultSidePadding),
                            child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Точка учёта", style: labelTextStyle),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 5, bottom: 15),
                                      child: CoolDropdown(
                                        resultHeight: 55,
                                        resultTS: TextStyle(
                                          fontSize: 20,
                                          color: colorMain,
                                        ),
                                        resultBD: BoxDecoration(
                                          color: messageColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        selectedItemBD: BoxDecoration(
                                          color: messageColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        selectedItemTS: TextStyle(
                                          fontSize: 20,
                                          color: colorMain,
                                        ),
                                        dropdownBD: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                        255, 49, 49, 49)
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 10,
                                                offset: Offset(0, 1),
                                              ),
                                            ]),
                                        dropdownWidth:
                                            MediaQuery.of(context).size.width -
                                                50,
                                        resultWidth:
                                            MediaQuery.of(context).size.width,
                                        dropdownList: dropdownPointsList,
                                        onChange: (value) {
                                          selectPoint(value);
                                        },
                                        defaultValue: dropdownPointsList[0],
                                      ),
                                    ),
                                    Container(
                                        constraints:
                                            BoxConstraints(maxHeight: 100),
                                        //height: 100,
                                        child: Flex(
                                          direction: Axis.vertical,
                                          children: [
                                            Expanded(
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        selectedPoints.length,
                                                    itemBuilder:
                                                        (context, int index) {
                                                      return ListElement(
                                                          text: selectedPoints
                                                              .values
                                                              .elementAt(index),
                                                          id: selectedPoints
                                                              .keys
                                                              .elementAt(index),
                                                          remove: remove);
                                                    }))
                                          ],
                                        )),
                                    Visibility(
                                        visible: newTu != null ? true : false,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Добавленная точка учета",
                                                  style: labelTextStyle),
                                              ListElement(
                                                text: newTuNameController.text,
                                                id: '0',
                                                remove: remove,
                                              )
                                            ])),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      child: DefaultButton(
                                          text: "Добавить новую ТУ",
                                          onPressed: () {
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.noHeader,
                                              animType: AnimType.bottomSlide,
                                              headerAnimationLoop: false,
                                              btnOk: DefaultButton(
                                                isGetPadding: false,
                                                onPressed: () {
                                                  if (_formNewTUKey
                                                      .currentState!
                                                      .validate()) {
                                                    newTu ??= TuModel();
                                                    setState(() {
                                                      newTu!.name =
                                                          newTuNameController
                                                              .text;
                                                      newTu!.address =
                                                          newTuAddressController
                                                              .text;
                                                      newTu!.number =
                                                          newTuNameController
                                                              .text;
                                                    });

                                                    Navigator.pop(context);
                                                  }
                                                },
                                                text: "Принять",
                                              ),
                                              body: Container(
                                                  padding: EdgeInsets.only(
                                                      left: defaultSidePadding,
                                                      top: 5,
                                                      right:
                                                          defaultSidePadding),
                                                  height: 350,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Form(
                                                    key: _formNewTUKey,
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 15),
                                                            child: const Text(
                                                                "Добавить новую ТУ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20)),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 15),
                                                            child: DefaultInput(
                                                                labelText:
                                                                    "Номер ТУ",
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                hintText:
                                                                    "Номер ТУ",
                                                                validatorText:
                                                                    "Введите номер ТУ",
                                                                controller:
                                                                    newTuNumberController),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 15),
                                                            child: DefaultInput(
                                                                labelText:
                                                                    "Наименование ТУ",
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                hintText:
                                                                    "Наименование ТУ",
                                                                validatorText:
                                                                    "Введите наименование ТУ",
                                                                controller:
                                                                    newTuNameController),
                                                          ),
                                                          DefaultInput(
                                                              labelText:
                                                                  "Адрес ТУ",
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              hintText:
                                                                  "Город, Улица, Дом, Квартира",
                                                              validatorText:
                                                                  "Введите адрес",
                                                              controller:
                                                                  newTuAddressController),
                                                        ]),
                                                  )),
                                            ).show();
                                          },
                                          isGetPadding: false),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      child: DefaultInput(
                                          controller: nameController,
                                          keyboardType: TextInputType.text,
                                          labelText: "Наименование ПУ",
                                          hintText: "Наименование ПУ",
                                          validatorText:
                                              "Введите наименование ПУ"),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      child: DefaultInput(
                                          controller: numberController,
                                          keyboardType: TextInputType.text,
                                          labelText: "Номер ПУ",
                                          hintText: "Номер ПУ",
                                          validatorText: "Введите номер ПУ"),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(bottom: 15),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Тип ПУ",
                                                  style: labelTextStyle),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Container(
                                                      child: CoolDropdown(
                                                    resultHeight: 55,
                                                    resultTS: TextStyle(
                                                      fontSize: 20,
                                                      color: colorMain,
                                                    ),
                                                    resultBD: BoxDecoration(
                                                      color: messageColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    selectedItemBD:
                                                        BoxDecoration(
                                                      color: messageColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    selectedItemTS: TextStyle(
                                                      fontSize: 20,
                                                      color: colorMain,
                                                    ),
                                                    dropdownBD: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        49,
                                                                        49,
                                                                        49)
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 1,
                                                            blurRadius: 10,
                                                            offset:
                                                                Offset(0, 1),
                                                          ),
                                                        ]),
                                                    dropdownWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            50,
                                                    resultWidth:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    dropdownList:
                                                        dropdownTypeList,
                                                    onChange: (_) {},
                                                    defaultValue:
                                                        dropdownTypeList[0],
                                                    // placeholder: 'insert...',
                                                  ))),
                                            ])),
                                    Container(
                                        margin: EdgeInsets.only(bottom: 15),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Тарифная зона",
                                                  style: labelTextStyle),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Container(
                                                    child: CoolDropdown(
                                                      resultHeight: 55,
                                                      resultTS: TextStyle(
                                                        fontSize: 20,
                                                        color: colorMain,
                                                      ),
                                                      resultBD: BoxDecoration(
                                                        color: messageColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      selectedItemBD:
                                                          BoxDecoration(
                                                        color: messageColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      selectedItemTS: TextStyle(
                                                        fontSize: 20,
                                                        color: colorMain,
                                                      ),
                                                      dropdownBD: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          49,
                                                                          49,
                                                                          49)
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 1,
                                                              blurRadius: 10,
                                                              offset:
                                                                  Offset(0, 1),
                                                            ),
                                                          ]),
                                                      dropdownWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              50,
                                                      resultWidth:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      dropdownList:
                                                          dropdownTariffList,
                                                      onChange: (_) {},
                                                      defaultValue:
                                                          dropdownTariffList[0],
                                                      // placeholder: 'insert...',
                                                    ),
                                                  )),
                                            ])),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      child: DefaultInput(
                                          controller: multiplerController,
                                          keyboardType: TextInputType.text,
                                          labelText: "Множитель показаний",
                                          hintText: "Множитель показаний",
                                          validatorText:
                                              "Введите множитель показаний"),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      child: DefaultButton(
                                          text: "Сохранить",
                                          onPressed: () {
                                            List<String> newTuIdList = [];
                                            for (int i = 0;
                                                i < selectedPoints.length;
                                                i++) {
                                              newTuIdList.add(selectedPoints
                                                  .keys
                                                  .elementAt(i));
                                            }
                                            if (_formKey.currentState!
                                                .validate()) {
                                              profileBloc!.editPuFromTu(
                                                  profileService!.object_id!,
                                                  widget.currentMeter.meter_id!,
                                                  profileService!
                                                      .accountNumber!,
                                                  newTuIdList,
                                                  newTuNumberController.text,
                                                  newTuNameController.text,
                                                  newTuAddressController.text,
                                                  nameController.text,
                                                  numberController.text,
                                                  widget
                                                      .currentMeter.pu_type_id!,
                                                  "2", //даухтарифный
                                                  multiplerController.text);
                                            }
                                          },
                                          isGetPadding: false),
                                    ),
                                  ],
                                )))),
                    Visibility(
                        child: Center(
                            child: Container(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(color: colorMain),
                        )),
                        visible: (isLoading == true) ? true : false)
                  ]),
                  onRefrash: _refrash);
            }));
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      isLoading = true;
      return;
    } else {
      isLoading = false;
    }
    if (state.TuPoints != null && isLoaded == false) {
      //points = {for (var e in state.TuPoints!) e.point_id!: e};
      isLoaded = true;
    }
    if (state.editPuFromTuData != null) {
      List<Points> points = [];
      List<PointsCur> pointsCur = [];
      List<String> newTuId = [];
      for (int i = 0; i < state.editPuFromTuData!['points'].length; i++) {
        points.add(Points(
            pointId: state.editPuFromTuData!['points'][i]['point_id'],
            name: state.editPuFromTuData!['points'][i]['name'],
            number: state.editPuFromTuData!['points'][i]['number'],
            address: state.editPuFromTuData!['points'][i]['address'],
            newName: state.editPuFromTuData!['points'][i]['new_name'],
            newNumber: state.editPuFromTuData!['points'][i]['new_number'],
            newAddress: state.editPuFromTuData!['points'][i]['new_address']));
      }
      for (int i = 0; i < state.editPuFromTuData!['points_cur'].length; i++) {
        pointsCur.add(PointsCur(
          pointId: state.editPuFromTuData!['points_cur'][i]['point_id'],
          name: state.editPuFromTuData!['points_cur'][i]['name'],
          number: state.editPuFromTuData!['points_cur'][i]['number'],
          address: state.editPuFromTuData!['points_cur'][i]['address'],
        ));
      }
      for (int i = 0;
          i < state.editPuFromTuData!['pu_info']['new_tu_id'].length;
          i++) {
        newTuId.add(state.editPuFromTuData!['pu_info']['new_tu_id'][i]);
      }
      dynamic message = MessageSend(
          cmd: "publish",
          subject: "store-${store_id}",
          event: "meter_binding_edit_new",
          data: PuEditNew(
            editPush: state.editPuFromTuData!['edit_push'],
            edit: state.editPuFromTuData!['edit'],
            approve: state.editPuFromTuData!['approve'],
            dateRevise: state.editPuFromTuData!['date_revise'],
            meterInfo: MeterInfo(
              meterId: state.editPuFromTuData!['meter_info']['meter_id'],
              name: state.editPuFromTuData!['meter_info']['name'],
              number: state.editPuFromTuData!['meter_info']['number'],
              tariffName: state.editPuFromTuData!['meter_info']['tariff_name'],
              typeName: state.editPuFromTuData!['meter_info']['type_name'],
              dateRevise: state.editPuFromTuData!['meter_info']['date_revise'],
              measureMultipler: state.editPuFromTuData!['meter_info']
                  ['measure_multipler'],
            ),
            requestId: state.editPuFromTuData!['request_id'].toString(),
            objectId: state.editPuFromTuData!['object_id'],
            objectName: state.editPuFromTuData!['object_name'],
            objectAddress: state.editPuFromTuData!['object_address'],
            newObjectName: state.editPuFromTuData!['new_object_name'],
            newObjectAddress: state.editPuFromTuData!['new_object_address'],
            points: points,
            pointsCur: pointsCur,
            puInfo: PuInfo(
              objectId: state.editPuFromTuData!['pu_info']['object_id'],
              meterId: state.editPuFromTuData!['pu_info']['meter_id'],
              accountNumber: state.editPuFromTuData!['pu_info']
                  ['account_number'],
              newTuId: newTuId,
              newTuNumber: state.editPuFromTuData!['pu_info']['new_tu_number'],
              newTuName: state.editPuFromTuData!['pu_info']['new_tu_name'],
              newPuAddress: state.editPuFromTuData!['pu_info']
                  ['new_pu_address'],
              newPuName: state.editPuFromTuData!['pu_info']['new_pu_name'],
              newPuNumber: state.editPuFromTuData!['pu_info']['new_pu_number'],
              newPuType: state.editPuFromTuData!['pu_info']['new_pu_type'],
              newPuZone: state.editPuFromTuData!['pu_info']['new_pu_zone'],
              newPuRatio: state.editPuFromTuData!['pu_info']['new_pu_ratio'],
              tariffName: state.editPuFromTuData!['pu_info']['tariff_name'],
              readingsQuantity: state.editPuFromTuData!['pu_info']
                  ['readings_quantity'],
              typeName: state.editPuFromTuData!['pu_info']['type_name'],
            ),
            meterId: state.editPuFromTuData!['meter_id'],
            accountId: state.editPuFromTuData!['account_id'],
            accountNumber: state.editPuFromTuData!['account_number'],
            userLkId: state.editPuFromTuData!['user_lk_id'],
            dateAdded: state.editPuFromTuData!['date_added'],
          ),
          to_id: int.parse(user_id!));
      String data = jsonEncode(message.toJson());
      webSocketChannel!.sink.add(data);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        headerAnimationLoop: false,
        title: "Успешно!",
        desc: "Запрос на редактирование ПУ отправлен!",
        btnOkOnPress: () {
          widget.refrash!.call();
          Navigator.pop(context);
        },
      ).show();
    }
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileService ??= DependencyProvider.of(context)!.profileService;
    webSocketChannel ??=
        DependencyProvider.of(context)!.webSocketChannel(false);
    super.didChangeDependencies();
  }
}

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/UI/default-input.dart';
import 'package:conres_app/elements/dropdown.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../Services/link-pu-service.dart';
import '../../UI/default-button.dart';
import '../../UI/main-form.dart';
import '../../bloc/profile/profile-bloc.dart';
import '../../bloc/profile/profile-state.dart';
import '../../consts.dart';
import '../../elements/PU/list-element.dart';
import '../../elements/bloc/bloc-screen.dart';
import '../../elements/header/header-notification.dart';
import '../../elements/testimony/select-object-doalog.dart';
import '../../websocket/message-send.dart';
import '../../websocket/meter-bind-new.dart';

class LinkPUStep3 extends StatefulWidget {
  const LinkPUStep3({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LinkPUStep3();
}

class _LinkPUStep3 extends State<LinkPUStep3> {
  ProfileBloc? profileBloc;
  WebSocketChannel? webSocketChannel;
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController tariffController = TextEditingController();
  TextEditingController multipler = TextEditingController();
  LinkPuService? linkPuService;
  final _formKey = GlobalKey<FormState>();

  bool? isLoading;

  List dropdownTypeList = [
    {'label': 'Электроэнергия', 'value': '1'}
  ];
  String selectedType = '1';
  List dropdownTariffList = [
    {'label': 'Двухтарифный', 'value': '2'},
    {'label': 'Однотарифный', 'value': '3'}
  ];
  String selectedTariff = '2';

  Future<void> _refrash() async {}
  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return MainForm(
              header: HeaderNotification(text: "Привязать ПУ", canGoBack: true),
              body: Stack(
                children: [
                  SingleChildScrollView(
                      child: Form(
                    key: _formKey,
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: defaultSidePadding,
                            right: defaultSidePadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: Text(
                                "Укажите информацию о ПУ",
                                style: TextStyle(
                                    color: colorMain,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(bottom: 12),
                                child: DefaultInput(
                                    labelText: "Наименование ПУ",
                                    keyboardType: TextInputType.text,
                                    hintText: "Наименование ПУ",
                                    validatorText: "Введитие наименование ПУ",
                                    controller: nameController)),
                            Container(
                              margin: EdgeInsets.only(bottom: 12),
                              child: DefaultInput(
                                  labelText: "Номер ПУ",
                                  keyboardType: TextInputType.text,
                                  hintText: "Номер ПУ",
                                  validatorText: "Введитие номер ПУ",
                                  controller: numberController),
                            ),
                            Container(
                                margin: EdgeInsets.only(bottom: 15),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Тип ПУ", style: labelTextStyle),
                                      SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                                MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    50,
                                            dropdownHeight: 100,
                                            resultWidth: MediaQuery.of(context)
                                                .size
                                                .width,
                                            dropdownList: dropdownTypeList,
                                            onChange: (value) {
                                              selectedType = value['value'];
                                            },
                                            defaultValue: dropdownTypeList[0],
                                          )),
                                    ])),
                            Container(
                                margin: EdgeInsets.only(bottom: 15),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Тарифная зона ПУ",
                                          style: labelTextStyle),
                                      SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                                MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    50,
                                            dropdownHeight: 150,
                                            resultWidth: MediaQuery.of(context)
                                                .size
                                                .width,
                                            dropdownList: dropdownTariffList,
                                            onChange: (value) {
                                              selectedTariff = value['value'];
                                            },
                                            defaultValue: dropdownTariffList[0],
                                          )),
                                    ])),
                            DefaultInput(
                                labelText: "Множитель показаний",
                                keyboardType: TextInputType.text,
                                hintText: "Множитель показаний",
                                validatorText: "Введитие множитель показателей",
                                controller: multipler),
                          ],
                        )),
                  )),
                  Visibility(
                      child: Center(
                          child: Container(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(color: colorMain),
                      )),
                      visible: (isLoading == true) ? true : false)
                ],
              ),
              footer: Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(
                        left: defaultSidePadding,
                      ),
                      width: 160,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Назад",
                            style: TextStyle(fontSize: 18, color: colorMain)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: messageColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                      )),
                  const Spacer(),
                  Container(
                      padding: EdgeInsets.only(right: defaultSidePadding),
                      width: 160,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            linkPuService!.new_pu_name = nameController.text;
                            linkPuService!.new_pu_number =
                                numberController.text;
                            linkPuService!.new_pu_type = selectedType;
                            linkPuService!.new_pu_zone = selectedTariff;
                            linkPuService!.new_pu_ratio = multipler.text;
                            profileBloc!.bindPu(linkPuService!);
                          }
                        },
                        child: const Text("Отправить",
                            style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorMain,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ))
                ],
              ),
              onRefrash: _refrash);
        });
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      isLoading = true;
      return;
    } else {
      isLoading = false;
    }
    if (state.bindPuData != null) {
      List<PointsMeter> points = [];
      List<String> newTuId = [];
      for (int i = 0; i < state.bindPuData!['points'].length; i++) {
        points.add(PointsMeter(
            pointId: state.bindPuData!['points'][i]['point_id'],
            newName: state.bindPuData!['points'][i]['new_name'],
            newNumber: state.bindPuData!['points'][i]['new_number'],
            newAddress: state.bindPuData!['points'][i]['new_address']));
      }
      if (state.bindPuData!['pu_info']['new_tu_id'] != null) {
        for (int i = 0;
            i < state.bindPuData!['pu_info']['new_tu_id'].length;
            i++) {
          newTuId.add(state.bindPuData!['pu_info']['new_tu_id'][i]);
        }
      }

      dynamic message = MessageSend(
          cmd: "publish",
          subject: "store-${store_id}",
          event: "meter_binding_new",
          data: BindTuNew(
              newObjectName: state.bindPuData!['new_object_name'],
              newObjectAddress: state.bindPuData!['new_object_address'],
              objectId: state.bindPuData!['object_id'].toString(),
              points: points,
              meterId: state.bindPuData!['meter_id'],
              code: state.bindPuData!['code'],
              msg: state.bindPuData!['msg'],
              dateRevise: state.bindPuData!['date_revise'],
              accountId: state.bindPuData!['account_id'],
              accountNumber: state.bindPuData!['account_number'],
              userLkId: state.bindPuData!['user_lk_id'],
              dateAdded: state.bindPuData!['date_added'],
              puInfo: PuInfo(
                newObjectId: state.bindPuData!['pu_info']['new_object_id'],
                newObjectName: state.bindPuData!['pu_info']['new_object_name'],
                newObjectAddress: state.bindPuData!['pu_info']
                    ['new_object_address'],
                newTuId: newTuId,
                newTuNumber: state.bindPuData!['pu_info']['new_tu_number'],
                newTuName: state.bindPuData!['pu_info']['new_tu_name'],
                newPuAddress: state.bindPuData!['pu_info']['new_pu_address'],
                newPuName: state.bindPuData!['pu_info']['new_pu_name'],
                newPuNumber: state.bindPuData!['pu_info']['new_pu_number'],
                newPuType: state.bindPuData!['pu_info']['new_pu_type'],
                newPuZone: state.bindPuData!['pu_info']['new_pu_zone'],
                newPuRatio: state.bindPuData!['pu_info']['new_pu_ratio'],
                userLkId: state.bindPuData!['pu_info']['user_lk_id'],
                newDateRevise: state.bindPuData!['pu_info']['new_date_revise'],
                tariffName: state.bindPuData!['pu_info']['tariff_name'],
                typeName: state.bindPuData!['pu_info']['tarifftype_name_name'],
              )),
          to_id: int.parse(user_id!));
      String data = jsonEncode(message.toJson());
      webSocketChannel!.sink.add(data);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        headerAnimationLoop: false,
        title: "Успешно!",
        desc: "Запрос на привязку отправлен!",
        btnOkOnPress: () {
          //widget.refrash!.call();
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ).show();
    }
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    linkPuService ??= DependencyProvider.of(context)!.linkPuService;
    webSocketChannel ??=
        DependencyProvider.of(context)!.webSocketChannel(false);
    super.didChangeDependencies();
  }
}

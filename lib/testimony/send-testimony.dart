import 'dart:convert';
import 'dart:core';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/Services/profile-service.dart';
import 'package:conres_app/Services/send-testimont-service.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:conres_app/model/meter.dart';
import 'package:conres_app/testimony/link-pu.dart';
import 'package:conres_app/testimony/objects-pu.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../DI/dependency-provider.dart';
import '../Services/bottom-navigation-select-service.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/header/header-notification.dart';
import '../elements/not-found.dart';
import '../elements/testimony/testimony.dart';
import '../profile/tab-item.dart';
import '../websocket/message-send.dart';
/* 
send-testimony.dart
Передача показаний

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class SendTestimony extends StatefulWidget {
  final String? personal;

  const SendTestimony({required this.personal});

  @override
  State<StatefulWidget> createState() => _SendTestimony();
}

class _SendTestimony extends State<SendTestimony> {
  ProfileBloc? profileBloc;
  ProfileService? profileService;
  BottomNavigationSelectService? bottomNavigationSelectService;
  WebSocketChannel? webSocketChannel;

  bool getPU = false;
  bool isLoading = true;
  List<Meter> meters = [];
  SendTestimonyService? sendTestimonyService;
  ScrollController scrollController = ScrollController();

  List<TextEditingController>? dayControllers = [];
  List<TextEditingController>? nightControllers = [];

  String? currentMonth;

  Widget? footer = Container();

  Future<void> _refrash() async {}

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return Stack(
            children: [
              MainForm(
                  header: HeaderNotification(
                      text: "Передача показаний", canGoBack: true),
                  body: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: defaultSidePadding),
                            child: Text("Показания за $currentMonth", style: TextStyle(fontSize: 20)),
                          ),
                          
                          Expanded(child: ListView.builder(
                              controller: scrollController,
                              itemCount: meters.length,
                              itemBuilder: (context, int index) {
                                return Testimony(
                                    meter: meters[index],
                                    dayController: dayControllers![index],
                                    nightController: nightControllers![index]);
                              }))
                          ,
                        ],
                      ),
                      Visibility(
                        visible: (meters.isEmpty ||
                                    profileService!.accountNumber == "") &&
                                isLoading == false
                            ? true
                            : false,
                        child: NotFound(
                            title: profileService!.accountNumber == ""
                                ? "Заключите договор"
                                : meters.isEmpty
                                    ? "Приборы учета"
                                    : "",
                            text: profileService!.accountNumber == ""
                                ? "У вас нет активного Лицевого cчёта, отправьте запрос на привязку лицевого счета (договора) и дождитесь его подтверждения!"
                                : meters.isEmpty
                                    ? "По данному лицевому счёту не найдены приборы учёта, отправьте заявку на привязку ПУ и дождитесь подтверждения."
                                    : ""),
                      ),
                    ],
                  ),
                  footer: profileService!.accountNumber == ""
                      ? DefaultButton(
                          isGetPadding: true,
                          onPressed: () {
                            bottomNavigationSelectService!.canLogin = false;
                            bottomNavigationSelectService!.function!
                                .call(TabItem.contracts);
                          },
                          text: "Отправить запрос")
                      : meters.isEmpty
                          ? DefaultButton(
                              isGetPadding: true,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ObjectsPU()));
                              },
                              text: "Привязать новый ПУ")
                          : DefaultButton(
                              isGetPadding: true,
                              onPressed: () {
                                List<String> dayValues = [];
                                List<String> nightValues = [];
                                bool isEmpty = true;
                                for (int i = 0;
                                    i < dayControllers!.length;
                                    i++) {
                                  if (dayControllers![i].text != "") {
                                    isEmpty = false;
                                  }
                                  dayValues.add(dayControllers![i].text);
                                }
                                for (int i = 0;
                                    i < nightControllers!.length;
                                    i++) {
                                  if (nightControllers![i].text != "") {
                                    isEmpty = false;
                                  }
                                  nightValues.add(nightControllers![i].text);
                                }
                                if (isEmpty == false) {
                                  profileBloc!
                                      .sendTestimony(dayValues, nightValues);
                                } else {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.info,
                                    animType: AnimType.bottomSlide,
                                    headerAnimationLoop: false,
                                    title: "Внимание!",
                                    desc: "Введите показания!",
                                    btnOkColor: Colors.blue,
                                    btnOkOnPress: () {},
                                  ).show();
                                }
                              },
                              text: "Передать показания"),
                  onRefrash: _refrash),
              Visibility(
                  child: Center(
                      child: Container(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(color: colorMain),
                  )),
                  visible: (isLoading == true) ? true : false),
            ],
          );
        });
  }

  void addMeasure() {}
  _listener(BuildContext context, ProfileState state) {
    isLoading = state.loading!;
    if (state.loading!) {
      return;
    }
    if (state.meters != null) {
      getPU = true;
      meters = state.meters!;

      for (int i = 0; i < state.meters!.length; i++) {
        dayControllers!.add(TextEditingController());
        nightControllers!.add(TextEditingController());
      }
    }
    if (state.loading! == false && state.sendTestimonyData != null) {
      List<TestimonySend> meterData = [];
      for(int i = 0; i < state.sendTestimonyData!.length; i++){
        meterData.add(TestimonySend(
          readingsAnalyzeId: state.sendTestimonyData![i]['readings_analyze_id'],
          date: state.sendTestimonyData![i]['date'],
          meterId: state.sendTestimonyData![i]['meter_id'],
          indicationIndex: state.sendTestimonyData![i]['indication_index'],
          reading: state.sendTestimonyData![i]['reading'],
          readingsSourceId: state.sendTestimonyData![i]['readings_source_id'],
          readingsPeriodId: state.sendTestimonyData![i]['readings_period_id'],
          flag: state.sendTestimonyData![i]['flag'],
          attributes: state.sendTestimonyData![i]['attributes'],
          channelId: state.sendTestimonyData![i]['channel_id'],
          name: state.sendTestimonyData![i]['name'],
          puTypeId: state.sendTestimonyData![i]['pu_type_id'],
          tariffTypeId: state.sendTestimonyData![i]['tariff_type_id'],
          puNumber: state.sendTestimonyData![i]['pu_number'],
          measureMultipler: state.sendTestimonyData![i]['measure_multipler'],
          dateRevise: state.sendTestimonyData![i]['date_revise'],
          userLkId: state.sendTestimonyData![i]['user_lk_id'],
          accountId: state.sendTestimonyData![i]['account_id'],
          readingsFormat: state.sendTestimonyData![i]['readings_format'],
          status: state.sendTestimonyData![i]['status'],
          dateAdded: state.sendTestimonyData![i]['date_added'],
          dateInstall: state.sendTestimonyData![i]['date_install'],
          dateVerification: state.sendTestimonyData![i]['date_verification'],
          hidden: state.sendTestimonyData![i]['hidden'],
          sourcName: state.sendTestimonyData![i]['sourc_name'],
          userInn: state.sendTestimonyData![i]['user_inn'],
          userAccountNumber: state.sendTestimonyData![i]['user_account_number'],
          puTypeName: state.sendTestimonyData![i]['pu_type_name'],
          dateApprove: state.sendTestimonyData![i]['date_approve'],
          month: state.sendTestimonyData![i]['month'],
          year: state.sendTestimonyData![i]['year'],
          tuName: state.sendTestimonyData![i]['tu_name'],
          tuNumber: state.sendTestimonyData![i]['tu_number'],
          address: state.sendTestimonyData![i]['address'],
          tariffName: state.sendTestimonyData![i]['tariff_name'],
          readingsQuantity: state.sendTestimonyData![i]['readings_quantity'],
          readingsQuantityName: state.sendTestimonyData![i]['readings_quantity_name'],
        ));
      }
      dynamic message = MessageSend(
                    cmd: "publish",
                    subject: "store-${store_id}",
                    event: "readings_new",
                    data: meterData,
                    to_id: int.parse(user_id!)
                  );
      String data = jsonEncode(message.toJson());
      webSocketChannel!.sink.add(data);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        headerAnimationLoop: false,
        title: "Успешно!",
        desc: "Показания переданы!",
        btnOkOnPress: () {
          //Navigator.pop(context);
        },
      ).show();
    }
    if (state.error != null) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        headerAnimationLoop: false,
        title: "Ошибка!",
        btnOkColor: Colors.red,
        desc: state.error,
        btnOkOnPress: () {},
      ).show();
    }
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    webSocketChannel ??= DependencyProvider.of(context)!.webSocketChannel(false);
    profileService ??= DependencyProvider.of(context)!.profileService;
    bottomNavigationSelectService ??=
        DependencyProvider.of(context)!.bottomNavigationSelectService;
    sendTestimonyService ??=
        DependencyProvider.of(context)!.sendTestimonyService;
    var month = DateTime.now().month;
    switch(month){
      case 1:
        currentMonth = "январь";
      break;
      case 2:
        currentMonth = "февраль";
      break;
      case 3:
        currentMonth = "март";
      break;
      case 4:
        currentMonth = "апрель";
      break;
      case 5:
        currentMonth = "май";
      break;
      case 6:
        currentMonth = "июнь";
      break;
      case 7:
        currentMonth = "июль";
      break;
      case 8:
        currentMonth = "август";
      break;
      case 9:
        currentMonth = "сентябрь";
      break;
      case 10:
        currentMonth = "октяюрь";
      break;
      case 11:
        currentMonth = "ноябрь";
      break;
      case 12:
        currentMonth = "декабрь";
      break;

    }

    profileBloc!.getTU();
    super.didChangeDependencies();
  }
}

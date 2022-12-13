import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/Services/main-claim-send-service.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../UI/main-form.dart';
import '../../bloc/profile/profile-bloc.dart';
import '../../bloc/profile/profile-state.dart';
import '../../consts.dart';
import '../../elements/alert.dart';
import '../../elements/bloc/bloc-screen.dart';
import '../../elements/claims/claim-step7-object.dart';
import '../../elements/claims/file-element.dart';
import '../../elements/header/header.dart';
import '../../websocket/message-send.dart';

class NewClaimStep7 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewClaimStep7();
}

class _NewClaimStep7 extends State<NewClaimStep7> {
  ProfileBloc? profileBloc;
  MainClaimSendService? mainClaimSendService;
  WebSocketChannel? webSocketChannel;
  bool isLoading = false;
  List<Widget> objects = [];
  bool isSent = false; //отправлено ли
  Map<int?, FilePickerResult?> imagesMap = {
    //3 основных документа
    0: null,
    1: null,
    2: null
  };
  final _formKey = GlobalKey<FormState>();
  void _pickDocument(int id, FilePickerResult? result) {
    setState(() {
      imagesMap.update(id, (value) => result);
    });
  }

  void _addDocument() {
    int id = imagesMap.length + 1;
    final newDocEntries = <int, FilePickerResult?>{id: null};
    imagesMap.addEntries(newDocEntries.entries);
    objects.add(ClaimStep7Object(id: id, pickDocument: _pickDocument));
  }

  Future<void> _refrash() async {}

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: MainForm(
                  onRefrash: _refrash,
                  header: HeaderRow(text: claimStep7, fontSize: 24),
                  body: Stack(
                    children: [
                      SingleChildScrollView(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: defaultSidePadding,
                                  right: defaultSidePadding),
                              child: Form(
                                  key: _formKey,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.only(
                                              top: 25, bottom: 5),
                                          child: Text("Приложите документы",
                                              textAlign: TextAlign.left,
                                              style: claimTextStyle),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 13),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text("Паспорт страницы 1-2",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: colorGray,
                                                  fontSize: 16.0)),
                                        ),
                                        DocElement(
                                            id: 0, result: _pickDocument),
                                        Container(
                                          margin: EdgeInsets.only(top: 13),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text("Паспорт страницы 3-4",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: colorGray,
                                                  fontSize: 16.0)),
                                        ),
                                        DocElement(
                                            id: 1, result: _pickDocument),
                                        Container(
                                          margin: EdgeInsets.only(top: 13),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text(
                                              "Документ, подтверждающий право собственности",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: colorGray,
                                                  fontSize: 16.0)),
                                        ),
                                        DocElement(
                                            id: 2, result: _pickDocument),
                                        Column(
                                          children: objects,
                                        ),
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 24, 0, 24),
                                            height: 55,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white),
                                                onPressed: () {
                                                  setState(() {
                                                    setState(() {
                                                      _addDocument();
                                                    });
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        margin: const EdgeInsets
                                                                .fromLTRB(
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
                                            text: "Отправить",
                                            onPressed: () {
                                              if (isLoading == false) {
                                                if (imagesMap[0] != null &&
                                                    imagesMap[1] != null &&
                                                    imagesMap[2] != null) {
                                                  isSent = true;
                                                  mainClaimSendService!.files =
                                                      imagesMap;
                                                  profileBloc!.sendMainClaim(
                                                      mainClaimSendService!);
                                                } else {
                                                  AwesomeDialog(
                                                    context: context,
                                                    dialogType:
                                                        DialogType.error,
                                                    animType:
                                                        AnimType.bottomSlide,
                                                    headerAnimationLoop: false,
                                                    title: "Ошибка!",
                                                    btnOkColor: Colors.red,
                                                    desc: "Выберите файлы",
                                                    btnOkOnPress: () {},
                                                  ).show();
                                                }
                                              }
                                            },
                                            isGetPadding: false)
                                      ])))),
                      Visibility(
                          child: Center(
                              child: Container(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(color: colorMain),
                          )),
                          visible: (isLoading == true) ? true : false)
                    ],
                  )));
        });
  }

  _listener(BuildContext context, ProfileState state) {
    isLoading = state.loading!;
    if (state.loading == true) {
      return;
    }
    if (state.createClaimData != null) {
      dynamic message = MessageSend(
          cmd: "publish",
          subject: "store-${store_id}",
          event: "claim_new",
          data: ClaimNew(
            claim_id: state.createClaimData!['claim_id'], 
            claim_shortname: state.createClaimData!['claim_shortname'], 
            claim_name: state.createClaimData!['claim_name'],
            date_time: state.createClaimData!['date_time'],
            date: state.createClaimData!['date'],
            user_lk_id: state.createClaimData!['user_lk_id'], 
            user_inn: state.createClaimData!['user_inn'], 
            user_account_number: state.createClaimData!['user_account_number'], 
            claim_href: state.createClaimData!['claim_href']),
          to_id: int.parse(user_id!));
      String data = jsonEncode(message.toJson());
      webSocketChannel!.sink.add(data);
      mainClaimSendService!.delegateFunc!.call();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        headerAnimationLoop: false,
        title: "Успешно!",
        desc: "Заявление успешно отправлено!",
        btnOkOnPress: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ).show();
      
      
    } else if (state.loading == false && state.error != null) {
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
    mainClaimSendService ??=
        DependencyProvider.of(context)!.mainClaimSendService;
    super.didChangeDependencies();
  }
}

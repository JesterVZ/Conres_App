import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/consts.dart';
import 'package:conres_app/elements/header/header.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../Services/profile-service.dart';
import '../UI/default-input.dart';
import '../UI/main-form.dart';
import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/dropdown.dart';
import '../elements/header/header-notification.dart';
import '../websocket/message-send.dart';
/* 
new-chat
Создание нового чата

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
*/
class NewChat extends StatefulWidget {
  VoidCallback? refrash;
  NewChat({required this.refrash});
  @override
  State<StatefulWidget> createState() => _NewChat();
}

class _NewChat extends State<NewChat> {
  TextEditingController FioController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController TextController = TextEditingController();
  TextEditingController TypeController = TextEditingController();
  List dropdownReasonList = [
    {'label': 'вопрос о техническом присоединении', 'value': '1'},
    {'label': 'сообщить об аварии', 'value': '2'},
    {'label': 'другое', 'value': '3'},
  ];

  WebSocketChannel? webSocketChannel;
  bool isSent = false;
  final _formKey = GlobalKey<FormState>();

  ProfileBloc? profileBloc;
  ProfileService? profileService;
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
                  header: HeaderRow(text: "Новое обращение", fontSize: 24),
                  body: SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: defaultSidePadding,
                              right: defaultSidePadding),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
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
                                          color: Color.fromARGB(255, 49, 49, 49)
                                              .withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 10,
                                          offset: Offset(0, 1),
                                        ),
                                      ]),
                                  dropdownWidth:
                                      MediaQuery.of(context).size.width - 50,
                                  dropdownHeight: 200,
                                  resultWidth:
                                      MediaQuery.of(context).size.width,
                                  dropdownList: dropdownReasonList,
                                  defaultValue: dropdownReasonList[0],
                                  onChange: (value) {
                                    TypeController.text = value['label'];
                                  },
                                  //defaultValue: dropdownObjectsList[0],
                                ),
                                DefaultInput(
                                    controller: FioController,
                                    keyboardType: TextInputType.text,
                                    labelText: "ФИО",
                                    hintText: "Иванов Иван Иванович",
                                    validatorText: "Введите ФИО"),
                                DefaultInput(
                                    controller: EmailController,
                                    keyboardType: TextInputType.text,
                                    labelText: "Email",
                                    hintText: "Example@gmail.com",
                                    validatorText: "Введите Email"),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Текст обращения",
                                        style: TextStyle(
                                            color: colorGray, fontSize: 16.0)),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Введите текст";
                                        }
                                        return null;
                                      },
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      maxLines: 5,
                                      controller: TextController,
                                      decoration: InputDecoration(
                                          hintText: "Текст Вашего обращения",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: inputBorder, width: 2),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: colorMain, width: 2),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 2),
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: inputBorder,
                                                  width: 5.0),
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    )
                                  ],
                                ),
                                DefaultButton(
                                  margin: EdgeInsets.only(top: 18),
                                    text: "Создать обращение",
                                    isGetPadding: false,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        isSent = true;
                                        String type = "";
                                        switch (TypeController.text) {
                                          case "другое":
                                            type = "0";
                                            break;
                                          case "вопрос о техническом присоединении":
                                            type = "1";
                                            break;
                                          case "сообщить об аварии":
                                            type = "3";
                                            break;
                                        }

                                        profileBloc!.createNewTicket(
                                            EmailController.text,
                                            FioController.text,
                                            type,
                                            TextController.text);
                                      }
                                    })
                              ],
                            ),
                          )))));
        });
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      return;
    }
    if (state.createTicketData != null && isSent == true) {
      dynamic message = MessageSend(
          cmd: "publish",
          subject: "store-${store_id}",
          event: "ticket_new",
          data: TicketNew(
              ticket_theme_id: state.createTicketData!['ticket_theme_id'],
              contact_name: state.createTicketData!['contact_name'],
              contact_email: state.createTicketData!['contact_email'],
              user_lk_id: state.createTicketData!['user_lk_id'],
              color_type_id: state.createTicketData!['color_type_id'],
              count_tm_sender: state.createTicketData!['count_tm_sender'],
              date_added: state.createTicketData!['date_added'],
              name: state.createTicketData!['name'],
              name_theme: state.createTicketData!['name_theme'],
              responsible_id: state.createTicketData!['responsible_id'],
              status_id: state.createTicketData!['status_id'],
              ticket_id: state.createTicketData!['ticket_id']),
          to_id: int.parse(user_id!));
      String data = jsonEncode(message.toJson());
      webSocketChannel!.sink.add(data);

      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        headerAnimationLoop: false,
        title: "Успешно!",
        desc: "Обращение успешно создано!",
        btnOkOnPress: () {
          isSent = false;
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
    FioController.text = (profileService!.userType == "fl" ||
            profileService!.userType == "ip")
        ? "${profileService!.userInformation!.lastname!} ${profileService!.userInformation!.firstname!} ${profileService!.userInformation!.patronymic!}"
        : (profileService!.userInformation!.company_full ?? "");
    TypeController.text = dropdownReasonList[0]['label'];
    super.didChangeDependencies();
  }
}

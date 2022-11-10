import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/consts.dart';
import 'package:conres_app/elements/header/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../UI/default-input.dart';
import '../UI/main-form.dart';
import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/dropdown.dart';
import '../elements/header/header-notification.dart';
import '../websocket/message-send.dart';

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
  WebSocketChannel? webSocketChannel;
  bool isSent = false;
  final _formKey = GlobalKey<FormState>();

  ProfileBloc? profileBloc;
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
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: CustomDropDown(
                                      selectedItem: TypeController,
                                      title: "Выберите причину",
                                      items: const [
                                        "вопрос о техническом присоединении",
                                        "сообщить об аварии",
                                        "другое"
                                      ],
                                    )),
                                Container(
                                    margin: EdgeInsets.only(bottom: 12),
                                    child: DefaultInput(
                                        controller: FioController,
                                        keyboardType: TextInputType.text,
                                        labelText: "ФИО",
                                        hintText: "Иванов Иван Иванович",
                                        validatorText: "Введите ФИО")),
                                Container(
                                  margin: EdgeInsets.only(bottom: 12),
                                  child: DefaultInput(
                                      controller: EmailController,
                                      keyboardType: TextInputType.text,
                                      labelText: "Email",
                                      hintText: "Example@gmail.com",
                                      validatorText: "Введите Email"),
                                ),
                                Container(
                                    margin: EdgeInsets.only(bottom: 12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Текст обращения",
                                            style: TextStyle(
                                                color: colorGray,
                                                fontSize: 16.0)),
                                        TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Введите текст";
                                            }
                                            return null;
                                          },
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          maxLines: 5,
                                          controller: TextController,
                                          decoration: InputDecoration(
                                              hintText:
                                                  "Текст Вашего обращения",
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: inputBorder,
                                                      width: 5.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                        )
                                      ],
                                    )),
                                DefaultButton(
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
                                        /*
                                  dynamic message = MessageSend(
                                              cmd: "publish",
                                              subject: "store-${store_id}",
                                              event: "ticket_new",
                                              data: TicketNew(
                                                ticket_theme_id: type, 
                                                contact_name: FioController.text, 
                                                contact_email: EmailController.text, 
                                                user_lk_id: user_id, 
                                                color_type_id: color_type_id, 
                                                count_tm_sender: count_tm_sender, 
                                                date_added: date_added, 
                                                name: name, 
                                                name_theme: name_theme, 
                                                responsible_id: responsible_id, 
                                                status_id: status_id, 
                                                ticket_id: ticket_id),
                                              to_id: int.parse(user_id!)
                                            );
                                String data = jsonEncode(message.toJson());
                                webSocketChannel!.sink.add(data);*/

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
          widget.refrash!.call();
          Navigator.pop(context);
        },
      ).show();
    }
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    webSocketChannel ??= DependencyProvider.of(context)!.webSocketChannel;
    super.didChangeDependencies();
  }
}

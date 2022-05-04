import 'dart:convert';

import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/model/message.dart';
import 'package:conres_app/websocket/message-send.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../DI/dependency-provider.dart';
import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/chat/mesage-row.dart';
import '../model/profile.dart';
import 'package:intl/intl.dart';

class MessagesPage extends StatefulWidget {
  String userId;
  String? ticketId;
  String? page;
  String? lastMessageId;
  String? userName;
  Profile? profile;
  MessagesPage(
      {required this.userId,
      required this.ticketId,
      required this.page,
      required this.lastMessageId,
      required this.profile});
  @override
  State<StatefulWidget> createState() => _MessagesPage();
}

class _MessagesPage extends State<MessagesPage> {
  ProfileBloc? profileBloc;
  List<Widget> messagesList = [];
  List<String> fio = [];
  bool isLoading = true;
  WebSocketChannel? webSocketChannel;
  String lastId = "";
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  String _dateGroupGenerate(String date){
    List<String> splittedDate = date.split('.');
    String? month;
    String? result;
    switch(splittedDate[1]){
      case '01':
        month = "января";
        break;
      case '02':
        month = "февраля";
        break;
      case '03':
        month = "марта";
        break;
      case '04':
        month = "апреля";
        break;
      case '05':
        month = "мая";
        break;
      case '06':
        month = "июня";
        break;
      case '07':
        month = "июля";
        break;
      case '08':
        month = "августа";
        break;
      case '09':
        month = "сентября";
        break;
      case '10':
        month = "октября";
        break;
      case '11':
        month = "ноября";
        break;
      case '12':
        month = "декабря";
        break;
    }
    result = '${splittedDate[0]} $month, ${splittedDate[2]}';
    return result;
  }
  void _send() {
    profileBloc!.sendMessage(widget.ticketId!, controller.text, "Открыт");
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
              return Scaffold(
                  body: Stack(
                children: [
                  Visibility(
                      child: Center(
                          child: Container(
                        width: 50,
                        height: 50,
                        child: Image.asset('assets/loading.gif'),
                      )),
                      visible: isLoading),
                  Column(
                    children: [
                      Container(
                          height: 100,
                          child: HeaderNotification(text: "Сообщения")),
                      Expanded(
                          child: Scrollbar(
                              child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          //здесь сообщения
                                          Column(
                                            children: messagesList,
                                          ),
                                        ],
                                      )
                                    ],
                                  )))),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        child: Padding(
                            padding: EdgeInsets.only(left: 18, right: 18),
                            child: Row(
                              children: [
                                GestureDetector(
                                    child: SvgPicture.asset('assets/clip.svg')),
                                const Spacer(),
                                Container(
                                  width: 245,
                                  child: TextField(
                                    controller: controller,
                                    decoration: InputDecoration(
                                        hintText: "Сообщение...",
                                        fillColor: messageColor,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    _send();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(14),
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colorMain,
                                    ),
                                    child: Container(
                                      width: 18,
                                      height: 14,
                                      child: SvgPicture.asset(
                                          'assets/arrow-type2.svg'),
                                    ),
                                  ),
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ],
              ));
            }));
  }

  _listener(BuildContext context, ProfileState state) {
    isLoading = state.loading!;
    if (state.loading == true) {
      return;
    }
    if (state.messages != null) {
      lastId = state.messages!.last.message_id!;
      if (messagesList.isEmpty) {
        for (int i = 0; i < state.messages!.length; i++) {
          messagesList.add(MessageRow(
              text: state.messages![i].message!,
              isOwn:
                  state.messages![i].user_id != widget.userId ? false : true));
        }
        scrollController.position.maxScrollExtent;
      }
    }
    if(state.sendMessageData != null){
      setState(() {
        messagesList.add(MessageRow(text: controller.text, isOwn: true));
        String thisDate = state.sendMessageData!['date_group'];
        String dateGroup = state.sendMessageData!['date_group_name'];
        MessageSend message = MessageSend(
            cmd: "publish",
            subject: "store-3",
            event: "ticket_msg",
            data: Data(
                user_type: "lk",
                user_id: int.parse(widget.userId),
                files: state.sendMessageData!['ticket_message_files'],
                ticket_id: int.parse(widget.ticketId!),
                ticket_info: [
                  TicketInfo(
                      ticket_message_id: state.sendMessageData!['ticket_info'][0]['ticket_message_id'],
                      ticket_id: state.sendMessageData!['ticket_info'][0]['ticket_id'],
                      message: state.sendMessageData!['ticket_info'][0]['message'],
                      data: state.sendMessageData!['ticket_info'][0]['data'],
                      ticket_status_type_id: state.sendMessageData!['ticket_info'][0]['ticket_status_type_id'],
                      model_user: state.sendMessageData!['ticket_info'][0]['model_user'],
                      user_id: state.sendMessageData!['ticket_info'][0]['user_id'],
                      user_name: state.sendMessageData!['ticket_info'][0]['user_name'],
                      date_added: state.sendMessageData!['ticket_info'][0]['date_added'],
                      name: state.sendMessageData!['ticket_info'][0]['name'],
                      color_type_id: state.sendMessageData!['ticket_info'][0]['color_type_id'],
                      last_tm_resiver: state.sendMessageData!['ticket_info'][0]['last_tm_resiver'],
                      files: state.sendMessageData!['ticket_info'][0]['files'])
                ],
                user_info: UserInfo(
                    inn: state.sendMessageData!['user_info']['inn'],
                    firstname: state.sendMessageData!['user_info']['firstname'],
                    lastname: state.sendMessageData!['user_info']['lastname'],
                    patronymic: state.sendMessageData!['user_info']['patronymic'],
                    contacts: Contacts(
                        phone: state.sendMessageData!['user_info']['contacts']['2'], 
                        email: state.sendMessageData!['user_info']['contacts']['3']),
                    href: state.sendMessageData!['user_info']['href']),
                date_group: state.sendMessageData!['date_group'],
                date_group_name: state.sendMessageData!['date_group_name']),
            to_id: int.parse(widget.userId));
        String data = jsonEncode(message.toJson());
        webSocketChannel!.sink.add(data);
        controller.text = "";
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    webSocketChannel ??= DependencyProvider.of(context)!.webSocketChannel;
    fio = widget.profile!.userName!.split(" ");

    profileBloc!
        .getMessages(widget.ticketId!, widget.page!, widget.lastMessageId!);
  }
}
